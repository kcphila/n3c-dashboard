<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.axis .domain {
	display: none;
}

.tick line{
  visibility:hidden;
}

.graph_tooltip{
	pointer-events:none;
}

div.bar.tooltip {
	position: absolute;
	background-color: white;
  	opacity: 0.8;
  	height: auto;
	padding: 1px;
  	pointer-events: none;
}
</style>

<script>

function OddsRatioGroupedChart(data1, properties) {
	console.log(properties, data1)
	var data = data1;
	if (typeof properties.category !== 'undefined') {
		var data = data1.filter(function(el) {
			return el.cat == properties.category;
		});
	}

	var minX = (typeof properties.minX == "undefined" ? 0.0 : properties.minX);
	var maxX = (typeof properties.maxX == "undefined" ? 1.0 : properties.maxX);
	var whiskerHeight = (typeof properties.symbolSize == "undefined" ? 10 : properties.symbolSize * 2);
	var whiskerGap = (typeof properties.whiskerGap == "undefined" ? 2 : properties.whiskerGap);

	// set the dimensions and margins of the graph
	var margin = { top: 0, right: 100, bottom: 100, left: 100 },
		width = 960 - margin.left - margin.right,
		height = whiskerHeight * data.length + whiskerGap * (data.length + 1) + margin.top + margin.bottom;

	//	console.log(data);

	var maxBandWidth = 400; // width of the bar with the max value

	var ${param.block}myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("#" + properties.domName).select("svg").remove();
				width = newWidth - margin.left - margin.right;
				height = whiskerHeight * data.length + whiskerGap * (data.length + 1) + margin.top + margin.bottom;
				draw_bar();
			}
		});
	});

	${param.block}myObserver.observe(d3.select("#" + properties.domName).node());

	//
	// some of the logic for this one is syntactically messy, so we'll just stage things here...
	//
	var primary = properties.primary;
	var secondary = properties.secondary;
	var count = properties.count;
	var legend_label = properties.legend_label;
	var colorscale = properties.colorscale;
	var label2 = properties.label2;

	var setup_data = d3.nest()
		.key(function(d) { return d[primary]; })
		.entries(data);

	var secondary_list = [];

	if (setup_data.length > 0) {
		setup_data.forEach(function(test) {
			var unique = [];
			test.values.forEach(function(vals) {
				if (!unique.includes(vals[secondary])) {
					unique.push(vals[secondary]);
				};
			})
			secondary_list = secondary_list.concat(unique);
		});
	};
	
	function draw_bar() {

		var groupedData = d3.nest()
			.key(function(d) { return d[primary]; })
			.key(function(d) { return d[secondary]; })
			.entries(data);

		var abbrev = d3.nest()
			.key(function(d) { return d[primary]; })
			.key(function(d) { return d[primary + "_abbrev"]; })
			.rollup(function(v) { })
			.entries(data);

		var category_labels = [];
		var cumulative = 0;
		groupedData.forEach(function(d) {
			var full = d.key;
			var ab = abbrev.find(item => item.key === full);
			d.abbrev = ab.values[0].key;
			d.cumulative = cumulative;
			cumulative += d.values.length;
			category_labels.push(d.key);
		});

		var bar_color = d3.scaleOrdinal()
			.range(["#f1f1f1", "white"])
			.domain(category_labels);

		var chart = d3.select("#" + properties.domName).append("svg")
			.attr("class", "clear_target")
			.attr("width", width + margin.left + margin.right)
			.attr("height", height + margin.top + margin.bottom)
			.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

		// Show the Y scale
		var y = d3.scaleBand()
			.range([0, height])
			.domain(d3.range(0, groupedData.length))
			.padding(.4);

		//////// Bars ///////////////
		var g = chart.append("g")
			.attr("transform", "translate(" + properties.bandLabelWidth + "," + 0 + ")");

		var categories = g.selectAll(".categories")
			.data(groupedData)
			.enter().append("g")
			.attr("class", function(d) {
				return 'category category-' + d.key.replace(/\s+/g, '');
			})
			.attr("transform", function(d, i) {
				return "translate(0, " + (y(i) - y.bandwidth() / 2) + ")";
			});

		categories.append("rect")
			.style("fill", function(d) {
				return bar_color(d.key);
			})
			.attr("height", function(d) {
				return (y.bandwidth() * 2);
			})
			.attr("width", maxBandWidth);

		chart.append("g")
			.attr("transform", "translate(" + properties.bandLabelWidth + "," + 0 + ")")
			.call(d3.axisLeft(y).tickFormat(function(d, i) { return groupedData[i].key }).tickSize(2))

		// Show the X scale
		var x = d3.scaleLinear()
			.domain([minX, maxX])
			.range([properties.bandLabelWidth, properties.bandLabelWidth + maxBandWidth])
		chart.append("g")
			.attr("transform", "translate(0," + height + ")")
			.call(d3.axisBottom(x).ticks(5))

		// Add X axis label:
		chart.append("text")
			.attr("text-anchor", "middle")
			.attr("x", maxBandWidth / 2 + properties.bandLabelWidth)
			.attr("y", height + margin.top + 40)
			.text(properties.xaxis_label);

		// Show the divider line
		chart
			.selectAll("divider")
			.data(data)
			.enter()
			.append("line")
			.attr("x1", function(d) { return (properties.mode == 'hazard' ? x(0.0) : x(1.0)) })
			.attr("x2", function(d) { return (properties.mode == 'hazard' ? x(0.0) : x(1.0)) })
			.attr("y1", function(d) { return (0.0) })
			.attr("y2", function(d) { return height; })
			.style("stroke-dasharray", ("3, 3"))
			.attr("stroke", "black")
		.style("width", 40)

		// Show the main horizontal line
		categories.append("g")
			.selectAll("horizLines")
			.data(function(d) { return d.values; })
			.enter()
			.append("line")
			.attr("x1", function(d,i) { return (x(d.values[0].conf_low)) })
			.attr("x2", function(d) { return (x(d.values[0].conf_high)) })
			.attr("y1", function(d) { return 0; })
			.attr("y2", function(d) { return 0; })
			.attr("transform", function(d, i) { return "translate(-" + properties.bandLabelWidth + ", " + (i * (whiskerHeight + whiskerGap) + whiskerHeight/2 + whiskerGap) + ")"; })
			.attr("stroke", "black")
			.attr("stroke-width", '2.8px')
			.style("width", 40)
	
		// Show the left whisker
		categories.append("g")
			.selectAll("leftWhisker")
			.data(function(d) { return d.values; })
			.enter()
			.append("line")
			.attr("x1", function(d) { return (x(d.values[0].conf_low)) })
			.attr("x2", function(d) { return (x(d.values[0].conf_low)) })
			.attr("y1", function(d) { return -whiskerHeight/2; })
			.attr("y2", function(d) { return whiskerHeight/2; })
			.attr("transform", function(d, i) { return "translate(-" + properties.bandLabelWidth + ", " + (i * (whiskerHeight + whiskerGap) + whiskerHeight/2 + whiskerGap) + ")"; })
			.attr("stroke", "black")
			.style("width", 40)

		// Show the right whisker
		categories.append("g")
			.selectAll("rightWhisker")
			.data(function(d) { return d.values; })
			.enter()
			.append("line")
			.attr("x1", function(d) { return (x(d.values[0].conf_high)) })
			.attr("x2", function(d) { return (x(d.values[0].conf_high)) })
			.attr("y1", function(d) { return -whiskerHeight/2; })
			.attr("y2", function(d) { return whiskerHeight/2; })
			.attr("transform", function(d, i) { return "translate(-" + properties.bandLabelWidth + ", " + (i * (whiskerHeight + whiskerGap) + whiskerHeight/2 + whiskerGap) + ")"; })
			.attr("stroke", "black")
			.style("width", 40)

		// glyph for the main symbol
		switch (properties.mode) {
			case "hazard":
				categories.append("g")
					.selectAll("rects")
					.data(function(d) { return d.values; })
					.enter()
	 			   .append("rect")
	        		.attr("x", function(d){return x(d.values[0].estimate) - properties.symbolSize})
	        		.attr("width", function(d){return properties.symbolSize * 2})
					.attr("y", function(d) { return 0; })
					.attr("transform", function(d, i) { return "translate(-" + properties.bandLabelWidth + ", " + (i * (whiskerHeight + whiskerGap) + whiskerHeight/2 + whiskerGap) + ")"; })
	        		.attr("height", properties.symbolSize * 2 )
	        		.attr("stroke", "black")
	        		.style("fill", "#69b3a2")
	        		.style("opacity", 0.3)
				break;
			case "odds":
			default:
				categories.append("g")
					.selectAll("circles")
					.data(function(d) { return d.values; })
					.enter()
					.append("circle")
					.attr("cx", function(d) { return (x(d.values[0].estimate)); })
					.attr("r", function(d) { return (properties.symbolSize); })
					.attr("cy", function(d) { return 0; })
					.attr("transform", function(d, i) { return "translate(-" + properties.bandLabelWidth + ", " + (i * (whiskerHeight + whiskerGap) + whiskerHeight/2 + whiskerGap) + ")"; })
					.attr("stroke", "black")
					.style("fill", "#69b3a2")
					.style("opacity", 0.8)
				break;
		}

	}		
};

</script>
