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

function mortalityVerticalBarChart(data, properties) {
	var domName = properties.domName;
	var barLabelWidth = properties.barLabelWidth;
	
	var barLabel = function(d) { return d.element; };
	var barValue = function(d) { return parseFloat(d.count); };

		var valueLabelWidth = 50; // space reserved for value labels (right)
		var barHeight = 20; // height of one bar
		var barLabelWidth = 10; // space reserved for bar labels
		var barLabelPadding = 5; // padding between bar and bar labels (left)
		var gridLabelHeight = 10; // space reserved for gridline labels
		var gridChartOffset = 3; // space between start of grid and first bar
		var maxBarWidth = 280; // width of the bar with the max value
		
		
		data.forEach(function(node) {
			barLabelWidth = Math.max(barLabelWidth,node.element.length * 8);
		});
		
		var original = d3.select(domName).node();
		var newnode = original.cloneNode();
	    original.parentNode.replaceChild(newnode, original);
	    
		var myObserver = new ResizeObserver(entries => {
			entries.forEach(entry => {
				var newWidth = Math.floor(entry.contentRect.width);
				if (newWidth > 0) {
					d3.select(domName).select("svg").remove();
					maxBarWidth = newWidth;
					draw();
				}
			});
		});
		myObserver.observe(d3.select(domName).node());

		draw();

		function draw() {
			// set the dimensions and margins of the graph
			var margin = {top: 20, right: 20, bottom: 110, left: 60},
			    width = maxBarWidth - margin.left - margin.right,
			    height = 500 - margin.top - margin.bottom;
			
			// set the max width for each individual bar
			var barwidthmax = width/5;
			
			// set the ranges
			var x = d3.scaleBand()
			          .range([0, width])
			          .padding(0.1);
			var y = d3.scaleLinear()
			          .range([height, 0]);
			          
			// append the svg object to the body of the page
			// append a 'group' element to 'svg'
			// moves the 'group' element to the top left margin
			var svg = d3.select(domName).append("svg")
			    .attr("width", width + margin.left + margin.right)
			    .attr("height", height + margin.top + margin.bottom)
			  .append("g")
			    .attr("transform", 
			          "translate(" + margin.left + "," + margin.top + ")")
			  .attr("id", "svg_g");
			
			var svgDefs = svg.append('defs');

	        var mainGradient = svgDefs.append('linearGradient')
	            .attr('id', 'mainGradient')
	            .attr('x1', '0%')
	  			.attr('x2', '0%')
	  			.attr('y1', '100%')
	  			.attr('y2', '0%');

	        // Create the stops of the main gradient.
	        mainGradient.append('stop')
	            .style('stop-color', "#33298D")
	            .attr('offset', '0');

	        mainGradient.append('stop')
	            .style('stop-color', "#3F50B0")
	            .attr('offset', '99%');

			  // Scale the range of the data in the domains
			  x.domain(data.map(function(d) { return d.element; }));
			  y.domain([0, d3.max(data, function(d) { return d.count; })]);

			  // append the rectangles for the bar chart
			  svg.selectAll(".bar")
			      .data(data)
			    .enter().append("rect")
			      .attr("class", "bar")
			      .attr("fill", "url(#mainGradient)")
			      .attr('rx', 2)
			      .attr("x", function(d) { 
			    	  var barwidth = x.bandwidth();
			    	  if (barwidth > barwidthmax){
			    		  return x(d.element)+ ((barwidth - barwidthmax)/2);
			    	  }else{
			    		  return x(d.element); 
			    	  }
			      })
			      .attr("width", function(d){
			    	  var barwidth = x.bandwidth();
			    	  if (barwidth > barwidthmax){
			    		  return barwidthmax;
			    	  }else{
			    		  return barwidth;
			    	  }
			      })
			      //.attr("width", x.bandwidth())
			      .attr("y", height)
			      .attr("height", 0)
			      .on("click", function(d, i){
			    	  var format = {};
			    	  format['secondary_name'] = d.element;
					 window[properties.domName.replace(/_[^_]+_[^_]+$/i,'_').replace('#', '')+'viz_constrain'](format, 'delay'); 
				  })
				  .on('mousemove', function(d){
					  var text = "";
						if (d.count == '<20'){
		     				text= d.count;
		     			}else{
		     				text = parseInt(d.count).toLocaleString();
		     			};
		     			
						d3.selectAll(".tooltip").remove(); 
						d3.select("body").append("div")
							.attr("class", "bar tooltip")
							.style("opacity", 0.8)
							.style("left", (d3.event.pageX + 5) + "px")
							.style("top", (d3.event.pageY - 28) + "px")
							.html("<strong>" + d.element + "</strong><br><strong>Count:</strong> " + text);
					})
					.on('mouseout', function(d){
				 		d3.selectAll(".tooltip").remove(); 
					});
			  
			  svg.selectAll('rect')
				.transition().duration(1000)
				.attr("y", function(d) { return y(d.count); })
				.attr('height', function(d) { return height - y(d.count); });


			  // add the x Axis
			  svg.append("g")
			      .attr("transform", "translate(0," + height + ")")
			      .call(d3.axisBottom(x))
			      	.attr("class", "xaxis")
			      	.append("text")
			      	.attr("font-size", "14px")
					.attr("x", (width)/2)
					.attr("y", margin.bottom-10)
					.attr("dy", "0.32em")
					.attr("fill", "#000")
					.attr("font-weight", "bold")
					.attr("text-anchor", "middle")
					.text("Days After Discharge");
					
					
			d3.selectAll('.xaxis .tick text')
  				.style("text-anchor", "end")
  				.attr("dx", "-.8em")
  				.attr("dy", ".15em")
  				.attr("transform", "rotate(-65)")
  				.attr("font-size", "12px");

			  // add the y Axis
			  svg.append("g")
			      .call(d3.axisLeft(y))
			      .attr("class", "yaxis")
			      	.append("text")
			      	.attr("font-size", "14px")
			      	.attr("transform", "rotate(-90)")
			      	.attr("y", -margin.left+10)
					.attr("x", -(height)/2)
					.attr("dy", "0.32em")
					.attr("fill", "#000")
					.attr("font-weight", "bold")
					.attr("text-anchor", "middle")
					.text("Mortality Count");
			  
			 
			// Tooltip ////// 
			var tooltip = svg.append("g")
		    	.attr("class", "graph_tooltip")
		    	.style("display", "none");
		      
		  	tooltip.append("rect")
		    	.attr("width", 60)
		    	.attr("height", 53)
		   		.attr("fill", "white")
		   		.style("opacity", 0.8);

			tooltip.append("text")
				.attr("x", 30)
	    		.attr("dy", "1.2em")
	    		.style("text-anchor", "middle")		    		
	    		.attr("font-size", "12px")
		    	.attr("font-weight", "bold");

		}
}
</script>
