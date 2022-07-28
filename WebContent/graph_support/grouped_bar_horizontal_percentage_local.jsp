<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.axis .domain {
	display: none;
}

.tick line{
  visibility:hidden;
}

.graph_tooltip{
	pointer-events:none;
}
</style>

<script>


// not implemented
// margin = array: [top, bottom, left, right]


function localHorizontalGroupedPercentageBarChart(data, properties) {
	//
	// some of the logic for this one is syntactically messy, so we'll just stage things here...
	//
	var domName = properties.domName;
	var primary = properties.primary;
	var secondary = properties.secondary;
	var count = properties.count;
	var xaxis_label = properties.xaxis_label;
	var legend_label = properties.legend_label;
	var colorscale = properties.colorscale;
	var label1 = properties.label1;
	var label2 = properties.label2;
	var offset = properties.offset;
		
	var filter_icon = " &#xf0b0";
	
	var setup_data = d3.nest()
		.key(function (d) { return d[primary]; })
		.entries(data);
	
	var secondary_list = [];

	if (setup_data.length > 0){
		setup_data.forEach(function(test) {
			var unique = [];
			test.values.forEach(function(vals){
				if (!unique.includes(vals[secondary])){
					unique.push(vals[secondary]);
				};
			})
			secondary_list = secondary_list.concat(unique);
		});
	};
	
	var barPadding = 3;
	var barHeight = 20;
	
	var margin = {top: 90, right: 100, bottom: 50, left: offset},
		width = $("#"+domName).width() - margin.left - margin.right,
		height = (secondary_list.length*barHeight);
	

	function drawgraphnew(){
		var newWidth = $("#"+domName).width();
		if (newWidth > 0) {
			d3.select("#"+domName).select("svg").remove();
			width = newWidth - margin.left - margin.right;
			height = (secondary_list.length*barHeight);
			draw();
		}
	}
	
	d3.select("#"+domName).select("svg").remove();

 	window.onresize = drawgraphnew;
	
	draw();
	
	function draw() {
		
		console.log(data);
		var sequence = secondary + '_seq';
		var prime_seq = primary + '_seq';
		data.sort(function (x, y) { return x[prime_seq] - y[prime_seq] || x[sequence] - y[sequence]; });
		

		var x = d3.scaleLinear()
			.rangeRound([0, width-margin.right]);
		var x2 = d3.scaleLinear()
			.rangeRound([0, width]);
		var x1 = d3.scaleBand()		
		var z = d3.scaleOrdinal();
		
		
		var totalsGrouped = d3.nest()
 		.key(function (d) { return d[secondary]; })
 		.rollup(function(v) { 
 			var count2 = 0;
 			for (i in v){
 				count2 += v[i][count];
 			}
 			return {total: count2};
		})
 		.map(data);
		
		
		var groupedData = d3.nest()
     		.key(function (d) { return d[primary]; })
     		.key(function (d) { return d[secondary]; })
     		.rollup(function(v) { 
     			var count2 = 0;
     			var seq = 0;
     			var total = 0;
     			for (i in v){
     				count2 += v[i][count];
     				seq = v[i][sequence];
     				total = totalsGrouped.get(v[i][secondary]).total;
     			}
     			return {count: count2, seq: seq, total: total};
			})
     		.entries(data);
		
		x.domain([0, 100]).nice();
		
		var category_labels = [];
		var cummulative = 0;
		groupedData.forEach(function(d, i) {
			d.cummulative = cummulative;
			cummulative += d.values.length;
			category_labels.push(d.key);
		});
		
		
		var y_category = d3.scaleLinear().range([0, height]);
		var axis_color = d3.scaleOrdinal()
			.range(["#000000", "#7f7e80"])
			.domain(category_labels);
	
		var bar_color = d3.scaleOrdinal()
			.range(["#EEEEEE", "white"])
			.domain(category_labels);

		var svg = d3.select("#"+domName).append("svg")
			.attr("width", width + margin.left + margin.right)
			.attr("height", height + margin.top + margin.bottom);
			
		var g = svg.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")")
			.attr("id", "svg_g"+domName);
		
		g.append("text")
			.attr("y", 0 - (margin.top/2))
			.attr("x",width/2)
			.attr("dy", "1em")
			.text(xaxis_label); 
		
		g.append("g")
			.attr("class", "axis")
			.call(d3.axisTop(x).ticks(Math.round(width/100), "s").tickFormat(function(d) {  return  d + "%" }))
			.append("text")
			.attr("y", 2)
			.attr("x", x(x.ticks().pop()) + 0.5)
			.attr("dx", "0.32em")
			.attr("fill", "#000")
			.attr("font-weight", "bold")
			.attr("text-anchor", "start");
		
		// Legend ////////////////////	
		var legend_text = svg.append("g")
			.attr("transform", "translate(" + 0 + " ," + 30 + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", '14px')
			.attr("font-weight", "bold")
			.attr("text-anchor", "end")
			.append("text")
			.attr("x", width+margin.right+margin.left)
			.attr("y", 9.5)
			.attr("dy", "0.32em")
			.text(label2)
			.append("tspan")
			.attr('font-family', 'FontAwesome')
			.attr("class", "fa")
			.html(filter_icon);
			
		var legend = svg.append("g")
			.attr("transform", "translate(" + (margin.right+margin.left) + " ," + (50) + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", ".8rem")
			.attr("text-anchor", "end")
			.selectAll("g")
			.data(legend_label)
			.enter().append("g")
			.attr("transform", function(d, i) {
				return "translate(0," + i * 20 + ")";
			});

		legend.append("rect")
			.attr("x", width - 19)
			.attr("width", 19)
			.attr("height", 19)
			.attr("fill", function(d, i) { return colorscale[i]; })
			.on("click", function(d, i){
				window[domName.replace(/_[^_]+_[^_]+$/i,'_')+'viz_constrain'](d, label2.replace(/\s/g, "")); 
			})
			.on("mouseover", function(d, i) {
				svg.selectAll(".secondary:not(.lab" + d.secondary.replace(/[^A-Z0-9]/ig, "") + ")").style("opacity", "0.05");
				tooltip2.style("display", null);
			})
			.on("mouseout", function(d, i) {
  				svg.selectAll(".secondary").style("opacity", "1");
  				tooltip2.style("display", "none");
			});

		legend.append("text")
			.attr("x", width - 24)
			.attr("y", 9.5)
			.attr("dy", "0.32em")
			.text(function(d) {
				return d.secondary;
		});
		
		//////// Bars ///////////////
		var categories = g.selectAll(".categories")
			.data(groupedData)
  			.enter().append("g")
  			.attr("class", function(d) {
    			return 'category category-' + d.key.replace(/\s+/g, '');
  			})
  			.attr("transform", function(d) {
    			return "translate(0, " + ( d.cummulative * barHeight ) + ")";
  			});
		
		categories.append("rect")
			.attr("transform", function(d) {
    			return "translate("+ -margin.left +", " + 0 + ")";
  			})
			.style("fill", function(d){
				return bar_color(d.key);
			})
			.attr("height", function(d){
				return ( d.values.length * barHeight);
			})
			.attr("width", x(100)+margin.left);
		
		categories
			.append("text")
	    	.text(function(d) { return d.key })
	    	.attr("class", function(d){return "text_color " + d.key.replace(/\s/g,'')})
			.style("font-size", ".8rem")
			.style("fill", "black")
			.style("text-anchor", "start")
			.attr("transform", function(d) {
				var h = (d.values.length * barHeight);
    			return "translate(" + -(margin.left) + " , " + ((h/2)+5) + ")";
  			});
			
		var serie = categories.append("g")
			.attr("transform", function(d) {
				return "translate("+ 0 +", " + -13 + ")";
			});
		
		serie.selectAll("g")
			.data(function(d) {return d.values; })
			.enter().append("text")
			.style("fill", "#a5a2a2")
			.attr("class", "secondary")
			.style("text-anchor", "start")
			.style("font-size", ".8rem")
			.attr("transform", function(d, i) {return "translate(0, " + ((i * barHeight)+15) + ")"; })
			.attr("y", function(d) { 
				return (y_category(0) + 15); 
			})
			.attr("x", function(d) { return (x((d.value.count/d.value.total)*100) + 5); })
			.text(function(d){return ((d.value.count/d.value.total)*100).toFixed(2) + "%"});
		
		serie.selectAll("rect")
			.data(function(d) {return d.values; })
			.enter().append("rect")
			.attr("class", function(d) {
				return 'secondary lab' + d.key.replace(/[^A-Z0-9]/ig, "");
			})
			.attr("width", function(d) {console.log(d); console.log((d.value.count/d.value.total)*100); return Math.max(1, x((d.value.count/d.value.total)*100)); })
			.attr("height",  (barHeight- barPadding))
			.attr("fill", function(d){ return colorscale[(d.value.seq-1)]; })
			.attr("transform", function(d, i) {return "translate(0, " + ((i * barHeight)+15) + ")"; })
			.on("mouseover", function() { tooltip.style("display", null); })
		    .on("mouseout", function() { tooltip.style("display", "none"); })
		    .on("mousemove", function(d) {
		     	var yPosition = d3.mouse(document.getElementById("svg_g"+domName))[1];
		     	var xPosition = d3.mouse(document.getElementById("svg_g"+domName))[0];
		     	var count2 = d.value.count;
		     	var total = d.value.total;
		     	var label = d.key;
		     	var seq = d.value.seq;
		     	tooltip.selectAll("tspan").remove();
		     	tooltip
		     		.attr("transform", "translate(" + xPosition + "," +  yPosition + ")")
		     		.selectAll("text")
		     		.append("tspan")
		     		.text(label)
		     		.attr('x', 10)
  					.attr('dy', 10)
  					.attr('fill', function(d){return colorscale[(seq-1)]; })
  					.style('text-anchor', 'start')
		     		.append("tspan")
		     		.text(count2.toLocaleString())
		     		.attr('fill', 'black')
		     		.attr('x', 10)
  					.attr('dy', 20)
		     		.append("tspan")
	     			.text(function(){
	     				return  ((count2/total) * 100).toFixed(2) + "%";
	     			})
	     			.attr('fill', 'black')
	     			.attr('x', 10)
					.attr('dy', 21);
		   	 	});

		
		// Tooltip ////// 
		var tooltip = g.append("g")
    		.attr("class", "graph_tooltip")
    		.style("display", "none");
      
  		tooltip.append("rect")
    		.attr("width", 120)
    		.attr("height", 53)
    		.attr("fill", "white")
    		.style("opacity", 0.8);

		tooltip.append("text")
 			.attr("x", 30)
    		.attr("dy", "1.2em")
    		.style("text-anchor", "middle")
    		.attr("font-size", "12px")
    		.attr("font-weight", "bold");	
		
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
};

</script>
