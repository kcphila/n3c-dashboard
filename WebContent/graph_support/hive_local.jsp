<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!-- /* Code adapted from https://bost.ocks.org/mike/hive/ 's simple example- for use with d3v4' */ -->

<style>

	.axis_line {
	  stroke: #000;
	  stroke-width: 1.5px;
	}

	.link {
	  fill: none;
	  stroke-width: 1.5px;
	}
	
	.link.active {
	  stroke: red;
	  stroke-width: 5px;
	  stroke-opacity: 1;
	}
	
	.node {
	  stroke: #000;
	  stroke-width: 1.5px;
	}

	.node.active {
	  stroke: red;
	  stroke-width: 3px;
	}
div.tooltip {
    position: absolute;
    background-color: white;
    opacity: 0.8;
    height: auto;
    padding: 1px;
    pointer-events: none;
  }
</style>
<script src="../resources/d3.hive.min.js"></script>
<script>
	function localHiveChart(properties) {
		// console.log("properties", properties);
	
		d3.json(properties.feed_path, function(error, data) {
			if (error) throw error;
	
			var margin = { top: 150, right: 150, bottom: 0, left: 20 };
			var width = window.innerWidth,
				height = window.innerHeight,
				innerRadius = 40,
				outerRadius = 400;
			var word_length = 50;
		
			var myObserver = new ResizeObserver(entries => {
				entries.forEach(entry => {
					var newWidth = Math.floor(entry.contentRect.width);
					if (newWidth > 0) {
						d3.select("#" + properties.domName).select("svg").remove();
						width = newWidth / properties.scaling + margin.left + margin.right;
						height = newWidth / properties.scaling + margin.top + margin.bottom;
						outerRadius = width / properties.scaling - margin.left - margin.right;
						innerRadius = outerRadius / 10;
						draw();
		
						// console.log('width', width);
		
					}
				});
			});
		
			myObserver.observe(d3.select("#" + properties.domName).node());
		
			draw();
		
		
			function draw() {
				// console.log("drawing", width)
		
				var nodes = data.nodes;
				var node_map = d3.map(nodes, d => d.mapping);
				// console.log("nodes", nodes);
				// console.log("map", node_map.get("0-1"));
		
				var links = data.edges;
		
				var nodeScale = d3.scaleLinear()
					.domain([0, d3.max(nodes, function(d) { return d.weight; })])
					.range([2, 15]);
		
				var linkScale = d3.scaleLinear()
					.domain([0, d3.max(links, function(d) { return d.weight; })])
					.range([0.15, 1]);
		
				var groupings = d3.max(nodes, function(d) { return d.x; }) + 1; ///number of groups
		
				var angle = d3
					.scalePoint()
					.domain(d3.range(groupings + 1))
					.range([0, 2 * Math.PI]),
					radius = d3.scaleLinear().range([innerRadius, outerRadius]),
					color = d3.scaleOrdinal(d3.schemeCategory10).domain(d3.range(20));
		
				var svg = d3
					.select("#" + properties.domName)
					.append("svg")
					.attr("width", width)
					.attr("height", height)
					.append("g")
					.attr("transform", "translate(" + (width / 2) + "," + (height / 2) + ")");
		
				svg
					.selectAll(".axis")
					.data(d3.range(groupings))
					.enter()
					.append("line")
					.attr("class", "axis_line")
					.attr("transform", function(d) {
						return "rotate(" + degrees(angle(d)) + ")";
					})
					.attr("x1", radius.range()[0])
					.attr("x2", radius.range()[1]);
		
				svg
					.selectAll(".link")
					.data(links)
					.enter()
					.append("path")
					.attr("class", "link")
					.attr(
						"d",
						d3.hive
							.link()
							.angle(function(d) {
								return angle(node_map.get(d).x);
							})
							.radius(function(d) {
								return radius(node_map.get(d).y);
							})
					)
					.on("mouseover", linkMouseover)
					.on("mouseout", mouseout)
					.style("stroke", function(d) {
						var split = d.source.split("-");
						var dimension =  parseInt(split[0]);
						var value = parseInt(split[1]);
						return properties.color[dimension][value-1];
					})
					.style("stroke-opacity", function(d) {
						return linkScale(d.weight);
					});
		
		
				svg
					.selectAll(".node")
					.data(nodes)
					.enter()
					.append("circle")
					.attr("class", "node")
					.on("click", function(d) {
						// console.log("click", d, properties.domTarget, data.axes[d.x]);
						$('#selectMe').val(properties.domTarget).trigger('change');
						setTimeout(() => { // need to wait for the dust to settle before targeting the sub-select
							$('#'+properties.domTarget+'toggle_viz_select').val(data.axes[d.x].toLowerCase()).trigger('change');
						}, 1000);
					})
					.on("mouseover", function(d) {
						// console.log(d);
						d3.select("body").append("div")
							.attr("class", "tooltip")
							.style("opacity", 1)
							.style("left", (d3.event.pageX + 5) + "px")
							.style("top", (d3.event.pageY - 28) + "px")
							.html(d.label + "<br />" + d.weight.toLocaleString());
		
						svg.selectAll(".link").classed("active", function(p) {
							return p.source === d.mapping || p.target === d.mapping;
						});
						d3.select(this).classed("active", true);
					})
					.on("mouseout", function(d) {
						svg.selectAll(".active").classed("active", false);
						d3.selectAll(".tooltip").remove();
					})
					.attr("transform", function(d) {
						return "rotate(" + degrees(angle(d.x)) + ")";
					})
					.attr("cx", function(d) {
						return radius(d.y);
					})
					.attr("r", function(d) {
						return nodeScale(d.weight);
					})
					.style("fill", function(d) {
						var split = d.mapping.split("-");
						var dimension =  parseInt(split[0]);
						var value = parseInt(split[1]);
						return properties.color[dimension][value-1];
					})
					;
		
				var legend_text = svg
					.selectAll("labels")
					.data(d3.range(groupings))
					.enter()
					.append("g")
					.attr("transform", function(d) {
						return "rotate(" + degrees(angle(d)) + ") translate(" + radius(1.2) + ",0)";
					})
					.attr("x1", radius.range()[0])
					.attr("x2", radius.range()[1])
					.attr("font-family", "sans-serif")
					.attr("font-size", '24px')
					.attr("font-weight", "bold")
					.attr("text-anchor", "middle")
					.append("text")
					.attr("transform", function(d) {
						return "rotate(" + -degrees(angle(d)) + ")";
					})
					.text(function(d) { return data.axes[d] });
		
				function degrees(radians) {
					return radians / Math.PI * 180 - 90;
				}
		
				// Highlight the link and connected nodes on mouseover.
				function linkMouseover(d) {
					svg.selectAll(".link").classed("active", function(p) {
						return p === d;
					});
					svg.selectAll(".node").classed("active", function(p) {
						return p.mapping === d.source || p.mapping === d.target;
					});
				}
		
				// Highlight the node and connected links on mouseover.
				function nodeMouseover(d) {
					svg.selectAll(".link").classed("active", function(p) {
						return p.source === d.mapping || p.target === d.mapping;
					});
					d3.select(this).classed("active", true);
				}
		
				// Clear any highlighted nodes or links.
				function mouseout() {
					svg.selectAll(".active").classed("active", false);
				}
		
			};
		});
	
	}
</script>
