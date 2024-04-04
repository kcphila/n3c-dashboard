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

function localHorizontalGroupedBarChart(data1, properties) {
	console.log(properties, data1)
	var data = data1;
	if (typeof properties.category !== 'undefined') {
		var data = data1.filter(function(el) {
			return el.cat == properties.category;
		});
	}

	var minX = (typeof properties.minX == "undefined" ? 0.0 : properties.minX);
	var maxX = (typeof properties.maxX == "undefined" ? 1.0 : properties.maxX);
	var barHeight = (typeof properties.barHeight == "undefined" ? 10 : properties.barHeight);
	var barPadding = (typeof properties.barPadding == "undefined" ? 2 : properties.barPadding);

	// set the dimensions and margins of the graph
	var margin = { top: 0, right: 100, bottom: 100, left: 100 },
		width = 960 - margin.left - margin.right,
		height = barHeight * data.length + barPadding * (data.length + 1) + margin.top + margin.bottom;

	//	console.log(data);

	var maxBandWidth = 400; // width of the bar with the max value

	var ${param.block}myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("#" + properties.domName).select("svg").remove();
				width = newWidth - margin.left - margin.right;
				height = barHeight * data.length + barPadding * (data.length + 1) + margin.top + margin.bottom;
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

		categories.append("g")
			.selectAll("rect")
			.data(function(d) { return d.values; })
			.enter().append("rect")
			.attr("class", function(d) {
				return 'secondary lab' + d.key.replace(/[^A-Z0-9]/ig, "");
			})
			.attr('x', function(d) { return x(Math.min(0, d.values[0].shap_abs)); })
			.attr('width', function(d) { return Math.max(1, Math.abs(x(d.values[0].shap_abs) - x(0))); })
			.attr("height", barHeight)
			.attr("fill", function(d, i) { return colorscale[i]; })
			.attr("transform", function(d, i) { return "translate(-375, " + (i * (barHeight + barPadding) + barPadding) + ")"; })
			.on('mousemove', function(d) {
				var value = d.values[0].shap_abs;
				var fill = colorscale[0];

				var percentage = "";

				d3.selectAll(".tooltip").remove();
				d3.select("body").append("div")
					.attr("class", "bar tooltip")
					.style("opacity", 0.8)
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong style='color:  " + fill + ";'>" + d.key + "</strong><br><strong>Count: </strong>" + value + percentage);
			})
			.on('mouseout', function(d) {
				d3.selectAll(".tooltip").remove();
			});


		// draw color key on to decoupled div
		function drawColorKey() {
			d3.select("#" + properties.legendid).html("");
			var legend_div = d3.select("#" + properties.legendid).append("div").attr("class", "row").attr("id", "filters");

			legend_div.selectAll(".legend-title")
				.data([label2])
				.enter().append("div")
				.attr("class", "col col-12")
				.html(function(d) {
					return '<h5><i class="fas fa-filter"></i>   ' + d + ' Legend</h5>';
				});

			var legend_data = legend_div.selectAll(".new_legend")
				.data(legend_label)
				.enter().append("div")
				.attr("class", "filter_col col col-6 col-lg-3")
				.on("click", function(d, i) {
					var format = {};
					format['secondary_name'] = d.secondary;
					window[properties.domName.replace(/_[^_]+_[^_]+$/i, '_').replace('#', '') + 'viz_constrain'](format, label2.replace(/\s/g, ""));
				})
				.html(function(d, i) {
					return '<i class="fas fa-circle" style="color:' + colorscale[d.secondary_seq - 1] + ';"></i> ' + d.secondary;
				});
		};

		drawColorKey();

		// overdraw width and put legend outside of clip path (to only show on download)


		var legend_text = chart.append("g")
			.attr("transform", "translate(" + (width + margin.left + margin.right) + " ," + 0 + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", '14px')
			.attr("font-weight", "bold")
			.attr("text-anchor", "start")
			.append("text")
			.attr("y", 9.5)
			.attr("dy", "0.32em")
			.text(label2);

		var legend = chart.append("g")
			.attr("transform", "translate(" + (width + margin.left + margin.right) + " ," + 0 + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", ".8rem")
			.selectAll("g")
			.data(legend_label)
			.enter().append("g")
			.attr("transform", function(d, i) {
				return "translate(0," + ((i * 20) + 20) + ")";
			});

		legend.append("rect")
			.attr("x", 0)
			.attr("width", 19)
			.attr("height", 19)
			.attr("fill", function(d, i) { return colorscale[i]; });

		legend.append("text")
			.attr("x", 27)
			.attr("y", 9.5)
			.attr("dy", "0.32em")
			.text(function(d) {
				return d.secondary;
			});
	}
};

</script>
