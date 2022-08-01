<script>

function localVerticalBarChart(data, properties) {
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
		    //// console.log(node.element + "  " + node.element.length*7. );
		});
		
		var myObserver = new ResizeObserver(entries => {
			entries.forEach(entry => {
				var newWidth = Math.floor(entry.contentRect.width);
				if (newWidth > 0) {
					d3.select("#"+properties.domName).select("svg").remove();
					//// console.log('${param.dom_element} width '+newWidth);
					maxBarWidth = newWidth;
					draw();
				}
			});
		});
		myObserver.observe(d3.select("#"+properties.domName).node());

		draw();

		function draw() {
			// set the dimensions and margins of the graph
			var margin = {top: 20, right: 20, bottom: 120, left: 80},
			    width = maxBarWidth - margin.left - margin.right,
			    height = 500 - margin.top - margin.bottom;
			
			// set the max width for each individual bar
			var barwidthmax = width/5;

			var word_length = 60;
			
			if (data.length > 0){
				var longest_word = data.reduce(
					    function (a, b) {
					        return a.element.length > b.element.length ? a : b;
					    }
				);
				word_length =  longest_word.element.length;
			}
			
			// set the ranges
			var x = d3.scaleBand()
			          .range([0, width])
			          .padding(0.1);
			var y = d3.scaleLinear()
			          .range([height, 0]);
			          
			// append the svg object to the body of the page
			// append a 'group' element to 'svg'
			// moves the 'group' element to the top left margin
			var svg = d3.select("#"+properties.domName).append("svg")
			    .attr("width", width + margin.left + margin.right)
			    .attr("height", height + margin.top + margin.bottom)
			  .append("g")
			    .attr("transform", 
			          "translate(" + margin.left + "," + margin.top + ")");
			
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
			      .attr("y", function(d) { return y(d.count); })
			      .attr("height", function(d) { return height - y(d.count); })
			      .on("click", function(d, i){
			    	  var format = {};
			    	  format['secondary_name'] = d.element;
			    	  window[properties.domName.replace(/_[^_]+_[^_]+$/i,'_').replace('#', '')+'viz_constrain'](format, properties.filter_type); 
				  })
				.on("mouseover", function() { 
					tooltip.style("display", null); 
				})
				.on("mouseout", function() {
					tooltip.style("display", "none");
				})
				.on("mousemove", function(d) {	
					tooltip.selectAll("tspan").remove();
					var xPosition = d3.mouse(this)[0];
			     	var yPosition = d3.mouse(this)[1];
			     	var count2 = d.count;
			     	tooltip.attr("transform", "translate(" + xPosition + "," + yPosition + ")")
			     	.selectAll("text")
			     		.append("tspan")
			     		.text(((typeof properties.tooltip_x_label) === 'undefined' ? "" : properties.tooltip_x_label ) + d.element)
			     		.attr('x', 10)
	  					.attr('dy', 13)
			     		.append("tspan")
			     		.text(((typeof properties.tooltip_y_label) === 'undefined' ? "" : properties.tooltip_y_label ) + count2.toLocaleString())
			     		.attr('fill', 'black')
			     		.attr('x', 10)
	  					.attr('dy', 20)
				});

			  // add the x Axis
			  svg.append("g")
			      .attr("transform", "translate(0," + height + ")")
			      .call(d3.axisBottom(x))
			  .selectAll("text")	
		        .style("text-anchor", "end")
		        .attr("dx", "-.8em")
		        .attr("dy", ".15em")
		        .attr("transform", "rotate(-65)");
			 
				svg.append("text")
				.attr("y", height + (margin.bottom / 2))
				.attr("x",width/2)
				.attr("dy", "1em")
				.text(properties.xaxis_label); 

				// add the y Axis
			  svg.append("g")
			      .call(d3.axisLeft(y));

			  // text label for the y axis
			  svg.append("text")
			  	.attr("transform", "rotate(-90)")
			  	.attr("y", 0 - margin.left)
			  	.attr("x",0 - (height / 2))
			  	.attr("dy", "1em")
			  	.style("text-anchor", "middle")
			  	.text(properties.yaxis_label);      
			  
		// Tooltip ////// 
		var tooltip = svg.append("g")
    		.attr("class", "graph_tooltip")
    		.style("display", "none");
      
  		tooltip.append("rect")
    		.attr("width", function(d){
    			var cal_width = 10 + word_length * 7;
    			var min_width = 150;
    			if (cal_width > min_width){
    				return cal_width;
    			}else{
    				return min_width;
    			}
    		})
    		.attr("height", 40)
    		.attr("fill", "white")
    		.style("opacity", 0.7);

  		tooltip.append("text")
    		.style("text-anchor", "start")
    		.attr("font-size", "12px")
    		.attr("font-weight", "bold");
  		
  		if ((properties.nofilter == undefined) || (properties.nofilter == 0) ){
	  		// Legend Tooltip ////// 
			var tooltip2 = svg.append("g")
	    		.attr("class", "graph_tooltip")
	    		.style("display", "none")
	    		.attr("transform", "translate(" + ((width + margin.left + margin.right)-40) + "," + 10 + ")")
	
	  		tooltip2.append("text")
	    		.attr("x", 30)
	    		.attr("dy", "1.2em")
	    		.style("text-anchor", "end")
	    		.style("fill", "#0d6efd")
	    		.attr("font-size", "12px")
	    		.attr("font-weight", "bold")
	    		.text("Click to add/remove filter");
  		}
		}
}
</script>
