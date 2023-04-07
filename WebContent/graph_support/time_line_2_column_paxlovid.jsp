<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test = "${not empty param.column1_color}">
	<c:set var = "column1_color" value = "${param.column1_color}"/>
</c:if>
<c:if test = "${empty param.column1_color}">
	<c:set var = "column1_color" value = "#2d5985"/>
</c:if>
<c:if test = "${not empty param.column2_color}">
	<c:set var = "column2_color" value = "${param.column2_color}"/>
</c:if>
<c:if test = "${empty param.column2_color}">
	<c:set var = "column2_color" value = "#6b496b"/>
</c:if>
<c:if test = "${not empty param.namespace}">
	<c:set var = "namespace" value = "${param.namespace}"/>
</c:if>
<c:if test = "${empty param.column2_color}">
	<c:set var = "namespace" value = "namespace"/>
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
	
	.tooltip-duas.${namespace},
	text.duas.${namespace}{
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
    	width:130px;
    }
    
    path.duas.${namespace},
    rect.duas.${namespace}{
    	stroke: ${column1_color} ;
    	stroke-width:2.8px;
    }
    path.dtas.${namespace},
    rect.dtas.${namespace}{
    	stroke: ${column2_color} ;
    	stroke-width:2.8px;
    }
    
    .tooltip-dtas.${namespace}, text.dtas.${namespace}{
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

.axis1.${namespace} text{
  fill: ${column1_color} ;
}

.axis2.${namespace} text{
  fill: ${column2_color} ;
}
</style>

	

<script>



// set the dimensions and margins of the graph
	var margin = {top: 0, right: 100, bottom: 140, left: 100},
	    width = 960 - margin.left - margin.right,
	    height = 600 - margin.top - margin.bottom;
	
	
	
	d3.json("${param.data_page}", function(error, data) {	
		if (error) throw error;
				
		var column1_opacity = 1;
		var column2_opacity = 1;
		
		var ${param.block}myObserver = new ResizeObserver(entries => {
			entries.forEach(entry => {
				var newWidth = Math.floor(entry.contentRect.width);
				if (newWidth > 0) {
					d3.select("${param.dom_element}").select("svg").remove();
					width = newWidth - margin.left - margin.right;
					if ((width/2 - margin.top - margin.bottom) > 200){
						height = width/2 - margin.top - margin.bottom;
					} else { 
						height = 200;
					}
					draw();
					
					// console.log('${param.block}');
					
				}
			});
		});
		
		${param.block}myObserver.observe(d3.select("${param.dom_element}").node());
		
		draw();
		
		
		function draw() {
			
			
			// set the ranges
			var ${param.namespace}x = d3.scaleLinear().domain(d3.extent(data, function(d) { return d.visits; })).range([0, width]);
			var y1 = d3.scaleLinear().range([height, 40]);
			var y2 = d3.scaleLinear().range([height, 40]);
			var line = d3.line().x(d => x(d.${param.date_column})).y(d => y(d.${param.column1}));
			
			
		
			// append the svg obgect to the body of the page
			// appends a 'group' element to 'svg'
			// moves the 'group' element to the top left margin
			var svg = d3.select("${param.dom_element}_graph").append("svg")
				.attr("class", "clear_target")
				.attr("width", width + margin.left + margin.right)
				.attr("height", height + margin.top + margin.bottom)
				.append("g")
				.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
			
			
			    // Create the scatter variable: where both the circles and the brush take place
			  var graph = svg.append('g')
    			  .attr("class", "overlay")
    			  .on("mouseover", function() { dua_dta_focus.style("display", null);  tooltipLine.style("display", null);})
		    	  .on("mouseout", function() { dua_dta_focus.style("display", "none");  tooltipLine.style("display", "none");})
		    	  .on("mousemove", dua_dta_mousemove);
			
				// Scales
				${param.namespace}x.domain(d3.extent(data, function(d) { return d.${param.date_column}; }));
				<c:choose>
					<c:when test="${not empty param.useColumn1Scaling}">
						y1.domain([0, d3.max(data, function(d) { return d.${param.column1}; })]);
						y2.domain([0, d3.max(data, function(d) { return d.${param.column1}; })]);
					</c:when>
					<c:when test="${not empty param.useColumn2Scaling}">
						y1.domain([0, d3.max(data, function(d) { return d.${param.column2}; })]);
						y2.domain([0, d3.max(data, function(d) { return d.${param.column2}; })]);
					</c:when>
					<c:otherwise>
						y1.domain([0, d3.max(data, function(d) { return d.${param.column1}; })]);
						y2.domain([0, d3.max(data, function(d) { return d.${param.column2}; })]);
					</c:otherwise>
				</c:choose>
			  
				// X & Y 
				var valueline = d3.line()
					.x(function(d) { return ${param.namespace}x(d.${param.date_column}); })
					.y(function(d) { return y1(d.${param.column1}); });
				var valueline2 = d3.line()
					.x(function(d) { return ${param.namespace}x(d.${param.date_column}); })
					.y(function(d) { return y2(d.${param.column2}); });
			
				// Lines
				graph.append("path")
					.data([data])
					.attr("opacity", column1_opacity)
					.attr("class", "line duas ${namespace}")
					.attr("stroke", '${column1_color}')
					.attr("stroke-width", '2.8px')
					.attr("d", valueline);
				graph.append("path")
					.data([data])
					.attr("opacity", column2_opacity)
					.attr("stroke", '${column2_color}')
					.attr("stroke-width", '2.8px')
					.attr("class", "line dtas ${namespace}")
					.attr("d", valueline2);

			    
			  	// Axis
				var ${param.namespace}xaxis = svg.append("g")
					.attr("transform", "translate(0," + height + ")")
					.attr("class", "xaxis")
					.call(d3.axisBottom(${param.namespace}x))
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
				      .text("Number of Dr. Visits Before COVID+ Diagnosis")
				      .attr("font-size", '14px')
					  .attr("font-weight", "bold");

				  svg.append("g")
			      .attr("class", "axis1 ${namespace}")
			      .call(d3.axisLeft(y1).ticks(10));

				  // text label for the y axis
				  svg.append("text")
				  	.attr("transform", "rotate(-90)")
				  	.attr("y", 0 - margin.left)
				  	.attr("x",0 - (height / 2))
				  	.attr("dy", "1em")
				  	.style("text-anchor", "middle")
				  	.text("${param.column1_label}")
				  	.attr("font-size", '14px');      
				  
				  svg.append("g")
			      	.attr("class", "axis2 ${namespace}")
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
				      .text("${param.column2_label}")
				      .attr("font-size", '14px');  

		        // Add the Legend
			    var legend_keys = {"nodes":[{"text": "${param.column1_tip}", "tag": "duas", "opacity":"${param.column1_opacity}"}, {"text": "${param.column2_tip}", "tag": "dtas", "opacity":"${param.column2_opacity}"}]};

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
				    .attr("class", function(d){return d.tag + " ${namespace}";})
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
				var dua_dta_focus = graph.append("g")
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
			    	.text("${param.column1_tip}:");
				
				dua_dta_focus.append("text")
		    		.attr("x", 18)
		    		.attr("y", 30)
		    		.text("${param.column2_tip}:");
			
				dua_dta_focus.append("text")
			    	.attr("class", "tooltip-duas ${namespace}")
			    	.attr("x", ${param.column1_tip_offset})
			    	.attr("y", 18);
				
				dua_dta_focus.append("text")
					.attr("class", "tooltip-dtas ${namespace}")
					.attr("x", ${param.column2_tip_offset})
					.attr("y", 30);
				
			    
				var parseDate = d3.timeFormat("%m/%e/%Y").parse,
					bisectDate_dua_dta = d3.bisector(function(d) { return d.${param.date_column}; }).left,
					formatValue = d3.format(","),
					dateFormatter = d3.timeFormat("%m/%d/%y"),
					dateFormatter2 = d3.timeFormat("%Y-%m-%d");
				
				
			
				function dua_dta_mousemove() {
				    var x0 = ${param.namespace}x.invert(d3.mouse(this)[0]),
				        i = bisectDate_dua_dta(data, x0),
				        d0 = data[i - 1],
				        d1 = data[i];
					
					if (d0 && !d1){
				    	d1 = d0;
				    };
				    
				    if (d1 && !d0){
				    	d0 = d1;
				    };

				    var d = x0 - d0.${param.date_column} > d1.${param.date_column} - x0 ? d1 : d0;
				    
				    
				    if (width/2 > d3.mouse(this)[0]){
				    	dua_dta_focus.attr("transform", "translate(" + ${param.namespace}x(d.${param.date_column}) + "," + d3.mouse(this)[1] + ")");
				    }else{
				    	dua_dta_focus.attr("transform", "translate(" + ((${param.namespace}x(d.${param.date_column}))-150) + "," + d3.mouse(this)[1] + ")");
				    };
				   
				    dua_dta_focus.select(".tooltip-date_dta_dua").text("# of Dr. Visits: " + d.${param.date_column});
				    dua_dta_focus.select(".tooltip-duas").text(d.${param.column1}.toLocaleString());
				    dua_dta_focus.select(".tooltip-dtas").text(d.${param.column2}.toLocaleString());
				    
				    tooltipLine.attr('stroke', 'black')
				    	.attr("transform", "translate(" + ${param.namespace}x(d.${param.date_column}) + "," + 0 + ")")
				    	.attr('y1', 0)
				    	.attr('y2', height);
				};
				
				
			};
			
			
		});
</script>
