<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
var valueLabelWidth = 80; // space reserved for value labels (right)
var barHeight = 20; // height of one bar
var barLabelPadding = 5; // padding between bar and bar labels (left)
var barLabelWidth = 260; // padding between bar and bar labels (left)
var gridLabelHeight = 0; // space reserved for gridline labels
var gridChartOffset = 3; // space between start of grid and first bar
var maxBarWidth = 280; // width of the bar with the max value
var ${param.block}domName = '#${param.block}'; // width of the bar with the max value


//accessor functions
var barLabel = function(d) { return d.label; };
var barValue = function(d) { return parseFloat(d.patient_count); };

	
// read json data
d3.json("<util:applicationRoot/>/new_ph/environmental/feeds/${param.feed}.jsp", function(error, data_full) {
	
	${param.block}data = data_full.rows;
	
	var ${param.block}_myObserver2 = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select(${param.block}domName).select("svg").remove();
				maxBarWidth = newWidth - barLabelWidth - barLabelPadding - valueLabelWidth;
				${param.block}draw_bar_rate();
			}
		});
	});
	
	${param.block}_myObserver2.observe(d3.select('#${param.block}').node());

	${param.block}data.sort(function(a, b) {
		return parseFloat(a.label_seq) - parseFloat(b.label_seq);
	});
	
	function ${param.block}draw_bar_rate() {
		// scales
		var yScale = d3.scaleBand().domain(d3.range(0, ${param.block}data.length)).range([0, ${param.block}data.length * barHeight]);
		var y = function(d, i) { return yScale(i); };
		var yText = function(d, i) { return y(d, i) + yScale.bandwidth() / 2; };
		var x = d3.scaleLinear().domain([0, d3.max(${param.block}data, barValue)]).range([0, maxBarWidth]);
		
		// svg container element
		var chart = d3.select(${param.block}domName).append("svg")
			.attr('width', $(${param.block}domName).width())
			.attr('height', gridLabelHeight + gridChartOffset + ${param.block}data.length * barHeight);
		// grid line labels
		var gridContainer = chart.append('g')
			.attr('transform', 'translate(' + barLabelWidth + ',' + gridLabelHeight + ')');
		
		var labelsContainer = chart.append('g')
			.attr('transform', 'translate(' + (barLabelWidth - barLabelPadding) + ',' + (gridLabelHeight + gridChartOffset) + ')');
		
		labelsContainer.selectAll('text').data(${param.block}data).enter().append('text')
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
		
		var svgDefs = chart.append('defs');
	
	       var mainGradient = svgDefs.append('linearGradient')
	           .attr('id', 'mainGradient')
	           .attr('x1', '0%')
	 			.attr('x2', '0%')
	 			.attr('y1', '100%')
	 			.attr('y2', '0%');
	
	       // Create the stops of the main gradient.
	       mainGradient.append('stop')
	           .style('stop-color', "#0256b0")
	           .attr('offset', '0');
	
	       mainGradient.append('stop')
	           .style('stop-color', "#007bff")
	           .attr('offset', '99%');
		
		// bars
		var barsContainer = chart.append('g')
			.attr('transform', 'translate(' + barLabelWidth + ',' + (gridLabelHeight + gridChartOffset) + ')');
		barsContainer.selectAll("rect").data(${param.block}data).enter().append("rect")
			.attr('y', y)
			.attr('rx', 2)
			.attr('height', yScale.bandwidth())
			.attr('width', function(d) { return 0;})
			.attr('stroke', 'white')
			.attr('fill', "#4e5557")
			.on('mousemove', function(d){
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
				.attr("class", "bar tooltip")
				.style("opacity", 0.8)
				.style("left", (d3.event.pageX + 5) + "px")
				.style("top", (d3.event.pageY - 28) + "px")
				.html("<strong>" + d.label + "</strong><br><strong>Total Patients:</strong> " + d.total.toLocaleString() + "<br><strong>Total Mortalities:</strong> " + d.mortality.toLocaleString() + "<br><strong>Percent:</strong> " + d.patient_display.toLocaleString() +"%");
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
		
		barsContainer.selectAll("text").data(${param.block}data).enter().append("text")
			.attr("x", function(d) { return x(barValue(d)); })
			.attr("y", yText)
			.attr("dx", 3) // padding-left
			.attr("dy", ".35em") // vertical-align: middle
			.attr("text-anchor", "start") // text-align: right
			.attr("fill", "#3c3c3d")
			.attr("stroke", "none")
			.text(function(d) { return nFormatter(barValue(d), 2) + "%"; });
		
	}
})
	
	



</script>