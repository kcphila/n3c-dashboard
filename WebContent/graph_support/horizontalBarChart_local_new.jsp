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

function localHorizontalBarChart_new(data, properties) {
	
	console.log(properties.domName);
	
	var valueLabelWidth = 80; // space reserved for value labels (right)
	var barHeight = 20; // height of one bar
	var barLabelPadding = 5; // padding between bar and bar labels (left)
	var gridLabelHeight = 0; // space reserved for gridline labels
	var gridChartOffset = 3; // space between start of grid and first bar
	var maxBarWidth = 280; // width of the bar with the max value

	//accessor functions
	var barLabel = function(d) { return d.abbrev; };
	var barValue = function(d) { return parseFloat(d.count); };
	
	if ((properties.ordered != undefined) && (properties.ordered == 1) ){
		data.sort(function(a, b) {
		    return parseFloat(b.count) - parseFloat(a.count);
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
		var yScale = d3.scaleBand().domain(d3.range(0, data.length)).range([0, data.length * barHeight]);
		var y = function(d, i) { return yScale(i); };
		var yText = function(d, i) { return y(d, i) + yScale.bandwidth() / 2; };
		var x = d3.scaleLinear().domain([0, d3.max(data, barValue)]).range([0, maxBarWidth]);
		
		
		// svg container element
		var chart = d3.select(properties.domName).append("svg")
			.attr('width', $(properties.domName).width())
			.attr('height', gridLabelHeight + gridChartOffset + data.length * barHeight);
		// grid line labels
		var gridContainer = chart.append('g')
			.attr('transform', 'translate(' + properties.barLabelWidth + ',' + gridLabelHeight + ')');
		
		
		var labelsContainer = chart.append('g')
			.attr('transform', 'translate(' + (properties.barLabelWidth - barLabelPadding) + ',' + (gridLabelHeight + gridChartOffset) + ')');
		labelsContainer.selectAll('text').data(data).enter().append('text')
			.attr('y', yText)
			.attr('stroke', 'none')
			.attr('fill', '#3c3c3d')
			.attr("dy", ".35em") // vertical-align: middle
			.attr('text-anchor', 'end')
			.text(barLabel)
			.on('mousemove', function(d){
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
				.attr("class", "bar tooltip")
				.style("opacity", 0.8)
				.style("left", (d3.event.pageX + 5) + "px")
				.style("top", (d3.event.pageY - 28) + "px")
				.html(d.element);
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
			});
		
		// bars
		var barsContainer = chart.append('g')
			.attr('transform', 'translate(' + properties.barLabelWidth + ',' + (gridLabelHeight + gridChartOffset) + ')');
		barsContainer.selectAll("rect").data(data).enter().append("rect")
			.attr('y', y)
			.attr('rx', 2)
			.attr('height', yScale.bandwidth())
			.attr('width', function(d) { return 0;})
			.attr('stroke', 'white')
			.attr('fill', function(d) { return properties.colorscale[(d.seq-1)];})
			.on("click", function(d, i){
				d3.selectAll(".tooltip").remove(); 
				var format = {};
				format['secondary_name'] = d.element;
				window[properties.domName.replace(/_[^_]+_[^_]+$/i,'_').replace('#', '')+'viz_constrain'](format, properties.legend_label.replace(/\s/g, "")); 
			})
			.on('mousemove', function(d){
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
				.attr("class", "bar tooltip")
				.style("opacity", 0.8)
				.style("left", (d3.event.pageX + 5) + "px")
				.style("top", (d3.event.pageY - 28) + "px")
				.html("<strong>" + d.element + "</strong><br><strong>Count:</strong> " + d.count.toLocaleString());
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
			});
		

		barsContainer.selectAll('rect')
			.transition().duration(1000)
			.attr('width', function(d) { return x(barValue(d)); });
			

		// bar value labels
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
		
		barsContainer.selectAll("text").data(data).enter().append("text")
			.attr("x", function(d) { return x(barValue(d)); })
			.attr("y", yText)
			.attr("dx", 3) // padding-left
			.attr("dy", ".35em") // vertical-align: middle
			.attr("text-anchor", "start") // text-align: right
			.attr("fill", "#3c3c3d")
			.attr("stroke", "none")
			.text(function(d) { return nFormatter(barValue(d), 2); });

	}
}
</script>
