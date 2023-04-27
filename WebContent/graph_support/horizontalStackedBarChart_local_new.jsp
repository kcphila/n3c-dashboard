<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.axis .domain {
	display: none;
}

.tick line{
  visibility:hidden;
}

rect{
	cursor: auto;
}

.graph_tooltip{
	pointer-events:none;
}
.y.axis{
	font-size: 1rem;
}

</style>
<script>

function localHorizontalStackedBarChart_new(data, properties) {
	
	var secondary_range = (properties.secondary_range === undefined ? categorical : properties.secondary_range);
	var legend_label = (properties.legend_label === undefined ? "Legend" : properties.legend_label);

	
	var setup_data = d3.nest()
		.key(function (d) { return d.element; })
		.entries(data);

	var barPadding = 3;
	var barHeight = 20;
	var margin = { top: 0, right: 30, bottom: 0, left: properties.barLabelWidth },
		width = $("#"+properties.domName).width() - margin.left - margin.right,
		height = (setup_data.length*barHeight);
	
	var original = d3.select("#"+properties.domName).node();
	var newnode = original.cloneNode();
    original.parentNode.replaceChild(newnode, original);


	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("#"+properties.domName).select("svg").remove();
				width = newWidth - margin.left - margin.right;
				height = (setup_data.length*barHeight);
				if (height <= 100){
					margin.bottom = 100-height;
				} else{
					margin.bottom = 0;
				}
				draw();
			}
		});
	});

	myObserver.observe(d3.select("#"+properties.domName).node());

	draw();

	function draw() {
		var svg = d3.select("#"+properties.domName).append("svg")
			.attr("class", "clipsvg")
			.attr("width", width + margin.left + margin.right + 150)
			.attr("height", Number(height) + margin.top + margin.bottom)
			.attr("id", properties.domName.replace("#", "") + "svgarea");
		
		var g = svg.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")")
			.attr("id", "svg_g"+properties.domName);

		var y = d3.scaleBand().range([0+margin.top, height]);
		
		var x = d3.scaleLinear()	
			.range([0, width - margin.right]);	

		var z = secondary_range;

		var keys = data.map(function(d) { return d.element; });
		
		var legend_map = d3.map(properties.legend_data, function(d) { return d.secondary_name; });

		var stackData = myStack(data);
		
		function sortFunction(a, b) {
		    return (a.count > b.count) ? -1 : 1;
		}
		if ((properties.ordered != undefined) && (properties.ordered == 1) ){
			data.sort(sortFunction);
		}
		
		y.domain(data.map(function(d) { return d.abbrev;}));
		
		
		x.domain([0, d3.max(data, function(d) { return d.count; })]).nice();	
		g.append("g")
			.attr("class", "y axis")
			.attr("transform", "translate(0,0)") 						
			.call(d3.axisLeft(y).tickFormat(function (d){
				var trimmedString = d.substring(0, 25);
				if (trimmedString != d){
					trimmedString = trimmedString + '...'
				}
				return trimmedString;
			}));		
		
		//add y axis tooltip 
		g.select(".y.axis")
	    	.selectAll(".tick")
	    	.on('mousemove', function(d,i){
	    		var label = data[i].element;
	    		var total = data[i].count;
	    		
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
					.attr("class", "text tooltip")
					.style("opacity", 0.9)
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" +  label + "</strong> (" + total.toLocaleString() + ")");
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
			})
			.selectAll("text")
			.attr("fill", "#3c3c3d");
		
		var color_cats = [];

		var barsect = g.append("g")
			.selectAll("g")
			.data(stackData)
			.enter().append("g")
			.attr("class", function(d, i) {color_cats.push(d[0][2]);  return "serie " + "color-" + z[i].substring(1); })
			.attr("fill", function(d,i) {return z[i]; });
		

		barsect.selectAll("rect")
			.data(function(d) { return d; })
			.enter().append("rect")
			.attr("class", function(d){ return properties.domName+"-rect "; })
			.attr("y", function(d,i) { return y(data[i].abbrev); })
			.attr("x", function(d) { return x(d[0]); })
			.attr('rx', 2)
			.attr('width', function(d) { return 0;})
			.attr("height",  (barHeight- barPadding))
			.on("click", function(d, i){
				d3.selectAll(".tooltip").remove(); 
				window[properties.domName.replace(/_[^_]+_[^_]+$/i,'_')+'viz_constrain'](legend_map.get(d[2]), legend_label.replace(/\s/g, "")); 
			})
			.on('mousemove', function(d,i){
				// Reduce opacity of all rect to 0.2
			    d3.selectAll("."+properties.domName+"-rect").style("opacity", 0.2)
			    // Highlight all rects of this subgroup with opacity 1.
 				d3.select(this.parentNode).selectAll("."+properties.domName+"-rect")
			      .style("opacity", 1);
				 
				// Tooltip
				var count2 = d[1]-d[0];
				var index = 0;
				for (i in properties.legend_data){
					if (properties.legend_data[i]['secondary'] == d[2]){
						index = properties.legend_data[i]['secondary_seq'];
					}
				}
		     	
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
					.attr("class", "bar tooltip")
					.style("opacity", 0.8)
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong><i class='fas fa-circle' style='color:  " + secondary_range[index-1] + ";'>&nbsp;</i>" +  d[2] + "</strong><br><strong>Count: </strong>" + count2.toLocaleString() + "<br><strong>Percent:</strong> " + ((count2/d[3]) * 100).toFixed(2) + "%");
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
				// Back to normal opacity: 1
				d3.selectAll("."+properties.domName+"-rect")
					.style("opacity",1);
			});
		
		barsect.selectAll('rect')
			.transition().duration(1000)
			.attr("width", function(d) {return x(d[1]) - x(d[0]); });
	
		
		function nFormatter(num, digits) {
			  const lookup = [
			    { value: 1, symbol: "" },
			    { value: 1e3, symbol: "k" },
			    { value: 1e6, symbol: "M" },
			    { value: 1e9, symbol: "G" },
			    { value: 1e12, symbol: "T" },
			    { value: 1e15, symbol: "P" },
			    { value: 1e18, symbol: "E" }
			  ];
			  const rx = /\.0+$|(\.[0-9]*[1-9])0+$/;
			  var item = lookup.slice().reverse().find(function(item) {
			    return num >= item.value;
			  });
			  return item ? (num / item.value).toFixed(digits).replace(rx, "$1") + item.symbol : "0";
		}
		
		function string_length_test(string) {
			w = string.length * 8.5;
			  return w;
		};
			
		function hexToRgbA(hex){
		    var c;
		    if(/^#([A-Fa-f0-9]{3}){1,2}$/.test(hex)){
		        c= hex.substring(1).split('');
		        if(c.length== 3){
		            c= [c[0], c[0], c[1], c[1], c[2], c[2]];
		        }
		        c= '0x'+c.join('');
		        return [(c>>16)&255, (c>>8)&255, c&255];
		    }
		    throw new Error('Bad Hex');
		}
		
		
		barsect.selectAll("g")
			.data(function(d) {return d; })
			.enter().append("text")
			.text(function(d) {
				label_check = 0;
				if (d[0] == 0 && d[1] == d[3]){
					label_check = 1;
				}
				value =  nFormatter(d[1]-d[0], 2);
				text_width = string_length_test(value);
				bar_width = x(d[1]) - x(d[0]);
				if (text_width < (bar_width) && label_check != 1){
					return value;
				} else{
					return;
				};
			})
			.style("fill", function(d) {
				color = z[color_cats.indexOf(d[2])];
				color_rgb = hexToRgbA(color);
					
				brightness_back = (299*color_rgb[0] + 587*color_rgb[1] + 114*color_rgb[2]) / 1000;
			
				if (brightness_back >= 128){
					return 'black';
				} else{
					return 'white';
				};
			})
			.attr("y", function(d,i) { return (y(data[i].abbrev)) + (barHeight/2)+(barPadding) ; })
			.attr("x", function(d) { return (x(d[0])) + 5; })
			.attr("font-size", "12px");
		
		
		barsect.selectAll("g")
			.data(function(d) {return d; })
			.enter().append("text")
			.style("fill", "#a5a2a2")
			.attr("class", "secondary")
			.style("text-anchor", "start")
			.attr("y", function(d,i) { return (y(data[i].abbrev)) + (barHeight/2)+(barPadding) ; })
			.attr("x", function(d) { return (x(d[3])) + 5; })
			.text(function(d) {
				if(d[2] == properties.legend_data[0].secondary){
					return nFormatter(d[3], 2);
				}
			});

		// Legend ////////////////////	
		var legend_text = svg.append("g")
			.attr("transform", "translate(" + (width + margin.left + margin.right + 10) + " ," + 0 + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", '14px')
			.attr("font-weight", "bold")
			.attr("text-anchor", "start")
			.append("text")
			.attr("y", 9.5)
			.text(legend_label);

		var legend = svg.append("g")
			.attr("transform", "translate(" + (width + margin.left + margin.right + 10) + " ," + 0 + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", '14px')
			.selectAll("g")
				.data(properties.legend_data)
				.enter().append("g")
				.attr("transform", function(d, i) {
					return "translate(0," + ((i * 20)+20) + ")";
			});
	
		legend.append("rect")
			.attr("x", 0)
			.attr("width", 19)
			.attr("height", 19)
			.attr("fill", function(d, i) { return z[i]; });
			
		legend.append("text")
			.attr("x", 27)
			.attr("y", 9.5)
			.attr("dy", "0.32em")
			.text(function(d) {	return d.secondary; });
	};

	// draw color key on to decoupled div
	function drawColorKey() {
		d3.select("#" + properties.legendid).html("");
    	var legend_div = d3.select("#" + properties.legendid).append("div").attr("class", "row").attr("id", "filters");
		
    	legend_div.selectAll(".legend-title")
    		.data([legend_label])
			.enter().append("div")
    		.attr("class", "col col-12")
    		.html(function(d){
				return  '<h5><i class="fas fa-filter"></i>   ' + d + ' Legend</h5>';
			});
    	
		var legend_data = legend_div.selectAll(".new_legend")
			.data(properties.legend_data)
			.enter().append("div")
			.attr("class", "filter_col col col-6 col-lg-3")
			.on("click", function(d, i){
				var format = {};
				format['secondary_name'] = d.secondary;
				window[properties.domName.replace(/_[^_]+_[^_]+$/i,'_').replace('#', '')+'viz_constrain'](format, legend_label.replace(/\s/g, ""));
			})
			.on("mouseover", function(d, i) {
				d3.select("#" + properties.domName.replace("#", "") + "svgarea")
					.selectAll(".serie:not(.color-" + secondary_range[i].substring(1) + ")").style("opacity", "0.2");
			})
			.on("mouseout", function(d, i) {
				d3.select("#" + properties.domName.replace("#", "") + "svgarea").selectAll(".serie").style("opacity", "1");
			})
			.html(function(d,i){
				return  '<i class="fas fa-circle" style="color:' + secondary_range[d.secondary_seq-1] + ';"></i> ' +  d.secondary;
			});
    };
    
    drawColorKey();
	
	function myStack(data) {
		var result = new Array();
		
		if (data.length == 0)
			return result;
		
		var previous = 0;
		for (let secondary = 1; secondary < data[0].secondary.length; secondary++) {
			var newrow = new Array();
			for (let primary = 0; primary < data.length; primary++) {
				if (previous == 0){
					newrow.push([0, data[primary].secondary[secondary], properties.legend_data[secondary-1].secondary, data[primary].count ]);
				}else{
					newrow.push([previous[primary][1], previous[primary][1] + data[primary].secondary[secondary], properties.legend_data[secondary-1].secondary, data[primary].count ]);
				}
			}	
			result.push(newrow);
			previous = newrow;
		}
		return result;
	}

}
</script>
