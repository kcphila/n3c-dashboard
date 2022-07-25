<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.state {
	fill: #a6a6a6;
	stroke: white;
}
    
div.region.tooltip {
	position: absolute;
	background-color: white;
  	opacity: 0.8;
  	height: auto;
	padding: 1px;
  	pointer-events: none;
}

@media (max-width: 980px) {
  .region_text {
    display: none;
  }
}

</style>

<script>
function regionalMap(data, domName) {
	
	var margin = {top: 10, right: 100, bottom: 10, left: 0},
	width = $(domName).width() - margin.left - margin.right,
	height = width;
    var projection = d3.geoAlbersUsaPr(), path = d3.geoPath().projection(projection);
    var aspect_ratio = 0.582,width,height;
    
    function drawgraphnew(){
		var newWidth = $(domName).width();
		if (newWidth > 0) {
			d3.select(domName).select("svg").remove();
			width = newWidth - margin.left - margin.right;
			height = width;
			draw();
		}
	}
	
	d3.select(domName).select("svg").remove();

 	window.onresize = drawgraphnew;
 	
 	draw();

	function fitSize(size, object){
		var width = size[0];
		var height = size[1];

		projection
			.scale(1)
			.translate([0, 0]);

		var b = path.bounds(object),
			s = 1 / Math.max((b[1][0] - b[0][0]) / width, (b[1][1] - b[0][1]) / height),
			t = [(width - s * (b[1][0] + b[0][0])) / 2, (height - s * (b[1][1] + b[0][1])) / 2];

		projection
			.scale(s)
			.translate(t);
	}

	function draw(){
		height = width * aspect_ratio;
		if (height < 300){
			height = 300;
		}
		var feature = topojson.feature(states, states.objects.states_20m_2017);
		
		var container = d3.select(domName);
	    
	    
	    var svg = container.append("svg")
	    	.attr("width", width+margin.left+margin.right)
			.attr("height", height + margin.top + margin.bottom);
	    
	    var g = svg.append("g")
	    	.attr("transform", "translate(" + margin.left + "," + margin.top + ")")
	    	.attr("id", "svg_g"+domName)
	    	.attr("width", width);
	    
	 
		
	    var paths_states = g.selectAll(".state")
			.data(feature.features)
			.enter().append("path")
			.attr("class", "state");
	    
	    fitSize([width, height], feature);
		paths_states.attr("d", path);
	    
	    
	    var regions = [
	    	  {"name": "Pacific", "contains":[ "WA" ,"OR", "CA", "AK", "HI" ], "count": 1000 },
	    	  {"name": "Mountain", "contains":[ "MT", "ID", "WY", "NV", "UT", "CO", "AZ", "NM" ], "count": 8000 },
	    	  {"name": "West North Central", "contains":[ "ND", "SD", "MN", "NE", "IA", "KS", "MO" ], "count": 3000 },
	    	  {"name": "East North Central", "contains":[ "WI", "MI", "IL", "IN", "OH" ], "count": 100 },
	    	  {"name": "West South Central", "contains":[ "OK", "AR", "TX", "LA" ], "count": 700 },
	    	  {"name": "East South Central", "contains":[ "KY", "TN", "MS", "AL" ], "count": 4700 },
	    	  {"name": "South Atlantic", "contains":[ "WV", "MD", "DE", "DC", "VA", "NC", "SC", "GA", "FL" ], "count": 6500 },
	    	  {"name": "Middle Atlantic", "contains":[ "NY", "PA", "NJ"], "count": 400 },
	    	  {"name": "New England", "contains":[ "ME", "NH", "VT", "MA", "CT", "RI"], "count": 3400 },
	    	  {"name": "Puerto Rico", "contains":[ "PR"], "count": 3400 },
	    ];
	    
	    var regions_filtered = [];
	    var max_count = 0;
	    var min_count = 100000000;

	    
	    for (i in data){
	    	if (data[i].count > max_count){
	    		max_count = data[i].count;
	    	}
	    	if (data[i].count < min_count){
	    		min_count = data[i].count;
	    	}
	    	for (x in regions){
	    		if (data[i].element == regions[x].name){
	    			var newelement = {};
	    			newelement["name"] = data[i].element;
	    			newelement["count"] = data[i].count;
	    			newelement["contains"] = regions[x].contains;
	    			newelement["site_count"] = data[i].seq;
	    			regions_filtered.push(newelement);
	    		}
	    	}    
	    }
	    
	    var middle = (max_count+min_count)/2;
	    var step = ((max_count+middle)/2)-middle;
	    
	    var domain = [min_count, Math.ceil(middle-step), Math.ceil(middle), Math.ceil(middle+step), max_count];
	    var colorScale = d3.scaleLinear()
	    	.range(["#e4e4ff", "#bab7ef", "#938bdd", "#6e5fc8", "#4833b2"])
	    	.domain(domain);
	    
	    
	    
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
			.text('Total Patients');
			
		var legend = svg.append("g")
			.attr("transform", "translate(" + (margin.right+margin.left) + " ," + (60) + " )")
			.attr("font-family", "sans-serif")
			.attr("font-size", ".8rem")
			.attr("text-anchor", "end");

       
		var defs = svg.append("defs");
		var mainGradient = defs.append("linearGradient")
			.attr("id", "myGradient")
			.attr("x1", "0%")
			.attr("x2", "0%")
			.attr("y1", "0%")
			.attr("y2", "100%");
		
		 mainGradient.append('stop')
         	.style('stop-color', "#e4e4ff")
         	.attr('offset', '0');

     	mainGradient.append('stop')
         	.style('stop-color', "#4833b2")
         	.attr('offset', '1');
     	
     	var color_legend = d3.scaleLinear()
    		.range([0,37.5,75, 112.5, 150])
    		.domain(domain);
		    
		legend.append("rect")
			.attr("x", width - 19)
			.attr("width", 19)
			.attr("height", 150)
			.attr("fill", "url(#myGradient)");

		legend.selectAll("g")
			.data(domain)
			.enter().append("text")
			.attr("x", width - 17)
			.attr("y", function(d){
				return color_legend(d);
			})
			.attr("dy", "0.32em")
			.text(function(d){
				return d.toLocaleString() + "  -";
			});
	    
	    g.selectAll(".regions")
			.data(regions_filtered)
			.enter()
			.append("path")
			.attr("d", function(data) {
				var feature2 = topojson.merge(states, states.objects.states_20m_2017.geometries.filter(function(state) { 
					return data.contains.indexOf(state.properties.STUSPS) > -1; 
				}))
				return path(feature2);
			})
			.attr("fill", function(d){
				return colorScale(d.count);
			})
			.attr("stroke","white")
			.attr("stroke-width",1)
			.attr("class", "region")
			.on("click", function(d){
				var push_data = {};
				push_data['secondary_name'] = d.name;
				push_data['secondary'] = d.name;
				window[domName.replace(/_[^_]+_[^_]+$/i,'_').replace('#', '')+'viz_constrain'](push_data, 'region'); })
			.on('mousemove', function(d){
				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
				.attr("class", "region tooltip")
				.style("opacity", 0.8)
				.style("left", (d3.event.pageX + 5) + "px")
				.style("top", (d3.event.pageY - 28) + "px")
				.html("<strong>Region:</strong> " + d.name + "<br/><strong>Total:</strong> " + d.count.toLocaleString() + "<br/><strong># Providers:</strong> " + d.site_count + "<br/><strong>Contains:</strong> " + d.contains.join(', '));
			})
			.on('mouseout', function(d){
				 d3.selectAll(".tooltip").remove(); 
			});
	    
	    var region_text = g.selectAll(".region_text")
			.data(regions_filtered)
	    	.enter().append("text")
	    	.attr("class", "region_text")
	    	.attr("text-anchor", "middle")
        	.attr("font-size", "12px")
        	.attr("stroke", "white")
        	.attr("stroke-width", 3)
	    	.attr("x", function(data) {
				var feature2 = topojson.merge(states, states.objects.states_20m_2017.geometries.filter(function(state) { 
					return data.contains.indexOf(state.properties.STUSPS) > -1; 
				}))
				return path.centroid(feature2)[0];
			})
			.attr("y", function(data) {
				var feature2 = topojson.merge(states, states.objects.states_20m_2017.geometries.filter(function(state) { 
					return data.contains.indexOf(state.properties.STUSPS) > -1; 
				}))
				return path.centroid(feature2)[1];
			})
			.text(function(d){
       			return d.name;
       		});
				
        g.selectAll("text.region_text")
			.append("tspan")
			.text('test')
			.attr("class", "region_text")
			.attr("x", function(data) {
				var feature2 = topojson.merge(states, states.objects.states_20m_2017.geometries.filter(function(state) { 
					return data.contains.indexOf(state.properties.STUSPS) > -1; 
				}))
				return path.centroid(feature2)[0];
			})
			.attr("y", function(data) {
				var feature2 = topojson.merge(states, states.objects.states_20m_2017.geometries.filter(function(state) { 
					return data.contains.indexOf(state.properties.STUSPS) > -1; 
				}))
				return path.centroid(feature2)[1];
			})
			.attr("text-anchor", "middle")
        	.attr("font-size", "12px")
        	.attr("stroke", "none")
			.text(function(d){
				return d.name;
			});

        		
		
	}

   
};
</script>  

