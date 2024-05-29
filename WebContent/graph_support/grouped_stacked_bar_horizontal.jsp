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
}
</style>


<script>


// not implemented
// margin = array: [top, bottom, left, right]


function grouped_stacked_bar_horizontal(data, properties) {
	
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
	
	var margin = {top: 50, right: 60, bottom: 90, left: offset},
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
				draw();
			}
		});
	});

	myObserver.observe(d3.select("#"+domName).node());
	
	draw();
	
	function draw() {

		var x = d3.scaleLinear()
			.rangeRound([0, width]);
		var z = d3.scaleOrdinal();
		
		// get all key values
		var keys_all = data.map(function(d){ 
			return d[stack_group]; 
		});
		
		
		var keys = [... new Set(keys_all)];

		keys = keys.sort();
		keys = keys.reverse();
		var legend_map = d3.map(legend_label, function(d) { return d.secondary_name; });


		var groupData = d3.nest()
			.key(function(d) { return d[secondary] + d[primary]; })
			.rollup(function(d){
				var max = 0;
				var min = 100;
				var d2 = {secondary: d[0][secondary], primary: d[0][primary], total: 0, delta: 0};
				d.forEach(function(d){
					if (d[count]> max){
						max = d[count];
					}
					if (d[count] < min){
						min = d[count];
					}
					
					if (d2[d[stack_group]]){
						d2[d[stack_group]] = d2[d[stack_group]] + d[count];
					}else{
						d2[d[stack_group]] = d[count];
					}
					d2.total += d[count];
				})
				d2.delta = max-min;
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
			d.values = d3.stack().keys(keys)(d.values);
			d.cumulative = cumulative;
			cumulative += d.values[0].length;
			category_labels.push(d.key);
		});
		
		var axis_color = d3.scaleOrdinal()
			.range(["#000000", "#7f7e80"])
			.domain(category_labels);
		
		var bar_color = d3.scaleOrdinal()
			.range(["#EEEEEE", "white"])
			.domain(category_labels);

		var svg = d3.select("#"+domName).append("svg")
			.attr("class", "clipsvg")
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
		g.append("g")
			.attr("class", "axis xaxis")
			.attr("transform", "translate(0," + height + ")")
			.call(d3.axisBottom(x).ticks(5))

		
		// Bars ///////////////
		var categories = g.selectAll(".categories")
			.data(groupedData)
  			.enter().append("g")
  			.attr("class", function(d) {
    			return 'category category-' + d.key.replace(/[\W_]+/g,'');
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
	    	.attr("class", function(d){return "text_color " + d.key.replace(/[\W_]+/g,'')})
			.style("fill", "#3c3c3d")
			.style("text-anchor", "start")
			.attr("transform", function(d) {
				var h = (d.values[0].length * barHeight);
    			return "translate(" + -(margin.left) + " , " + ((h/2)+5) + ")";
  			})
  			.on("mouseover", function(d, i) {
				svg.selectAll(".text_color:not(." + d.key.replace(/[\W_]+/g,'') + ")").style("opacity", "0.05");
			})
			.on("mouseout", function(d, i) {
  				svg.selectAll(".text_color").style("opacity", "1");
			});
			
		
		var serie = categories.selectAll(".serie")
			.data(function(d) {return d.values;})
			.enter().append("g")
			.attr("class",function(d) { return "serie " + d.key.replace(/[\W_]+/g,'', ""); });
		
		serie.selectAll("rect")
			.data(function(d) {return d; })
			.enter().append("rect")
			.attr("class", function(d){
				var variable = d.data.primary.replace(/[\W_]+/g,'');
				var count = d[1]-d[0];
				var label = '';
		     	for (var i in d.data){
		     		if (d.data[i] == count){
		     			label = i;
		     		}
		     	};
				return "text_color " + variable + " " + "serie-rect secondary lab" + label.replace(/[\W_]+/g,'');
			})
			.attr("transform", function(d, i) {
				return "translate(0, " + (i * barHeight) + ")"; })
			.attr("x", function(d) { return x(d[0]); })
			.attr('rx', 2)
			.attr('width', function(d) { return 0;})
			.attr("height",  (barHeight- barPadding))
			.attr("fill", function(d){
				var count2 = d[1]-d[0];
				var label = '';
		     	for (var i in d.data){
		     		if (d.data[i] == count2){
		     			label = i;
		     		}
		     	};
		     	return colorscale[properties.legend_label.indexOf(label)];
			})
			.on('mousemove', function(d,i){
				// Tooltip
				var count2 = d[1]-d[0];
		     	var type = d.data.primary + " " + d.data.secondary;
		     	var label = '';
		     	for (var i in d.data){
		     		if (d.data[i] == count2){
		     			label = i;
		     		}
		     	};
		     	
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
					.attr("class", "bar tooltip")
					.style("opacity", 0.8)
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + type + "</strong><br>" + "<i class='fas fa-circle' style='color:  " + colorscale[properties.legend_label.indexOf(label)] + ";'>&nbsp;</i>" + label + "<br>" + "<strong>Proportion: </strong>" + count2.toLocaleString() );
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
			.attr("class", function(d){
				
				var variable = d.data.primary.replace(/[\W_]+/g,'');
				return "text_color " + variable + " secondary";
			})
			.style("text-anchor", "start")
			.attr("transform", function(d, i) {return "translate(0, " + ((i * barHeight)+15) + ")"; })
			.attr("x", function(d) { return (x(d.data.total)) + 5; })
			.html(function(d) {
				var string = '' + d.data.secondary + d.data.primary;
				if ( sub_labels2.includes(string) ){
					sub_labels2 = sub_labels2.filter(function(e) { return e !== string });
					return  "|&Delta;| " + d.data.delta.toLocaleString();
				}
		});

	
		serie.selectAll("text2")
			.data(function(d) {return d; })
			.enter().append("text")
			.style("fill", "#3c3c3d")
			.style("text-anchor", "end")
			.attr("transform", function(d, i) {return "translate(-5, " + ((i * barHeight)+15) + ")"; })
			.attr("class", function(d){
				return "text_color " + d.data.primary.replace(/[\W_]+/g,''); })
			.attr("x", function(d) { return x(d[0]); })
			.text(function(d) {
				var string = '' + d.data.secondary + d.data.primary;
				if ( sub_labels.includes(string) ){
					sub_labels = sub_labels.filter(function(e) { return e !== string });
					return d.data.secondary;
				}
			})
			.on("mouseover", function(d, i) {
				svg.selectAll(".text_color:not(." + d.data.primary.replace(/[\W_]+/g,'') + ")").style("opacity", "0.05");
			})
			.on("mouseout", function(d, i) {
  				svg.selectAll(".text_color").style("opacity", "1");
			});
		
		
		// draw color key on to decoupled div
		function drawColorKey() {
			d3.select("#" + properties.legendid).html("");
	    	var legend_div = d3.select("#" + properties.legendid).append("div").attr("class", "row").attr("id", properties.domName+"floating_legend");
	    	
	    	legend_div.selectAll(".legend-title")
	    		.data([properties.legendlabel])
				.enter().append("div")
	    		.attr("class", "col col-12")
	    		.html(function(d){
					return  '<h5></i>   ' + d + ' Legend</h5>';
				});
	    	
			var legend_data = legend_div.selectAll(".new_legend")
				.data(properties.legend_label)
				.enter().append("div")
				.attr("class", "col col-12 col-lg-4")
				.html(function(d,i){
					return  '<i class="fas fa-circle" style="color:' + properties.colorscale[i] + ';"></i> ' +  d;
				});
	    };
	    
	    drawColorKey();
	}
	
	
};

</script>
