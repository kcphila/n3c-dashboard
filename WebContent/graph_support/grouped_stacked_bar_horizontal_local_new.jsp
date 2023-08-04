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


function localHorizontalGroupedStackedBarChart_new(data, properties) {
	
	//
	// some of the logic for this one is syntactically messy, so we'll just stage things here...
	//
	var domName = properties.domName;
	var primary = properties.primary;
	var secondary = properties.secondary;
	var count = properties.count;
	var stack_group = properties.stack_group;
	var xaxis_label = properties.xaxis_label;
	var legend_label = properties.legend_label;
	var colorscale = properties.colorscale;
	var label1 = properties.label1;
	var label2 = properties.label2;
	var offset = properties.offset;
	var legendid = properties.legendid;
	
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
	
	var margin = {top: 50, right: 80, bottom: 50, left: offset},
		width = $("#"+domName).width() - margin.left - margin.right,
		height = (secondary_list.length*barHeight);
	
	var original = d3.select("#"+domName).node();
	var newnode = original.cloneNode();
    original.parentNode.replaceChild(newnode, original);
    
    var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("#"+domName).select("svg").remove();
				width = newWidth - margin.left - margin.right;
				height = (secondary_list.length*barHeight);
				if (height <= 100){
					margin.bottom = 100-height;
				} else{
					margin.bottom = 0;
				}
				draw();
			}
		});
	});

	myObserver.observe(d3.select("#"+domName).node());
	
	draw();
	
	function draw() {

		var x = d3.scaleLinear()
			.rangeRound([0, width]);
		var x1 = d3.scaleBand()		
		var z = d3.scaleOrdinal();
		
		// get all key values
		var keys_all = data.map(function(d){ 
			return d[stack_group]; 
		});
		
		
		var keys = [... new Set(keys_all)];

		var legend_map = d3.map(legend_label, function(d) { return d.secondary_name; });
		
		if (stack_group == "age"){
			function hasNumber(myString) {
				return /\d/.test(myString);
			};
			function hasDash(myString) {
				return /(-)/.test(myString);
			};
			function eval(myString){
				if(!hasNumber(myString)){
					return '1000';
				} else if(hasDash(myString)){
					 return myString.substring(myString.indexOf('-') + 1);
				} else {
					return myString.replace(/\D/g,'');
				};
			};
			
			keys = keys.sort(function(x, y){
				return Number(eval(x)) - Number(eval(y));
			});
		} else {
			keys = keys.sort();
		};

		
		var groupData = d3.nest()
			.key(function(d) { return d[secondary] + d[primary]; })
			.rollup(function(d, i){
				var d2 = {secondary: d[0][secondary], primary: d[0][primary], total: 0};
				d.forEach(function(d){
					d2[d[stack_group]] = d[count];
					d2.total += d[count];
				})
				return d2;
			})
			.entries(data)
			.map(function(d){ return d.value; });
		
		x.domain([0, d3.max(groupData, function(d) { return d.total; })]).nice();

		var groupedData = d3.nest()
			.key(function (d) { return d.primary; })
            .entries(groupData);

		var sub_labels  = [];

		groupData.forEach(function(d) {
			var string = '' + d.secondary + d.primary;
			sub_labels.push(string);
		});
		
		// need this here because editing array later
		var sub_labels2 = sub_labels;
	
		var category_labels = [];
		var cumulative = 0;
		groupedData.forEach(function(d, i) {
			var total = 0;
			for (z in d.values){
				total += d.values[z].total;
			};
			d.total = total;
			d.values = d3.stack().keys(keys)(d.values);
			d.cumulative = cumulative;
			cumulative += d.values[0].length;
			category_labels.push(d.key);
		});

		if (properties.sortmax){
			category_labels = [];
			groupedData = groupedData.sort(function(x, y){
				return y.total - x.total;
			});
			var cumulative = 0;
			groupedData.forEach(function(d, i) {
				d.cumulative = cumulative;
				cumulative += d.values[0].length;
				category_labels.push(d.key);
			});
		}
		
		var axis_color = d3.scaleOrdinal()
			.range(["#000000", "#7f7e80"])
			.domain(category_labels);
		
		var bar_color = d3.scaleOrdinal()
			.range(["#EEEEEE", "white"])
			.domain(category_labels);
		
		 
		var y_category = d3.scaleLinear().range([0, height]);

		var svg = d3.select("#"+domName).append("svg")
			.attr("class", "clipsvg")
			.attr("width", width + margin.left + margin.right + 150)
			.attr("height", height + margin.top + margin.bottom);
			
		var g = svg.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")")
			.attr("id", "svg_g"+domName);
		
		g.append("text")
			.attr("y", 0 - (margin.top/2))
			.attr("x",width/2)
			.attr("dy", "1em")
			.text(xaxis_label); 
		g.append("text")
			.attr("y", 0 - (margin.top/2))
			.attr("x", 0)
			.attr("dy", "1em")
			.attr("text-anchor", "end")
			.text(label2); 
		g.append("text")
			.attr("y", 0 - (margin.top/2))
			.attr("x", -margin.left)
			.attr("dy", "1em")
			.text(label1); 

		// Legend ////////////////////	
		var legend_text = svg.append("g")
			.attr("transform", "translate(" + (width + margin.left + margin.right + 10) + " ," + 0 + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", '14px')
			.attr("font-weight", "bold")
			.attr("text-anchor", "start")
			.append("text")
			.attr("y", 9.5)
			.text(xaxis_label);
			
		var legend = svg.append("g")
			.attr("transform", "translate(" + (width + margin.left + margin.right + 10) + " ," + 0 + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", '14px')
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
		
		// Bars ///////////////
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
  				return (d.values[0].length * barHeight);
  			})
  			.attr("width", width + margin.left);
		
		
		categories
			.append("text")
	    	.text(function(d) { return d.key })
	    	.attr("class", function(d){return "text_color " + d.key.replace(/\s/g,'')})
			.style("fill", "#3c3c3d")
			.style("text-anchor", "start")
			.attr("transform", function(d) {
				var h = (d.values[0].length * barHeight);
    			return "translate(" + -(margin.left) + " , " + ((h/2)+5) + ")";
  			})
  			.on("mouseover", function(d, i) {
				svg.selectAll(".text_color:not(." + d.key.replace(/\s/g,'') + ")").style("opacity", "0.05");
			})
			.on("mouseout", function(d, i) {
  				svg.selectAll(".text_color").style("opacity", "1");
			});
			
			
		var serie = categories.selectAll(".serie")
			.data(function(d) {return d.values;})
			.enter().append("g")
			.attr("class",function(d) { return "serie ${param.namespace}" + d.key.replace(/[^A-Za-z0-9]/g, ""); })
			.attr("fill", function(d) { return colorscale[legend_map.get(d.key).secondary_seq - 1]; });
		
		serie.selectAll("rect")
			.data(function(d) {return d; })
			.enter().append("rect")
			.attr("class", function(d){
				var count = d[1]-d[0];
				var label = '';
		     	for (var i in d.data){
		     		if (d.data[i] == count){
		     			label = i;
		     		}
		     	};
				return "serie-rect secondary lab" + label.replace(/[^A-Z0-9]/ig, "");
			})
			.attr("transform", function(d, i) {
				return "translate(0, " + (i * barHeight) + ")"; })
			.attr("y", function(d) { return y_category(0); })
			.attr("x", function(d) { return x(d[0]); })
			.attr('rx', 2)
			.attr('width', function(d) { return 0;})
			.attr("height",  (barHeight- barPadding))
			.on("click", function(d, i){
				var count2 = d[1]-d[0];
				var label = '';
				var index = 0;
		     	for (var i in d.data){
		     		if (d.data[i] == count2){
		     			label = i;
		     			for (j in legend_label){
		     				if (label == legend_label[j]['secondary_name']){
		     					index = legend_label[j]['secondary_seq'];
		     				}
		     			}
		     		}
		     	};

		     	d3.selectAll(".tooltip").remove(); 
		     	window[domName.replace(/_[^_]+_[^_]+$/i,'_')+'viz_constrain'](legend_label[index-1], xaxis_label.replace(/\s/g, ""));
		     	
				

			})
			.on('mousemove', function(d,i){
				// Tooltip
				var count2 = d[1]-d[0];
				var total = d.data.total;
				var label = '';
				var index = 0;
		     	for (var i in d.data){
		     		if (d.data[i] == count2){
		     			label = i;
		     			for (j in legend_label){
		     				if (label == legend_label[j]['secondary_name']){
		     					index = legend_label[j]['secondary_seq'];
		     				}
		     			}
		     		}
		     	};
		     	
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
					.attr("class", "bar tooltip")
					.style("opacity", 0.8)
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong><i class='fas fa-circle' style='color:  " + colorscale[index-1] + ";'>&nbsp;</i>" +  label + "</strong><br><strong>Count: </strong>" + count2.toLocaleString() + "<br><strong>Percent:</strong> " + ((count2/total) * 100).toFixed(2) + "%");
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
			});

		serie.selectAll('rect')
			.transition().duration(1000)
			.attr("width", function(d) { return Math.max(1, x(d[1]) - x(d[0])); });
		
		
		serie.selectAll("g")
			.data(function(d) {return d; })
			.enter().append("text")
			.style("fill", "#3c3c3d")
			.attr("class", "secondary")
			.style("text-anchor", "start")
			.attr("transform", function(d, i) {return "translate(0, " + ((i * barHeight)+15) + ")"; })
			.attr("y", function(d) { 
				return y_category(0); 
			})
			.attr("x", function(d) { return (x(d.data.total)) + 5; })
			.text(function(d) {
				var string = '' + d.data.secondary + d.data.primary;
				if ( sub_labels2.includes(string) ){
					sub_labels2 = sub_labels2.filter(function(e) { return e !== string });
					return d.data.total.toLocaleString();
				}
			});
		
		serie.selectAll("text2")
			.data(function(d) {return d; })
			.enter().append("text")
			.style("fill", "#3c3c3d")
			.style("text-anchor", "end")
			.attr("transform", function(d, i) {return "translate(0, " + ((i * barHeight)+15) + ")"; })
			.attr("class", function(d){return "text_color " + d.data.primary.replace(/\s/g,''); })
			.attr("y", function(d) { return y_category(0); })
			.attr("x", function(d) { return x1(d[0]); })
			.text(function(d) {
				var string = '' + d.data.secondary + d.data.primary;
				if ( sub_labels.includes(string) ){
					sub_labels = sub_labels.filter(function(e) { return e !== string });
					return d.data.secondary;
				}
			})
			.on("mouseover", function(d, i) {
				svg.selectAll(".text_color:not(." + d.data.primary.replace(/\s/g,'') + ")").style("opacity", "0.05");
			})
			.on("mouseout", function(d, i) {
  				svg.selectAll(".text_color").style("opacity", "1");
			});
		
	}
	
	// draw color key on to decoupled div
	function drawColorKey() {
		d3.select("#" + legendid).html("");
    	var legend_div = d3.select("#" + legendid).append("div").attr("class", "row").attr("id", "filters");
		
    	legend_div.selectAll(".legend-title")
    		.data([xaxis_label])
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
				format['secondary_name'] = d.secondary_name;
				window[domName.replace(/_[^_]+_[^_]+$/i,'_')+'viz_constrain'](format, xaxis_label.replace(/\s/g, ""));
			})
			.html(function(d,i){
				return  '<i class="fas fa-circle" style="color:' + colorscale[d.secondary_seq-1] + ';"></i> ' +  d.secondary;
			});
    };
    
    drawColorKey();
};

</script>
