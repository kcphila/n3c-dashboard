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

div.bar.tooltip {
	position: absolute;
	background-color: white;
  	opacity: 0.8;
  	height: auto;
	padding: 1px;
  	pointer-events: none;
  	max-width: 200px;
}
</style>

<script>


// not implemented
// margin = array: [top, bottom, left, right]


function localHorizontalGroupedBarChart_new(data1, properties) {
	
	var data = data1;
	if (typeof properties.category !== 'undefined') {
		var data = data1.filter(function (el) {
			  return el.cat == properties.category;
			});
	}

	//
	// some of the logic for this one is syntactically messy, so we'll just stage things here...
	//
	var domName = properties.domName;
	var block = properties.block;
	var primary = properties.primary;
	var secondary = properties.secondary;
	var count = properties.count;
	var xaxis_label = properties.xaxis_label;
	var legend_label = properties.legend_label;
	var colorscale = properties.colorscale;
	var label1 = properties.label1;
	var label2 = properties.label2;
	var offset = properties.offset;
	
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
	
	var margin = {top: 0, right: 30, bottom: 30, left: offset},
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
				draw_bar();
			}
		});
	});
	
	myObserver.observe(d3.select("#"+domName).node());
	
	draw_bar();
	
	function draw_bar() {
		
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
 			if (properties.observationtotal){
 				for (i in v){
 					if (v[i].observation == "Has Disease"){
 						count2 += v[i][count];
 					}
 				}
 			} else {
 				for (i in v){
 					count2 += v[i][count];
 				}
 			}
 			return {total: count2};
		})
 		.map(data);
		
		
		var max_count = 0;
		
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
     				if (max_count < count2){ 
     					max_count = count2;
     				};
     			}
     			return {count: count2, seq: seq, total: total, label: label};
			})
     		.entries(data);
		
		var abbrev = d3.nest()
			.key(function (d) { return d[primary]; })
 			.key(function (d) { return d[primary+"_abbrev"]; })
 			.rollup(function(v) { })
 			.entries(data);
		
		x.domain([0, max_count]).nice();
		
		var category_labels = [];
		var cumulative = 0;
		groupedData.forEach(function(d, i) {
			var full = d.key;
			var ab = abbrev.find(item => item.key === full);
			d.abbrev = ab.values[0].key;
			d.cumulative = cumulative;
			cumulative += d.values.length;
			category_labels.push(d.key);
		});
		
		
		var y_category = d3.scaleLinear().range([0, height]);
		var axis_color = d3.scaleOrdinal()
			.range(["#000000", "#7f7e80"])
			.domain(category_labels);
	
		var bar_color = d3.scaleOrdinal()
			.range(["#f1f1f1", "white"])
			.domain(category_labels);

		var svg = d3.select("#"+domName).append("svg")
			.attr("class", "clipsvg")
			.attr("width", width + margin.left + margin.right + 150)
			.attr("height", height + margin.top + margin.bottom);
			
		var g = svg.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")")
			.attr("id", "svg_g"+domName);
		

		//////// Bars ///////////////
		var categories = g.selectAll(".categories")
			.data(groupedData)
  			.enter().append("g")
  			.attr("class", function(d) {
    			return 'category category-' + d.key.replace(/\s+/g, '');
  			})
  			.attr("transform", function(d) {
    			return "translate(0, " + ( d.cumulative * barHeight ) + ")";
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
			.attr("width", width + margin.left);
		
		categories
			.append("text")
	    	.text(function(d) { return d.abbrev })
	    	.attr("class", function(d){return "text_color " + d.key.replace(/\s/g,'')})
			.attr("transform", function(d) {
				var h = (d.values.length * barHeight);
    			return "translate(" + -(margin.left) + " , " + ((h/2)+5) + ")";
  			})
  			.on('mousemove', function(d, i){
	    		var label = d.key;
	    		var sum = 0;
	    		for (i in d.values){
	    			sum += d.values[i].value.count;
	    		};
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
					.attr("class", "bar tooltip")
					.style("opacity", 0.8)
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + label + "</strong> (" + sum.toLocaleString() + ")");
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
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
			.attr("x", function(d) { return (x(d.value.count)) + 5; })
			.text(function(d){return d.value.count.toLocaleString()});
		
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
		     	
		     	var percentage = "";
		     	
		     	if (typeof properties.nopercent == 'undefined') {
		    		percentage = "<br><strong>% of " + d.key + " that are " + d.value.label + ": </strong>" + ((count2/total) * 100).toFixed(2) + "%";
		    	};
		     	
		     	
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
					.attr("class", "bar tooltip")
					.style("opacity", 0.8)
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong style='color:  " + fill + ";'>" + d.key + "</strong><br><strong>Count: </strong>" + count2.toLocaleString() + percentage);
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
			});
		
		serie.selectAll('rect')
			.transition().duration(1000)
			.attr("width", function(d) {return Math.max(1, x(d.value.count)); });
		
		
		// draw color key on to decoupled div
		function drawColorKey() {
			d3.select("#" + properties.legendid).html("");
        	var legend_div = d3.select("#" + properties.legendid).append("div").attr("class", "row").attr("id", "filters");
    		
        	legend_div.selectAll(".legend-title")
        		.data([label2])
    			.enter().append("div")
        		.attr("class", "col col-12")
        		.html(function(d){
    				return  '<h5><i class="fas fa-filter"></i>   ' + d + ' Legend</h5>';
    			});
        	
    		var legend_data = legend_div.selectAll(".new_legend")
    			.data(legend_label)
    			.enter().append("div")
    			.attr("class", "filter_col col col-6 col-lg-3")
    			.on("click", function(d, i){
    				var format = {};
    				format['secondary_name'] = d.secondary;
    				window[properties.domName.replace(/_[^_]+_[^_]+$/i,'_').replace('#', '')+'viz_constrain'](format, label2.replace(/\s/g, ""));
				})
    			.html(function(d,i){
    				return  '<i class="fas fa-circle" style="color:' + colorscale[d.secondary_seq-1] + ';"></i> ' +  d.secondary;
    			});
	    };
	    
	    drawColorKey();
	    
	    // overdraw width and put legend outside of clip path (to only show on download)
	    
		
	    var legend_text = svg.append("g")
	    	.attr("transform", "translate(" + (width + margin.left + margin.right) + " ," + 0 + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", '14px')
			.attr("font-weight", "bold")
			.attr("text-anchor", "start")
			.append("text")
			.attr("y", 9.5)
			.attr("dy", "0.32em")
			.text(label2);
	
	    var legend = svg.append("g")
	    	.attr("transform", "translate(" + (width + margin.left + margin.right) + " ," + 0 + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", ".8rem")
			.selectAll("g")
			.data(legend_label)
			.enter().append("g")
			.attr("transform", function(d, i) {
				return "translate(0," + ((i * 20)+20) + ")";
			});
	
		legend.append("rect")
			.attr("x", 0)
			.attr("width", 19)
			.attr("height", 19)
			.attr("fill", function(d, i) { return colorscale[i]; });
	
		legend.append("text")
			.attr("x", 27)
			.attr("y", 9.5)
			.attr("dy", "0.32em")
			.text(function(d) {
				return d.secondary;
		});
	}
};

</script>
