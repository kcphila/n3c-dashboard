<style>
div.point.tooltip {
	position: absolute;
	background-color: white;
  	opacity: 0.8;
  	height: auto;
	padding: 1px;
  	pointer-events: none;
}

.axis .domain {
	display:block!important;
}

</style>

<script>

function OddsRatioChart(data, properties) {
	
	var barHeight = 80;
	var calc_height = data.length * barHeight;
	var labels = properties.bandLabelWidth;
	
	// set the dimensions and margins of the graph
	var margin = { top: 0, right: 10, bottom: 100, left: 0 },
		width = 960 - margin.left - margin.right,
		height = calc_height - margin.top - margin.bottom;
	
	

	var minX = (typeof properties.minX == "undefined" ? 0.0 : properties.minX);
	var maxX = (typeof properties.maxX == "undefined" ? 1.0 : properties.maxX);


	var maxBandWidth = 400;

	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("#" + properties.domName).select("svg").remove();
				width = newWidth - margin.left - margin.right;
				height = calc_height - margin.top - margin.bottom;
				maxBandWidth = width - labels;
				draw_bar();
			}
		});
	});

	myObserver.observe(d3.select("#" + properties.domName).node());

	draw_bar();

	function draw_bar() {
		// append the svg obgect to the body of the page
		// appends a 'group' element to 'svg'
		// moves the 'group' element to the top left margin
		var chart = d3.select("#" + properties.domName).append("svg")
			.attr("class", "clear_target")
			.attr("width", width + margin.left + margin.right)
			.attr("height", height + margin.top + margin.bottom)
			.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

		// Show the Y scale
		var y = d3.scaleBand()
			.range([0, height])
			.domain(d3.range(0, data.length))
			.padding(.4);
		chart.append("g")
			.attr("class", "y axis")
			.attr("transform", "translate(" + properties.bandLabelWidth + "," + 0 + ")")
			.call(d3.axisLeft(y).tickFormat(function(d, i) { return data[i].element }).tickSize(2))

		// Show the X scale
		var x = d3.scaleLinear()
			.domain([minX, maxX])
			.range([properties.bandLabelWidth, properties.bandLabelWidth + maxBandWidth])
		chart.append("g")
			.attr("class", "axis xaxis")
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
			.attr("stroke", "#a6a6a6")
			.style("width", 40)

		// Show the main vertical line
		chart
			.selectAll("vertLines")
			.data(data)
			.enter()
			.append("line")
			.attr("class", "bartransition")
			.attr("x1", function(d) { return (x(d.conf_low)) })
			.attr("x2", function(d) { return (x(d.conf_high)) })
			.attr("y1", function(d, i) { return (y(i) + y.bandwidth() / 2) })
			.attr("y2", function(d, i) { return (y(i) + y.bandwidth() / 2) })
			.attr("stroke", "#007bff")
			.attr("stroke-width", '2.8px')
			.style("width", 40)
			.on('mousemove', function(d){
				if (properties.mode == "hazard"){
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.element 
						+ "</strong><br><strong>HR:</strong> " + d.estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.conf_low.toLocaleString() + "-" + d.conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.p.toLocaleString());
				}else{
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.element 
						+ "</strong><br><strong>OR:</strong> " + d.estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.conf_low.toLocaleString() + "-" + d.conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.p_value.toLocaleString());
				}
			})
			 .on('mouseout', function(d){
				d3.selectAll(".tooltip").remove(); 
			 });

		// Show the left whisker
		chart
			.selectAll("leftWhisker")
			.data(data)
			.enter()
			.append("line")
			.attr("class", "opacitytransition")
			.style('opacity', 0)
			.attr("x1", function(d) { return (x(d.conf_low)) })
			.attr("x2", function(d) { return (x(d.conf_low)) })
			.attr("y1", function(d, i) { return (y(i) + y.bandwidth() / 2) - properties.symbolSize * 1.25 })
			.attr("y2", function(d, i) { return (y(i) + y.bandwidth() / 2) + properties.symbolSize * 1.25 })
			.attr("stroke", "#007bff")
			.style("width", 40)
			.on('mousemove', function(d){
				if (properties.mode == "hazard"){
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.element 
						+ "</strong><br><strong>HR:</strong> " + d.estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.conf_low.toLocaleString() + "-" + d.conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.p.toLocaleString());
				}else{
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.element 
						+ "</strong><br><strong>OR:</strong> " + d.estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.conf_low.toLocaleString() + "-" + d.conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.p_value.toLocaleString());
				}
			})
			 .on('mouseout', function(d){
				d3.selectAll(".tooltip").remove(); 
			 });

		// Show the right whisker
		chart
			.selectAll("rightWhisker")
			.data(data)
			.enter()
			.append("line")
			.attr("class", "opacitytransition")
			.style('opacity', 0)
			.attr("x1", function(d) { return (x(d.conf_high)) })
			.attr("x2", function(d) { return (x(d.conf_high)) })
			.attr("y1", function(d, i) { return (y(i) + y.bandwidth() / 2) - properties.symbolSize *1.25 })
			.attr("y2", function(d, i) { return (y(i) + y.bandwidth() / 2) + properties.symbolSize *1.25 })
			.attr("stroke", "#007bff")
			.style("width", 40)
			.on('mousemove', function(d){
				if (properties.mode == "hazard"){
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.element 
						+ "</strong><br><strong>HR:</strong> " + d.estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.conf_low.toLocaleString() + "-" + d.conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.p.toLocaleString());
				}else{
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.element 
						+ "</strong><br><strong>OR:</strong> " + d.estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.conf_low.toLocaleString() + "-" + d.conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.p_value.toLocaleString());
				}
				
			})
			 .on('mouseout', function(d){
				d3.selectAll(".tooltip").remove(); 
			 });
		

		// glyph for the main symbol
		switch (properties.mode) {
			case "hazard":
				chart
					.selectAll("rects")
					.data(data)
					.enter()
					.append("rect")
					.attr("class", "opacitytransition")
					.style('opacity', 0)
					.attr("x", function(d) { return x(d.estimate) - properties.symbolSize })
					.attr("width", function(d) { return properties.symbolSize * 2 })
					.attr("y", function(d, i) { return y(i) + y.bandwidth() / 2 - properties.symbolSize; })
					.attr("height", properties.symbolSize * 2)
					.attr("stroke", "white")
					.style("fill", "#007bff")
					.on('mousemove', function(d){
						d3.selectAll(".tooltip").remove(); 
						d3.select("body").append("div")
						.attr("class", "point tooltip")
						.style("left", (d3.event.pageX + 5) + "px")
						.style("top", (d3.event.pageY - 28) + "px")
						.html("<strong>" + d.element 
							+ "</strong><br><strong>HR:</strong> " + d.estimate.toLocaleString()+ 
							"</strong><br><strong>95% CI:</strong> " + d.conf_low.toLocaleString() + "-" + d.conf_high.toLocaleString()+
							"</strong><br><strong>P-Value:</strong> " + d.p.toLocaleString());
					})
					.on('mouseout', function(d){
				 		d3.selectAll(".tooltip").remove(); 
					});
				break;
			case "odds":
			default:
				chart
					.selectAll("circles")
					.data(data)
					.enter()
					.append("circle")
					.attr("class", "opacitytransition")
					.style('opacity', 0)
					.attr("cx", function(d) { return (x(d.estimate)); })
					.attr("r", function(d) { return (properties.symbolSize); })
					.attr("cy", function(d, i) { return y(i) + y.bandwidth() / 2; })
					.attr("stroke", "white")
					.style("fill", "#007bff")
					.on('mousemove', function(d){
						d3.selectAll(".tooltip").remove(); 
						d3.select("body").append("div")
						.attr("class", "point tooltip")
						.style("left", (d3.event.pageX + 5) + "px")
						.style("top", (d3.event.pageY - 28) + "px")
						.html("<strong>" + d.element 
								+ "</strong><br><strong>OR:</strong> " + d.estimate.toLocaleString()+ 
								"</strong><br><strong>95% CI:</strong> " + d.conf_low.toLocaleString() + "-" + d.conf_high.toLocaleString()+
								"</strong><br><strong>P-Value:</strong> " + d.p_value.toLocaleString()
						);
					})
					.on('mouseout', function(d){
				 		d3.selectAll(".tooltip").remove(); 
					});
				break;
				
		}
		
		chart.selectAll('.opacitytransition')
			.transition().duration(1000)
			.style('opacity', 1);
		
		chart.selectAll(".bartransition").each(function(d){
		      var totalLength = this.getTotalLength();
		        d3.select(this)
		      .attr("stroke-dasharray", totalLength + " " + totalLength)
		      .attr("stroke-dashoffset", totalLength)
		      .transition()
		        .duration(1500)
		      .attr("stroke-dashoffset", 0);
		      
		    });
	}
}

</script>
