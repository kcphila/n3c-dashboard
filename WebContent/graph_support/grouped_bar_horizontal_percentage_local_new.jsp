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


function localHorizontalGroupedPercentageBarChart_new(data, properties) {
	
	console.log('reached');
	
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
	
	var margin = {top: 20, right: 30, bottom: 30, left: offset},
		width = $("#"+domName).width() - margin.left - margin.right,
		height = (secondary_list.length*barHeight);
	
	var original = d3.select("#"+domName).node();
	var newnode = original.cloneNode();
    original.parentNode.replaceChild(newnode, original);
	
	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = $("#"+domName).width();
			if (newWidth > 0) {
				d3.select("#"+domName).select("svg").remove();
				width = newWidth - margin.left - margin.right;
				height = (secondary_list.length*barHeight);
				draw_pbar();
			}
		});
	});
	
	myObserver.observe(d3.select("#"+domName).node());
	
	draw_pbar();
	
	function draw_pbar() {
		
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
     			var label = v[0][primary];
     			for (i in v){
     				count2 += v[i][count];
     				seq = v[i][sequence];
     				total = totalsGrouped.get(v[i][secondary]).total;
     			}
     			return {count: count2, seq: seq, total: total, label: label};
			})
     		.entries(data);
		
		var abbrev = d3.nest()
		.key(function (d) { return d[primary]; })
			.key(function (d) { return d[primary+"_abbrev"]; })
			.rollup(function(v) { })
			.entries(data);
		
		x.domain([0, 100]).nice();
		
		var category_labels = [];
		var cummulative = 0;
		groupedData.forEach(function(d, i) {
			var full = d.key;
			var ab = abbrev.find(item => item.key === full);
			d.abbrev = ab.values[0].key;
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
			.attr("class", "clipsvg")
			.attr("width", width + margin.left + margin.right + 150)
			.attr("height", height + margin.top + margin.bottom);
			
		var g = svg.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")")
			.attr("id", "svg_g"+domName);

		
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
	    	.text(function(d) { return d.abbrev })
	    	.attr("class", function(d){return "text_color " + d.key.replace(/\s/g,'')})
			.style("text-anchor", "start")
			.on('mousemove', function(d, i){
	    		var label = d.key;
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
			})
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
			.style("fill", "#696969")
			.attr("class", "secondary")
			.style("text-anchor", "start")
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
			.attr('width', function(d) { return 0;})
			.attr("height",  (barHeight- barPadding))
			.attr('rx', 2)
			.attr("fill", function(d){ return colorscale[(d.value.seq-1)]; })
			.attr("transform", function(d, i) {return "translate(0, " + ((i * barHeight)+15) + ")"; })
			.on("click", function(d, i){
				d3.selectAll(".tooltip").remove(); 
				var format = {};
				format['secondary_name'] = d.key;
				window[properties.domName.replace(/_[^_]+_[^_]+$/i,'_').replace('#', '')+'viz_constrain'](format, label2.replace(/\s/g, "")); 
			})
			.on('mousemove', function(d){
				var count2 = d.value.count;
		     	var total = d.value.total;
		     	var label = d.key;
		     	var seq = d.value.seq;
		     	var fill = colorscale[(seq-1)];
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
					.attr("class", "bar tooltip")
					.style("opacity", 0.8)
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong style='color:  " + fill + ";'>" + d.key + "</strong><br><strong>Count: </strong>" + count2.toLocaleString() + "<br><strong>% of " + d.key + " that are " + d.value.label + ": </strong>" + ((count2/total) * 100).toFixed(2) + "%");
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
			});

		serie.selectAll('rect')
			.transition().duration(1000)
			.attr("width", function(d) {return Math.max(1, x((d.value.count/d.value.total)*100)); });
	
		// Legend ////////////////////	
		var legend_text = svg.append("g")
			.attr("transform", "translate(" + 150 + " ," + 0 + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", '14px')
			.attr("font-weight", "bold")
			.attr("text-anchor", "end")
			.append("text")
			.attr("x", width+margin.right+margin.left)
			.attr("y", 9.5)
			.attr("dy", "0.32em")
			.text(label2);
			
		var legend = svg.append("g")
			.attr("font-family", "sans-serif")
			.attr("font-size", ".8rem")
			.attr("text-anchor", "end")
			.selectAll("g")
			.data(legend_label)
			.enter().append("g")
			.attr("transform", function(d, i) {
				return "translate(250," + ((i * 20)+20) + ")";
			});
	
		legend.append("rect")
			.attr("x", width - 19)
			.attr("width", 19)
			.attr("height", 19)
			.attr("fill", function(d, i) { return colorscale[i]; });
	
		legend.append("text")
			.attr("x", width - 24)
			.attr("y", 9.5)
			.attr("dy", "0.32em")
			.text(function(d) {
				return d.secondary;
		});
	}
};

</script>
