<style>
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

function localHorizontalBarChart(data, properties) {
	// set the dimensions and margins of the graph
	var margin = { top: 0, right: 100, bottom: 100, left: 100 },
		width = 960 - margin.left - margin.right,
		height = 600 - margin.top - margin.bottom;
	
	var valueLabelWidth = 80; // space reserved for value labels (right)
	var barHeight = 40; // height of one bar
	var barLabelPadding = 5; // padding between bar and bar labels (left)
	var gridLabelHeight = 0; // space reserved for gridline labels
	var gridChartOffset = 3; // space between start of grid and first bar
	var maxBandWidth = 400; // width of the bar with the max value

	//accessor functions
	var barLabel = function(d) { return d.element; };
	var barValue = function(d) { return parseFloat(d.value); };
	
	if ((properties.ordered != undefined) && (properties.ordered == 1) ){
		data.sort(function(a, b) {
		    return parseFloat(b.value) - parseFloat(a.value);
		});
	}
	
	var original = d3.select(properties.domName).node();
	var newnode = original.cloneNode();
    original.parentNode.replaceChild(newnode, original);
	
	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = $(properties.domName).width();
			if (newWidth > 0) {
				d3.select(properties.domName).select("svg").remove();
				maxBarWidth = newWidth - properties.barLabelWidth - barLabelPadding - valueLabelWidth;
				draw_bar();
			}
		});
	});

	myObserver.observe(d3.select(properties.domName).node());
 	
 	draw_bar();

	function draw_bar() {
		
		// scales
		var yScale = d3.scaleBand()
						.domain(d3.range(0, data.length))
						.range([0, data.length * barHeight]);
		var y = function(d, i) { return yScale(i); };
		var yText = function(d, i) { return y(d, i) + yScale.bandwidth() / 2; };
		var x = d3.scaleLinear()
					.domain([Math.min(0, d3.min(data,function(d) {return d.value})), d3.max(data, function(d) {return d.value})])
					.range([properties.bandLabelWidth, properties.bandLabelWidth + maxBandWidth]);
		// svg container element
		var chart = d3.select(properties.domName).append("svg")
			.attr('width', $(properties.domName).width())
			.attr('height', gridLabelHeight + gridChartOffset + data.length * barHeight + margin.top + margin.bottom);
		chart.append("g")
		.attr("transform", "translate(" + properties.bandLabelWidth + "," + 0 + ")")
		.call(d3.axisLeft(yScale).tickFormat(function(d, i) {return data[i].element }).tickSize(2))

		chart.append("g")
		.attr("transform", "translate(0," + data.length * barHeight + ")")
		.call(d3.axisBottom(x).ticks(5))
		// Add X axis label:
		chart.append("text")
			.attr("text-anchor", "middle")
			.attr("x", maxBandWidth / 2 + properties.bandLabelWidth)
			.attr("y", data.length * barHeight + margin.top + 40)
			.text(properties.xaxis_label);

		// grid line labels
		var gridContainer = chart.append('g')
			.attr('transform', 'translate(' + properties.barLabelWidth + ',' + gridLabelHeight + ')');
		
		// bars
		var barsContainer = chart.append('g')
			.attr('transform', 'translate(' + properties.barLabelWidth + ',' + (gridLabelHeight + gridChartOffset) + ')');
		barsContainer.selectAll("rect").data(data).enter().append("rect")
			.attr('y', y)
			.attr('x', function(d) { return x(Math.min(0, d.value)); })
			.attr('height', yScale.bandwidth())
			.attr('width', function(d) { return Math.abs(x(d.value) - x(0)); })
			.attr('stroke', 'white')
			.attr('fill', function(d) { return "blue"})
			.on('mousemove', function(d){
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
				.attr("class", "bar tooltip")
				.style("opacity", 0.8)
				.style("left", (d3.event.pageX + 5) + "px")
				.style("top", (d3.event.pageY - 28) + "px")
				.html("<strong>" + d.element + "</strong><br><strong>Value:</strong> " + d.value.toLocaleString());
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
			});

	}
}
</script>
