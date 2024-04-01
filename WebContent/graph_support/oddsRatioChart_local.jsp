<style>
div.bar.tooltip {
	position: absolute;
	background-color: white;
  	opacity: 0.8;
  	height: auto;
	padding: 1px;
  	pointer-events: none;
}
        svg text {  
            font: 15px sans-serif;  
        }  </style>

<script>

function OddsRatioChart(data, properties) {
	// set the dimensions and margins of the graph
	var margin = { top: 0, right: 100, bottom: 100, left: 100 },
		width = 960 - margin.left - margin.right,
		height = 600 - margin.top - margin.bottom;
	
	var minX = ( typeof properties.minX == "undefined" ? 0.0 : properties.minX);
	var maxX = ( typeof properties.maxX == "undefined" ? 1.0 : properties.maxX);

	//	console.log(data);

	var maxBandWidth = 400; // width of the bar with the max value

	var ${param.block}myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("#" + properties.domName).select("svg").remove();
				width = newWidth - margin.left - margin.right;
				if ((width / 1.75 - margin.top - margin.bottom) > 200) {
					height = width / 1.75 - margin.top - margin.bottom;
				} else {
					height = 200;
				}
				draw_bar();
			}
		});
	});

	${param.block}myObserver.observe(d3.select("#" + properties.domName).node());

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
			.attr("transform", "translate(" + properties.bandLabelWidth + "," + 0 + ")")
			.call(d3.axisLeft(y).tickFormat(function(d, i) {return data[i].element }).tickSize(2))

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
			.attr("y2", function(d) { return  height; })
			.style("stroke-dasharray", ("3, 3"))
			.attr("stroke", "black")
		.style("width", 40)

		// Show the main vertical line
		chart
			.selectAll("vertLines")
			.data(data)
			.enter()
			.append("line")
			.attr("x1", function(d) { return (x(d.conf_low)) })
			.attr("x2", function(d) { return (x(d.conf_high)) })
			.attr("y1", function(d, i) { return (y(i) + y.bandwidth() / 2) })
			.attr("y2", function(d, i) { return (y(i) + y.bandwidth() / 2) })
			.attr("stroke", "black")
			.attr("stroke-width", '2.8px')
			.style("width", 40)
	
		// Show the left whisker
		chart
			.selectAll("leftWhisker")
			.data(data)
			.enter()
			.append("line")
			.attr("x1", function(d) { return (x(d.conf_low)) })
			.attr("x2", function(d) { return (x(d.conf_low)) })
			.attr("y1", function(d, i) { return (y(i) + y.bandwidth() / 2) - properties.symbolSize * 2 })
			.attr("y2", function(d, i) { return (y(i) + y.bandwidth() / 2) + properties.symbolSize * 2 })
			.attr("stroke", "black")
			.style("width", 40)

		// Show the left whisker
		chart
			.selectAll("rightWhisker")
			.data(data)
			.enter()
			.append("line")
			.attr("x1", function(d) { return (x(d.conf_high)) })
			.attr("x2", function(d) { return (x(d.conf_high)) })
			.attr("y1", function(d, i) { return (y(i) + y.bandwidth() / 2) - properties.symbolSize * 2 })
			.attr("y2", function(d, i) { return (y(i) + y.bandwidth() / 2) + properties.symbolSize * 2 })
			.attr("stroke", "black")
			.style("width", 40)

		// glyph for the main symbol
		switch (properties.mode) {
			case "hazard":
				chart
					.selectAll("rects")
					.data(data)
					.enter()
	 			   .append("rect")
	        		.attr("x", function(d){return x(d.estimate) - properties.symbolSize})
	        		.attr("width", function(d){return properties.symbolSize * 2})
	        		.attr("y", function(d,i) { return y(i) + y.bandwidth() / 2 - properties.symbolSize; })
	        		.attr("height", properties.symbolSize * 2 )
	        		.attr("stroke", "black")
	        		.style("fill", "#69b3a2")
	        		.style("opacity", 0.3)
				break;
			case "odds":
			default:
				chart
					.selectAll("circles")
					.data(data)
					.enter()
					.append("circle")
					.attr("cx", function(d) { return (x(d.estimate)); })
					.attr("r", function(d) { return (properties.symbolSize); })
					.attr("cy", function(d, i) { return y(i) + y.bandwidth() / 2; })
					.attr("stroke", "black")
					.style("fill", "#69b3a2")
					.style("opacity", 0.8)
				break;
		}
	}
}
</script>
