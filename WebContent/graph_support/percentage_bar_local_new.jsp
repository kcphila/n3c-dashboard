<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>

.tick line{
  visibility:hidden;
}

rect{
	cursor: auto;
}

div.pbar.tooltip {
	position: absolute;
	background-color: white;
  	opacity: 0.8;
  	height: auto;
	padding: 1px;
  	pointer-events: none;
}

</style>

<script>

function localPercentageBarChart_new(data, properties) {
	
	var barHeight = 25; // height of one bar
	var margin = {top: 0, right: 10, bottom: 50, left: properties.barLabelWidth};
	var width = $(properties.domName).width() - margin.left - margin.right;
	var height = (data.length * barHeight) + margin.bottom + margin.top;
	
	

	
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
				width = newWidth - margin.left - margin.right;
				draw_pbar();
			}
		});
	});

	myObserver.observe(d3.select(properties.domName).node());

	
	var word_length = 3;
	
	if (data.length > 0){
		var longest_word = data.reduce(
			    function (a, b) {
			        return a.element.length > b.element.length ? a : b;
			    }
		);
		word_length =  longest_word.element.length;
	}
	

	draw_pbar();
	function draw_pbar() {     
		
		//Appends the svg to the chart-container div
		var svg = d3.select(properties.domName).append("svg")
		  .attr("width", width + margin.left + margin.right)
		  .attr("height", (data.length * barHeight) + margin.bottom + margin.top)
		  .append("g")
		  .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
		
		//Creates the xScale 
		var xScale = d3.scaleLinear()
		  .range([0,width-margin.right]);
		
		//Creates the yScale
		var y0 = d3.scaleBand()
			.paddingInner(0.2)
			.range([0, data.length * barHeight])
			.domain(data.map(function(d) { return d.abbrev; }));
		
		//Defines the y axis styles
		var yAxis = d3.axisLeft(y0);
	
		//Appends the y axis
		var yAxisGroup = svg.append("g")
			.attr("class", "y axis")
			.attr('fill', '#3c3c3d')
			.call(yAxis);
		
		//add y axis tooltip 
		svg.select(".y.axis")
	    	.selectAll(".tick")
	    	.on('mousemove', function(d, i){
	    		var label = data[i].element;
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
				.attr("class", "bar tooltip")
				.style("opacity", 0.8)
				.style("left", (d3.event.pageX + 5) + "px")
				.style("top", (d3.event.pageY - 28) + "px")
				.html(label);
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
			});
		
		svg.select(".y.axis")
			.selectAll("text")
			.attr('fill', '#3c3c3d')
			.attr('font-size', '1rem');

		
		var sumelement = 0;
		for (i in data){
			sumelement = sumelement+data[i].count;
		}
		
		function round(value, decimals) {
			 return Number(Math.round(value+'e'+decimals)+'e-'+decimals);
		}   
			
		for (i in data){
			data[i]["num2"] = 100;
			if (data[i].count == 0){
				data[i]["num"] = 0;
			}else{
				data[i]["num"] = round((data[i].count/sumelement)*100, 2);
			}
		}
		
		
		  //Sets the max for the xScale
		  var maxX = d3.max(data, function(d) { return d.num2; });
		
		  //Gets the min for bar labeling
		  var minX = d3.min(data, function(d) { return d.num; });
		
		  //Defines the xScale max
		  xScale.domain([0, maxX ]);
			
		// axis labels & ticks
			var axisContainer = svg.append('g')
				.attr("class", "axis xaxis " + properties.legend_label)
				.attr("transform", "translate(0," + (data.length * barHeight) + ")")				
				.call(d3.axisBottom(xScale).ticks(Math.round(width/100), "s").tickFormat(function(d) {  return  d + "%" }))
				.append("text")										
				.attr("fill", "#000")
				.attr("font-weight", "bold")
				.attr("text-anchor", "start")
				.text("Percent of Total")
				.attr("transform", "translate(" + ((width/2)- 60) + "," + 40 + ")"); 
			
			d3.selectAll("g.xaxis." + properties.legend_label + " g.tick")
		    	.append("line")
		    	.attr("class", "gridline")
		    	.attr("x1", 0)
		    	.attr("y1", -height+margin.top)
		    	.attr("x2", 0)
		    	.attr("y2", 0);
		
		  //Binds the data to the bars      
		  var categoryGroup = svg.selectAll(".g-category-group " + properties.legend_label)
		    .data(data)
		    .enter()
		    .append("g")
		    .attr("class", "g-category-group " + properties.legend_label)
		    .attr("transform", function(d) {
		    	return "translate(0," + (y0(d.abbrev)) + " )";
		    });
		  
		  //Appends background bar   
		  var bars2 = categoryGroup.append("rect")
		    .attr("width", function(d) { return xScale(d.num2); })
		    .attr("height", y0.bandwidth())
		    .attr("class", "g-num2")
		    .attr("fill", "#f1f1f1");
		
		  //Appends main bar   
		  var bars = categoryGroup.append("rect")
		    .attr('width', function(d) { return 0;})
		    .attr("height", y0.bandwidth())
		    .attr('rx', 2)
		    .attr("class", "g-num " + properties.legend_label)
		    .attr('fill', function(d){
				if (properties.colorscale != undefined){
					return properties.colorscale[(d.seq-1)];
				}else{
					return 'url(' + properties.domName +'mainGradient)';
				}
			})
			.on("click", function(d, i){
				var format = {};
				format['secondary_name'] = d.element;
				window[properties.domName.replace(/_[^_]+_[^_]+$/i,'_').replace('#', '')+'viz_constrain'](format, properties.legend_label.replace(/\s/g, "")); 
			})
		    .on('mousemove', function(d){
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
				.attr("class", "pbar tooltip")
				.style("opacity", 0.8)
				.style("left", (d3.event.pageX + 5) + "px")
				.style("top", (d3.event.pageY - 28) + "px")
				.html("<strong>" + d.element + "</strong><br><strong>% of View: </strong>" + d.num + "%<br><strong>Count: </strong>" + d.count.toLocaleString());
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
			});
		  
		  categoryGroup.selectAll('rect.g-num')
			.transition().duration(1000)
			.attr('width', function(d) { return xScale(d.num); });
		
		  
		  //Binds data to labels
		  var labelGroup = svg.selectAll("g-num " + properties.legend_label)
		    .data(data)
		    .enter()
		    .append("g")
		    .attr("class", "g-label-group")
		    .attr("transform", function(d) {
		    	return "translate(0," + y0(d.abbrev) + ")";
		    });
		
		  //Appends main bar labels   
		  var barLabels = labelGroup.append("text") 
		    .text(function(d) {return  d.num + "%";})
		    .attr("x", function(d) { 
		      if (minX > 80 || d.num > 98) {
		        return xScale(d.num) - 40;}
		      else {
		        return xScale(d.num) + 6;}
		     })
		    .style("fill", function(d) { 
		      if (minX > 80 || d.num > 98) {
		        return 'white';}
		      else {
		        return '#696969';}
		     })
		    .attr("y", (y0.bandwidth() / 1.4))
		    .attr("class", "g-labels");    
	  		
		
	};

}
</script>
