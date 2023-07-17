<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

function ${param.namespace}_localHeatMap(data, properties) {

	d3.json(properties.feed_url, function(error, theGraph) {
		graph = theGraph;
		console.log(graph)

		var source = graph.nodes.filter(function(site, i) {
			if (site.group == properties.source_label) {
				site.index = i;
				return true;
			}
			return false;
		});

		var target = graph.nodes.filter(function(site, i) {
			if (site.group == properties.target_label) {
				site.index = i - source.length;
				return true;
			}
			return false;
		});

		var links = graph.links.filter(function(site, i) {
			site.target = site.target - source.length;
			return true;
		});

		console.log(properties.source_label, source);
		console.log(properties.target_label, target);
		console.log("links", links);

		draw(properties.cell_size, source, target, links);
	});

	function draw(cell_size, source, target, links) {
		var margin = properties.margin,
			width = cell_size * target.length,
			height = cell_size * source.length;

		var sourceKeys_by_name = d3.map(source, function(d) { return d.name; }).keys()
		var targetKeys_by_name = d3.map(target, function(d) { return d.name; }).keys()

		console.log("source keys by name", sourceKeys_by_name)
		console.log("target keys by name", targetKeys_by_name)

		var source_map = d3.map(source, d => d.index);
		var target_map = d3.map(target, d => d.index);
		// console.log("nodes", nodes);
		console.log("source map", source_map.get(2));
		
 		source.sort(function(x, y){
			return y.score - x.score;
		});
		
 		target.sort(function(x, y){
			return y.score - x.score;
		});
		
		source.filter(function(site,i) { site.new_index = i; return true; })
		console.log("source sorted", source);

		target.filter(function(site,i) { site.new_index = i; return true; })
		console.log("target sorted", target);

		var sourceKeys_by_freq = d3.map(source, function(d) { return d.name; }).keys()
		var targetKeys_by_freq = d3.map(target, function(d) { return d.name; }).keys()

		console.log("source keys by frequency", sourceKeys_by_freq)
		console.log("target keys by frequency", targetKeys_by_freq)

		var x = d3.scaleBand()
				.range([0, width])
				.domain(targetKeys_by_name)
				.padding(0.05),
			y = d3.scaleBand()
				.range([0, height])
				.domain(sourceKeys_by_name)
				.padding(0.05),
			z = d3.scaleLinear()
				.range(["white", "blue"])
				.domain([0, d3.max(links, function(d) { return d.value; })]),
				color = d3.scaleOrdinal(d3.schemeCategory10).domain(d3.range(20));

		var svg = d3.select("#" + properties.domName)
			.append("svg")
			.attr("width", width + margin.left)
			.attr("height", height + margin.top)
			.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

		function build_payload(link, source, target) {
			console.log(source, source.Louvain10, "target", target.Louvain10);
			return {
				"x": link.target,
				"y": link.source,
				"value": link.value,
				"cluster": source.Louvain10,
				"source": source,
				"target": target
			};
		};
		
		var matrix = new Array(source.length);
		
		for (var i = 0; i < matrix.length; i++) {
			matrix[i] = new Array(target.length);
			for (var j = 0; j > matrix[i].length; j++)
				matrix[i][j] = 0;
		}

		links.forEach(function(link) {
			//console.log(link, source[link.source], target[link.target]);
			matrix[source_map.get(link.source).index][target_map.get(link.target).index] = build_payload(link, source_map.get(link.source), target_map.get(link.target));
		});
		console.log("matrix", matrix);

		var tooltip = d3.select("body").append("div")
			.attr("id", "tooltip")
			.style("opacity", 0)
			.style('font-size', '11px');

		svg.append("rect")
			.attr("class", "background")
			.attr("width", width)
			.attr("height", height);

		svg.append("g")
			.style("font-size", 11)
			.call(d3.axisLeft(y).tickSize(0))
			.attr("class", "y_axis")
			.attr('stroke-width', 0)
			.select(".domain").remove();

		svg.append("g")
			.style("font-size", 11)
			.call(d3.axisTop(x).tickSize(0))
			.attr("class", "x_axis")
			.attr('stroke-width', 0)
			.selectAll("text")
			.style("text-anchor", "start")
			.attr("class", "cell_text")
			.attr("dx", 6)
			.attr("dy", x.bandwidth() / 2)
			.attr("transform", "rotate(-90)")
			.select(".domain").remove();

		const row = svg
			.selectAll(".row")
			.data(matrix)
			.enter()
			.append("g")
			.attr("class", "row");

		const cell = row
			.selectAll(".cell")
			.data((d) => {
				return d;
			})
			.enter()
			.append("g")
			.attr("class", "cell");

		cell
			.append("rect")
			.attr("class", "cell_block")
			.attr("x", function (d) { return x(d.target.name); })
			.attr("y", function (d) { return y(d.source.name); })
			.attr("width", x.bandwidth() * 0.9)
			.attr("height", y.bandwidth() * 0.9)
			.style("stroke-width", 2)
			.style("stroke", "none")
			.style("fill", function(d) { return color(d.cluster) })
			.on("mouseover", function(d) {
				//console.log("in",d);
				d3.selectAll(".row text").classed("active", function(e, i) { return d.source.name == e; });
				d3.selectAll(".cell_text").classed("active", function(e, i) { return d.target.name == e; });
				tooltip
					.style("opacity", 1);
				d3.select(this)
					.style("stroke", "black")
					.style("opacity", 1);
			}
			)
			.on("mousemove", function(d) {
				//console.log("move",d);
				tooltip
					.html(properties.source_tooltip_label + ": " + d.source.name
						+ "<br>" + properties.target_tooltip_label + ": " + d.target.name
						+ "<br>Count: " + nFormatter(d.value,2))
					.style("left", (d3.event.pageX + 10) + 'px')
					.style("top", (d3.event.pageY + 10) + 'px');
			}
			)
			.on("mouseleave", function(d) {
				//console.log("out",d);
				d3.selectAll("text").classed("active", false);
				tooltip
					.style("opacity", 0);
				d3.select(this)
					.style("stroke", "none")
					.style("opacity", 0.8);
			}
			);

 		d3.select("#${param.basename}_order").node().addEventListener("change", function(d) { ${param.namespace}_order(d3.select("#${param.basename}_order").node().value); });
 
		function ${param.namespace}_order(value) {
			switch (value) {
			case "frequency":
				//console.log("frequency", value);
				x.domain(targetKeys_by_freq);
				y.domain(sourceKeys_by_freq);
				break;
			default:
				//console.log("name", value);
				x.domain(targetKeys_by_name);
				y.domain(sourceKeys_by_name);
				break;
			}
			svg.transition().duration(2500)
				.selectAll("g.y_axis")
				.call(d3.axisLeft(y));
			svg.transition().duration(2500)
				.selectAll("g.x_axis")
				.call(d3.axisTop(x));
			cell.transition().duration(2500)
				.selectAll(".cell_block")
				.attr("x", function (d) { return x(d.target.name); })
				.attr("y", function (d) { return y(d.source.name); })
				;
		}

		function nFormatter(num, digits) {
			  const lookup = [
			    { value: 1, symbol: "" },
			    { value: 1e3, symbol: "k" },
			    { value: 1e6, symbol: "M" },
			    { value: 1e9, symbol: "G" },
			    { value: 1e12, symbol: "T" },
			    { value: 1e15, symbol: "P" },
			    { value: 1e18, symbol: "E" }
			  ];
			  const rx = /\.0+$|(\.[0-9]*[1-9])0+$/;
			  var item = lookup.slice().reverse().find(function(item) {
			    return num >= item.value;
			  });
			  return item ? (num / item.value).toFixed(digits).replace(rx, "$1") + item.symbol : "0";
			}
		
	}
}
</script>
