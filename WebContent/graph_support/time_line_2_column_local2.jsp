<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test = "${not empty param.column1_color}">
	<c:set var = "column1_color" value = "${param.column1_color}"/>
</c:if>
<c:if test = "${empty param.column1_color}">
	<c:set var = "column1_color" value = "#4833B2"/>
</c:if>
<c:if test = "${not empty param.column2_color}">
	<c:set var = "column2_color" value = "${param.column2_color}"/>
</c:if>
<c:if test = "${empty param.column2_color}">
	<c:set var = "column2_color" value = "#AD1181"/>
</c:if>


<style>
	rect{
		cursor: auto;
	}

    .axis path,
    .axis line {
        fill: none;
        stroke: #000;
        shape-rendering: crispEdges;
    }

    .x.axis path {
        display: none;
    }
    
    .xaxis text{
    	fill: #000;
    }

    .line {
        fill: none;
        stroke-width: 1.5px;
    }

    .overlay {
        fill: none;
        pointer-events: bounding-box;
    }
	
	.tooltip-duas,
	text.duas{
        fill: ${column1_color} ;
    }
    
    .dua_dta_focus{
    	fill: black;
    	pointer-events:none;
    }
    
    .tool_line{
    	pointer-events:none;
    }
    .dua_dta_focus .tooltip{
    	opacity: 0.7;
    	stroke:none;
    	width: 230px;
    }
    
    path.duas,
    rect.duas{
    	stroke: ${column1_color} ;
    	stroke-width:3.8px;
    }
    path.dtas,
    rect.dtas{
    	stroke: ${column2_color} ;
    	stroke-width:3.8px;
    }
    
    .tooltip-dtas, text.dtas{
    		fill: ${column2_color} ;
    }
    
    .dua_dta_focus text{
        font-size: 12px;
    }

    .tooltip {
        fill: white;
        stroke: #000;
    }

    .tooltip-date_dta_dua, 
    .tooltip-duas, 
    .tooltip-dtas{
        font-weight: bold;
    }

.axis1 text{
  fill: ${column1_color} ;
}

.axis2 text{
  fill: ${column2_color} ;
}
</style>

	

<script>


