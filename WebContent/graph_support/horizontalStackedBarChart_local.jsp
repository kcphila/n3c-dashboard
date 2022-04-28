<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.axis .domain {
	display: none;
}

.tick line{
  visibility:hidden;
}

rect{
	cursor: auto;
}

.graph_tooltip{
	pointer-events:none;
}

</style>
<script>

function localHorizontalStackedBarChart(data, domName, barLabelWidth) {

	var margin = { top: 10, right: 10, bottom: 10, left: barLabelWidth },
		width = 1200 - margin.left - margin.right,
		height = width/2 - margin.top - margin.bottom;
	var maxBarWidth = 280; // width of the bar with the max value
	var valueLabelWidth = 50; // space reserved for value labels (right)
	var barLabelPadding = 5; // padding between bar and bar labels (left)
	var barLowerPadding = 100;

	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("#"+domName).select("svg").remove();
				width = newWidth - margin.left - margin.right;
				height = newWidth/2 - margin.top - margin.bottom;
				maxBarWidth = width - barLabelWidth - barLabelPadding - valueLabelWidth;
		//		if ((width / 2 - margin.left - margin.right) > 300) {
		//			height = width / 2 - margin.left - margin.right;
		//		} else {
		//			height = 300;
		//		}
				draw();
			}
		});
	});

	myObserver.observe(d3.select("#"+domName).node());

	draw();

	function draw() {

		var svg = d3.select("#"+domName).append("svg")
					.attr("width", width)
					.attr("height", height),
			g = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

		var y = d3.scaleBand()			// x = d3.scaleBand()	
			.range([0, height-barLowerPadding])	// .rangeRound([0, width])
			.paddingInner(0.05)
			.align(0.1);

		var x = d3.scaleLinear()		// y = d3.scaleLinear()
			.range([0, maxBarWidth]);	// .rangeRound([height, 0]);

		var z = d3.scaleOrdinal()
			.range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

		var keys = data.map(function(d) { return d.element; });
		
		var stackData = myStack(data);

		//	  data.sort(function(a, b) { return b.total - a.total; });
		y.domain(data.map(function(d) { return d.element; }));					// x.domain...
		x.domain([0, d3.max(data, function(d) { return d.count; })]).nice();	// y.domain...
		z.domain(data.map(function(d, i) { return d.secondary; }));

		g.append("g")
			.selectAll("g")
			.data(stackData)
			.enter().append("g")
			.attr("fill", function(d,i) { return z(i); })
			.selectAll("rect")
			.data(function(d) { return d; })
			.enter().append("rect")
			.attr("class", function(d){ return domName+"-rect "; })
			.attr("y", function(d,i) { return y(data[i].element); })	    //.attr("x", function(d) { return x(d.data.State); })
			.attr("x", function(d) { return x(d[0]); })			    //.attr("y", function(d) { return y(d[1]); })	
			.attr("width", function(d) { return x(d[1]) - x(d[0]); })	//.attr("height", function(d) { return y(d[0]) - y(d[1]); })
			.attr("height", y.bandwidth())						    //.attr("width", x.bandwidth());	
			.on("click", function(d, i){ console.log(domName+"-rect click d", i, d); })
			.on("mouseover", function() { 
				tooltip.style("display", null); 
			    // Reduce opacity of all rect to 0.2
			    d3.selectAll("."+domName+"-rect").style("opacity", 0.2)
			    // Highlight all rects of this subgroup with opacity 1.
 				d3.select(this.parentNode).selectAll("."+domName+"-rect")
			      .style("opacity", 1);
			})
			.on("mouseout", function() {
				tooltip.style("display", "none");
			    // Back to normal opacity: 1
			    d3.selectAll("."+domName+"-rect")
			      .style("opacity",1);
			})
			.on("mousemove", function(d) {		
				var xPosition = d3.mouse(this)[0];
		     	var yPosition = d3.mouse(this)[1];
		     	tooltip.attr("transform", "translate(" + xPosition + "," + yPosition + ")");
		     	tooltip.select("text").text(d[1]-d[0]);
			})
			;

		g.append("g")
			.attr("class", "axis")
			.attr("transform", "translate(0,0)") 						//  .attr("transform", "translate(0," + height + ")")
			.call(d3.axisLeft(y));									//   .call(d3.axisBottom(x));

		g.append("g")
			.attr("class", "axis")
			.attr("transform", "translate(0," + (height-100) + ")")				// New line
			.call(d3.axisBottom(x).ticks(null, "s"))					//  .call(d3.axisLeft(y).ticks(null, "s"))
			.append("text")
			.attr("y", 2)												//     .attr("y", 2)
			.attr("x", x(x.ticks().pop()) + 0.5) 						//     .attr("y", y(y.ticks().pop()) + 0.5)
			.attr("dy", "0.32em")										//     .attr("dy", "0.32em")
			.attr("fill", "#000")
			.attr("font-weight", "bold")
			.attr("text-anchor", "start")
			.text("Patient Count")
			.attr("transform", "translate(" + (width/2) + ",0)");   	// Newline

		// Tooltip ////// 
		var tooltip = g.append("g")
    		.attr("class", "graph_tooltip")
    		.style("display", "none");
      
  		tooltip.append("rect")
    		.attr("width", 60)
    		.attr("height", 20)
    		.attr("fill", "white")
    		.style("opacity", 0.5);

  		tooltip.append("text")
    		.attr("x", 30)
    		.attr("dy", "1.2em")
    		.style("text-anchor", "middle")
    		.attr("font-size", "12px")
    		.attr("font-weight", "bold");
	};

	function myStack(data) {
//		console.log("building mystack",data);
		var result = new Array();
		var previous = 0;
		for (let secondary = 1; secondary < data[1].secondary.length; secondary++) {
			var newrow = new Array();
			for (let primary = 0; primary < data.length; primary++) {
//				console.log("processing row", previous, data[primary])
				if (previous == 0)
					newrow.push([0, data[primary].secondary[secondary]]);
				else
					newrow.push([previous[primary][1], previous[primary][1] + data[primary].secondary[secondary]]);
			}	
			result.push(newrow);
			previous = newrow;
//			console.log("newrow",newrow)
		}
		return result;
	}

}
</script>
