<script>

function localClusteredHeatMap(data, properties) {

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

		var targetKeys = d3.map(target, function(d) { return d.name; }).keys()
		var sourceKeys = d3.map(source, function(d) { return d.name; }).keys()

		var x = d3.scaleBand()
				.range([0, width])
				.domain(targetKeys)
				.padding(0.05),
			y = d3.scaleBand()
				.range([0, height])
				.domain(sourceKeys)
				.padding(0.05),
			z = d3.scaleLinear()
				.range(["white", "blue"])
				.domain([0, d3.max(links, function(d) { return d.value; })]);

		var svg = d3.select("#" + properties.domName)
			.append("svg")
			.attr("width", width + margin.left)
			.attr("height", height + margin.top)
			.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

		function build_payload(link, source, target) {
			return {
				"x": link.target,
				"y": link.source,
				"value": link.value,
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
			matrix[link.source][link.target] = build_payload(link, source[link.source], target[link.target]);
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
			.attr("class", "text")
			.select(".domain").remove();

		svg.append("g")
			.style("font-size", 11)
			.call(d3.axisTop(x).tickSize(0))
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
			.attr("class", "cell")
			.attr("transform", (d, i) => {
				return "translate(" + x(d.target.name) + ", " + y(d.source.name) + ")";
			});

		cell
			.append("rect")
			.attr("width", x.bandwidth() * 0.9)
			.attr("height", y.bandwidth() * 0.9)
			.style("stroke-width", 2)
			.style("stroke", "none")
			.style("fill", function(d) { return z(d.value) })
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
						+ "<br>Count: " + d.value)
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

	}
}
</script>