function TimeLine2ColumnChart2(data, properties) {

	// set the dimensions and margins of the graph
	var margin = {top: 0, right: 100, bottom: 140, left: 100},
	    width = 960 - margin.left - margin.right,
	    height = 600 - margin.top - margin.bottom;
	
		var column1_label = "Reinfected Patient Count";
		var column2_label = "Monthly Max of Seven Day Rolling Average";
		var column1_tip_offset = 120;
		var column2_tip_offset = 120;
		var column1_tip = "reinfection count";
		var column2_tip = "7 day rolling avg";
		var column1_opacity = 0.4;
		var column2_opacity = 1;
		
		<c:if test="${not empty param.column1_opacity}">
			column1_opacity = ${param.column1_opacity};
		</c:if>
		<c:if test="${not empty param.column2_opacity}">
			column2_opacity = ${param.column2_opacity};
		</c:if>
		
		var ${param.block}myObserver = new ResizeObserver(entries => {
			entries.forEach(entry => {
				var newWidth = Math.floor(entry.contentRect.width);
				if (newWidth > 0) {
					d3.select("#"+properties.domName).select("svg").remove();
					width = newWidth - margin.left - margin.right;
					if ((width/2 - margin.top - margin.bottom) > 200){
						height = width/2 - margin.top - margin.bottom;
					} else { 
						height = 200;
					}
					draw();
				}
			});
		});
		
		${param.block}myObserver.observe(d3.select("#"+properties.domName).node());
		
		draw();
		
		
		function draw() {
			// set the ranges
			var x = d3.scaleTime().domain(d3.extent(data, function(d) { return d.date; })).range([0, width]);
			var y1 = d3.scaleLinear().range([height, 40]);
			var y2 = d3.scaleLinear().range([height, 40]);
			var line = d3.line().x(d => x(d.date)).y(d => y(d.date));
			
			
		
			// append the svg obgect to the body of the page
			// appends a 'group' element to 'svg'
			// moves the 'group' element to the top left margin
			var svg = d3.select("#"+properties.domName).append("svg")
				.attr("class", "clear_target")
				.attr("width", width + margin.left + margin.right)
				.attr("height", height + margin.top + margin.bottom)
				.append("g")
				.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
			
			// Add a clipPath: everything out of this area won't be drawn.
			 var clip = svg.append("defs").append("svg:clipPath")
			     .attr("id", "clip")
			     .append("svg:rect")
			     .attr("width",width)
			     .attr("height", height)
			     .attr("x", 0)
			     .attr("y", 0);
			
			
			    // Create the scatter variable: where both the circles and the brush take place
			  var graph = svg.append('g')
    			  .attr("clip-path", "url(#clip)")
    			  .attr("class", "overlay");
			 
			  
			// Add brushing
			  var brush = d3.brushX()                   // Add the brush feature using the d3.brush function
			      .extent( [ [0,0], [width,height] ] )  // initialise the brush area: start at 0,0 and finishes at width,height: it means I select the whole graph area
			      .on("brush", dua_dta_mousemove)
			      .on("end", updateChart);              // Each time the brush selection changes, trigger the 'updateChart' function
			  
				<c:choose>
					<c:when test="${not empty param.useColumn1Scaling}">
						y1.domain([0, d3.max(data, function(d) { return d.column1; })]);
						y2.domain([0, d3.max(data, function(d) { return d.column1; })]);
					</c:when>
					<c:when test="${not empty param.useColumn2Scaling}">
						y1.domain([0, d3.max(data, function(d) { return d.column2; })]);
						y2.domain([0, d3.max(data, function(d) { return d.column2; })]);
					</c:when>
					<c:otherwise>
						y1.domain([0, d3.max(data, function(d) { return d.column1; })]);
						y2.domain([0, d3.max(data, function(d) { return d.column2; })]);
					</c:otherwise>
				</c:choose>
			  
				// X & Y 
				var valueline = d3.line()
					.x(function(d) { return x(d.date); })
					.y(function(d) { return y1(d.column1); });
				var valueline2 = d3.line()
					.x(function(d) { return x(d.date); })
					.y(function(d) { return y2(d.column2); });
				var valueline3 = d3.area()
					.x(function(d) { return x(d.date); })
					.y0(y1(0))
					.y1(function(d) { return y1(d.column1); });
			
				// Lines
				graph.append("path")
					.data([data])
					.attr("opacity", column1_opacity)
					.attr("class", "line duas")
					.attr("stroke", '${column1_color}')
					.attr("stroke-width", '2.8px')
					.attr("d", valueline);
				// Add the area
			    graph.append("path")
			      .data([data])
			      .attr("opacity", column1_opacity)
			      .attr("class", "duas2")
			      .attr("fill", '${column1_color}')
			      .attr("stroke", '${column1_color}')
			      .attr("stroke-width", 2.8)
			      .attr("d", valueline3);
				// add second line
			    graph.append("path")
				.data([data])
				.attr("opacity", column2_opacity)
				.attr("stroke", '${column2_color}')
				.attr("stroke-width", '2.8px')
				.attr("class", "line dtas")
				.attr("d", valueline2);

				
// 				// Add the brushing
				var test_tip = graph
				    .append("g")
				    .attr("class", "brush")
				    .call(brush)
				    .on("mouseover", function() { dua_dta_focus.style("display", null);  tooltipLine.style("display", null);})
		    	  	.on("mouseout", function() { dua_dta_focus.style("display", "none");  tooltipLine.style("display", "none");})
		    	  	.on("mousemove", dua_dta_mousemove);
			
				// Labels & Current Totals
				<c:if test="not empty param.lineLabels">
					graph.append("text")
				    	.attr("transform", "translate("+(width+3)+","+y1(data[data.length-1].column1)+")")
				    	.attr("dy", ".35em")
				    	.attr("text-anchor", "start")
				    	.attr("class", "duas")
				    	.text("column1_tip");
					graph.append("text")
				    	.attr("transform", "translate("+(width+3)+","+y2(data[data.length-1].column2)+")")
				    	.attr("dy", ".35em")
				    	.attr("text-anchor", "start")
				    	.attr("class", "dtas")
				    	.text("column2_tip");
				</c:if>
				

			    
			  	// Axis
				var xaxis = svg.append("g")
					.attr("transform", "translate(0," + height + ")")
					.attr("class", "xaxis")
					.call(d3.axisBottom(x).ticks(d3.timeMonth.every(1)).tickFormat(function(date){
						if (d3.timeYear(date) < date) {
					           return d3.timeFormat('%b')(date);
					         } else {
					           return d3.timeFormat('%Y')(date);
					         }
					      }))
					.selectAll("text")  
    					.style("text-anchor", "end")
    					.style("font-size", "12px")
    					.attr("dx", "-.8em")
    					.attr("dy", ".15em")
    					.attr("transform", "rotate(-65)");

				// text label for the x axis
				  svg.append("text")             
				      .attr("transform",
				            "translate(" + (width/2) + " ," + (height + 60) + ")")
				      .style("text-anchor", "middle")
				      .text("Initial Infection Date")
				      .attr("font-size", '14px')
					  .attr("font-weight", "bold");

				  svg.append("g")
			      .attr("class", "axis1")
			      .call(d3.axisLeft(y1).ticks(10));

				  // text label for the y axis
				  svg.append("text")
				  	.attr("transform", "rotate(-90)")
				  	.attr("y", 0 - margin.left)
				  	.attr("x",0 - (height / 2))
				  	.attr("dy", "1em")
				  	.style("text-anchor", "middle")
				  	.text(column1_label)
				  	.attr("font-size", '14px');      
				  
				  svg.append("g")
			      	.attr("class", "axis2")
			      	.attr("transform", "translate( " + width + ", 0 )")
			      	.call(d3.axisRight(y2).ticks(10));

				  d3.select(".axis1").selectAll('text').style("fill", "${column1_color}").style("font-size", "12px");
				  d3.select(".axis2").selectAll('text').style("fill", "${column2_color}").style("font-size", "12px");
				
				  // text label for the y axis
				  svg.append("text")
				      .attr("transform", "rotate(-90)")
				      .attr("y", width+(margin.right/1.5))
				      .attr("x",0 - (height / 2))
				      .attr("dy", "1em")
				      .style("text-anchor", "middle")
				      .text(column2_label)
				      .attr("font-size", '14px');  

		        // Add the Legend
			    var legend_keys = {"nodes":[{"text": column1_tip, "tag": "duas", "opacity":column1_opacity}, {"text": column2_tip, "tag": "dtas", "opacity":column2_opacity}]};

			    var lineLegend = svg.selectAll(".lineLegend").data(legend_keys.nodes)
			    	.enter().append("g")
			    	.attr("class","lineLegend")
			    	.attr("transform", function (d, i) {
			            return "translate(" + (0) + "," + ( (height+(i*15)) + (margin.bottom/2))+")";
			        });

				lineLegend.append("text").text(function (d) {return d.text;})
				    .attr("transform", "translate(25, 6)"); //align texts with boxes
	
				lineLegend.append("rect")
				    .attr("width", 22)
				    .attr("class", function(d){return d.tag;})
				    .attr("opacity", function(d){return d.opacity;})
				    .attr("stroke",  function(d){
				    	if (d.tag == 'duas'){
				    		return '${column1_color}'
				    	} else {
				    		return '${column2_color}'
				    	};
				    })
				    .attr("stroke-width", '2.8px')
				    .attr('height', 2);
				    
				//tooltip line
				var tooltipLine = graph.append('line')
					.attr("class", "tool_line");
				
				// tooltips
				var dua_dta_focus = test_tip.append("g")
			    	.attr("class", "dua_dta_focus")
			    	.style("display", "none");
			
				dua_dta_focus.append("rect")
			    	.attr("class", "tooltip")
			    	.attr("height", 70)
			    	.attr("x", 10)
			    	.attr("y", -22)
			    	.attr("rx", 4)
			    	.attr("ry", 4);
			
				dua_dta_focus.append("text")
			    	.attr("class", "tooltip-date_dta_dua")
			    	.attr("x", 18)
			    	.attr("y", 0);
			
				dua_dta_focus.append("text")
			    	.attr("x", 18)
			    	.attr("y", 18)
			    	.text(column1_tip+":");
				
				dua_dta_focus.append("text")
		    		.attr("x", 18)
		    		.attr("y", 30)
		    		.text(column2_tip+":");
			
				dua_dta_focus.append("text")
			    	.attr("class", "tooltip-duas")
			    	.attr("x", column1_tip_offset)
			    	.attr("y", 18);
				
				dua_dta_focus.append("text")
					.attr("class", "tooltip-dtas")
					.attr("x", column2_tip_offset)
					.attr("y", 30);
				
			    
				var parseDate = d3.timeFormat("%m/%e/%Y").parse,
					bisectDate_dua_dta = d3.bisector(function(d) { return d.date; }).left,
					formatValue1 = d3.format(","),
					formatValue2 = d3.format(",.2f"),
					dateFormatter = d3.timeFormat("%m/%y"),
					dateFormatter2 = d3.timeFormat("%Y-%m-%d");
				
				
				function valueFormatter1(value) {
					if (value == '<20')
						return value;
					return formatValue1(value);
				}
			
				function valueFormatter2(value) {
					if (value == '<20')
						return value;
					return formatValue2(value);
				}

				function dua_dta_mousemove() {
				    var x0 = x.invert(d3.mouse(this)[0]),
				        i = bisectDate_dua_dta(data, x0),
				        d0 = data[i - 1],
				        d1 = data[i];
					
					if (d0 && !d1){
				    	d1 = d0;
				    };
				    
				    if (d1 && !d0){
				    	d0 = d1;
				    };

				    
				    var d = x0 - d0.date > d1.date - x0 ? d1 : d0;
				    
				    
				    if (width/2 > d3.mouse(this)[0]){
				    	dua_dta_focus.attr("transform", "translate(" + x(d.date) + "," + d3.mouse(this)[1] + ")");
				    }else{
				    	dua_dta_focus.attr("transform", "translate(" + ((x(d.date))-250) + "," + d3.mouse(this)[1] + ")");
				    };
				   
				    dua_dta_focus.select(".tooltip-date_dta_dua").text(dateFormatter(d.date));
				    dua_dta_focus.select(".tooltip-duas").text(valueFormatter1(d.column1_display));
				    dua_dta_focus.select(".tooltip-dtas").text(valueFormatter2(d.column2));
				    
				    tooltipLine.attr('stroke', 'black')
				    	.attr("transform", "translate(" + x(d.date) + "," + 0 + ")")
				    	.attr('y1', 0)
				    	.attr('y2', height);
				};


				
				// A function that set idleTimeOut to null
				  var idleTimeout;
				  function idled() { idleTimeout = null; };
				
				// A function that update the chart for given boundaries
				   function updateChart() {

						// What are the selected boundaries?
						var extent = d3.event.selection;

				      	// If no selection, back to initial coordinate. Otherwise, update X axis domain
				     	if(!extent){
				        	if (!idleTimeout) return idleTimeout = setTimeout(idled, 350); // This allows to wait a little bit
				        	x.domain(d3.extent(data, function(d) { return d.date; }));
				      	}else{
				        	<c:if test="${not empty param.constraintPropagator}">
				        		${param.block}_${param.constraintPropagator}(dateFormatter2(x.invert(extent[0])),dateFormatter2(x.invert(extent[1])))
				        	</c:if>
				      		x.domain([ x.invert(extent[0]), x.invert(extent[1]) ]);
				        	graph.select(".brush").call(brush.move, null); // This remove the grey brush area as soon as the selection has been done
				      	}
				      		
					      console.log(properties.domName);
				      	// redraw axis
				      	d3.selectAll('#' + properties.domName + ' .xaxis').remove();
				      	svg.append("g")
						.attr("transform", "translate(0," + height + ")")
						.attr("class", "xaxis")
						.call(d3.axisBottom(x).ticks(d3.timeMonth.every(1))
			        	.tickFormat(function(date){
							if (d3.timeYear(date) < date) {
								if (d3.timeMonth(date) < date) {
									return d3.timeFormat('%b %d')(date);
								}else{
									return d3.timeFormat('%b')(date);
								} 
					         } else {
					           return d3.timeFormat('%Y')(date);
					         }
					      	}))
						.selectAll("text")  
    						.style("text-anchor", "end")
    						.attr("dx", "-.8em")
    						.attr("dy", ".15em")
    						.style("font-size", "12px")
    						.attr("transform", "rotate(-65)");

				      	// Update line position
				      	graph
				          .select('path.duas')
				          .transition()
				          .duration(1000)
				          .attr("d", d3.line()
				            .x(function(d) { return x(d.date); })
				            .y(function(d) { return y1(d.column1); }));
				      	graph
				          .select('.duas2')
				          .transition()
				          .duration(1000)
				          .attr("d", d3.area()
				            .x(function(d) { return x(d.date); })
				            .y0(function(d) { return y1(0); })
				            .y1(function(d) { return y1(d.column1); }));
				      	graph
				          .select('path.dtas')
				          .transition()
				          .duration(1000)
				          .attr("d", d3.line()
				            .x(function(d) { return x(d.date); })
				            .y(function(d) { return y2(d.column2); }));
	
				};
				
				function time_line_clear(){
		        	<c:if test="${not empty param.constraintPropagator}">
						${param.block}_${param.constraintPropagator}(null, null)
		        	</c:if>
					
					x.domain(d3.extent(data, function(d) {return d.date; }));
					
					
					d3.select(properties.domName + " ${param.dom_element}_graph .xaxis")
			        	.transition()
			        	.call(d3.axisBottom(x)
			        	.tickFormat(function(date){
							if (d3.timeYear(date) < date) {
					           return d3.timeFormat('%b')(date);
					         } else {
					           return d3.timeFormat('%Y')(date);
					         }
					      	}))
						.selectAll("text")  
    						.style("text-anchor", "end")
    						.attr("dx", "-.8em")
    						.attr("dy", ".15em")
    						.attr("transform", "rotate(-65)");
			        
			        graph
			          .select('path.duas')
			          .transition()
			          .attr("d", d3.line()
			          	.x(function(d) { return x(d.date); })
					    .y(function(d) { return y1(d.cloumn1); }));
			        
			        graph
			          .select('path.dtas')
			          .transition()
			          .attr("d", d3.line()
			          	.x(function(d) { return x(d.date); })
					    .y(function(d) { return y2(d.column2); }));
					
				};
				
				d3.select(properties.domName + " ${param.dom_element}_graph .clear_target")
					.on("dblclick", time_line_clear);
				
				$("${param.dom_element}_btn").off().on("click", function(){
					d3.select(properties.domName + " ${param.dom_element}_graph .clear_target").dispatch("dblclick");
				});
				
			};
}
</script>
