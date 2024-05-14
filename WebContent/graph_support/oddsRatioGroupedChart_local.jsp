<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
div.point.tooltip {
	position: absolute;
	background-color: white;
  	opacity: 0.8;
  	height: auto;
	padding: 1px;
  	pointer-events: none;
}

.axis .domain {
	display:block!important;
}
</style>

<script>

function OddsRatioGroupedChart(data1, properties) {
	
	var data = data1;
	if (typeof properties.category !== 'undefined') {
		var data = data1.filter(function(el) {
			return el.cat == properties.category;
		});
	}

	var minX = (typeof properties.minX == "undefined" ? 0.0 : properties.minX);
	var maxX = (typeof properties.maxX == "undefined" ? 1.0 : properties.maxX);
	var whiskerHeight = (typeof properties.symbolSize == "undefined" ? 10 : properties.symbolSize * 2);
	var whiskerGap = (typeof properties.whiskerGap == "undefined" ? 2 : properties.whiskerGap);
	var ypadding = 40;
	var ypad = 0;

	// set the dimensions and margins of the graph
	var margin = { top: 0, right: 0, bottom: 100, left: 0 },
		width = 960 - margin.left - margin.right,
		height = whiskerHeight * data.length + whiskerGap * (data.length + 1) + margin.top + margin.bottom;

	var ${param.block}myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("#" + properties.domName).select("svg").remove();
				width = newWidth - margin.left - margin.right;
				height = whiskerHeight * data.length + whiskerGap * (data.length + 1) + margin.top + margin.bottom;
				draw_bar();
			}
		});
	});

	${param.block}myObserver.observe(d3.select("#" + properties.domName).node());

	//
	// some of the logic for this one is syntactically messy, so we'll just stage things here...
	//
	var primary = properties.primary;
	var secondary = properties.secondary;
	var count = properties.count;
	var colorscale = properties.colorscale;
	var label2 = properties.label2;

	var setup_data = d3.nest()
		.key(function(d) { return d[primary]; })
		.entries(data);

	var secondary_list = [];

	if (setup_data.length > 0) {
		setup_data.forEach(function(test) {
			var unique = [];
			test.values.forEach(function(vals) {
				if (!unique.includes(vals[secondary])) {
					unique.push(vals[secondary]);
				};
			})
			secondary_list = secondary_list.concat(unique);
		});
	};
	
	function draw_bar() {

		var groupedData = d3.nest()
			.key(function(d) { return d[primary]; })
			.key(function(d) { return d[secondary]; })
			.entries(data);

		var abbrev = d3.nest()
			.key(function(d) { return d[primary]; })
			.key(function(d) { return d[primary + "_abbrev"]; })
			.rollup(function(v) { })
			.entries(data);

		var category_labels = [];
		var cumulative = 0;
		groupedData.forEach(function(d) {
			var full = d.key;
			var ab = abbrev.find(item => item.key === full);
			d.abbrev = ab.values[0].key;
			d.cumulative = cumulative;
			cumulative += d.values.length;
			category_labels.push(d.key);
		});

		var bar_color = d3.scaleOrdinal()
			.range(["#f1f1f1", "white"])
			.domain(category_labels);

		var chart = d3.select("#" + properties.domName).append("svg")
			.attr("class", "clear_target")
			.attr("width", width + margin.left + margin.right)
			.attr("height", height + margin.top + margin.bottom)
			.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
		
		// Create the Y scale
		var y = d3.scaleBand()
			.range([0, height])
			.domain(d3.range(0, groupedData.length))
			.paddingInner(ypad)
			.paddingOuter(ypad);

		//////// Bars ///////////////
		var g = chart.append("g")
			.attr("transform", "translate(" + (properties.bandLabelWidth+ypadding) + "," + 0 + ")");

		
		var step = y.step();
		var loc = y(i);
		var pad = step*ypad; 
		
		var categories = g.selectAll(".categories")
			.data(groupedData)
			.enter().append("g")
			.attr("class", function(d) {
				return 'category category-' + d.key.replace(/\s+/g, '');
			})
			.attr("transform", function(d, i) {
				if (i == 0){
					return "translate(0, " + (pad/2) + ")";
				}else{
					return "translate(0, " + ((i*step)+(pad/2)) + ")";
				};
				
			});

		categories.append("rect")
			.attr("transform", function(d, i) {
				var step = y.bandwidth()/(1-ypad);
				var pad = step*ypad; 
				return "translate(0, " + pad/4 + ")";
			})
			.style("fill", function(d) {
				return bar_color(d.key);
			})
			.attr("height", function(d) {
				var step = y.bandwidth()/(1-ypad);
				var pad = step*ypad; 
				return step;
			})
			.attr("width", width-(properties.bandLabelWidth+ypadding));

		// Show the Y scale
		chart.append("g")
			.attr("class", "y axis")
			.attr("transform", "translate(" + (properties.bandLabelWidth+ypadding) + "," + (pad/4) + ")")
			.call(d3.axisLeft(y).tickFormat(function(d, i) { return groupedData[i].key }).tickSize(2))

		// Show the X scale
		var x = d3.scaleLinear()
			.domain([minX, maxX])
			.range([properties.bandLabelWidth+ypadding, width])
		chart.append("g")
			.attr("class", "axis xaxis")
			.attr("transform", "translate(0," + height + ")")
			.call(d3.axisBottom(x).ticks(5))

		// Add X axis label:
		chart.append("text")
			.attr("text-anchor", "middle")
			.attr("x", (properties.bandLabelWidth+ypadding) + (width - (properties.bandLabelWidth+ypadding))/2)
			.attr("y", height + margin.top + 40)
			.text(properties.xaxis_label);

		// Show the divider line
		categories
			.selectAll("divider")
			.data([0])
			.enter()
			.append("line")
			.attr("x1", function(d) { return (properties.mode == 'hazard' ? x(0) : x(1)) })
			.attr("x2", function(d) { return (properties.mode == 'hazard' ? x(0) : x(1)) })
			.attr("y1", function(d) { return (0.0) })
			.attr("y2", function(d) {  
				var step = y.bandwidth()/(1-ypad);
				var pad = step*ypad; 
				return step;; })
			.attr("transform", function(d, i) { 
				var step = y.bandwidth()/(1-ypad);
				var pad = step*ypad; 
				return "translate(-" + (properties.bandLabelWidth+ypadding) + ", " +  pad/4  + ")"; })
			.style("stroke-dasharray", ("3, 3"))
			.attr("stroke", "black")
			.style("width", 40)

		// Show the main horizontal line
		categories.append("g")
			.selectAll("horizLines")
			.data(function(d) { return d.values; })
			.enter()
			.append("line")
			.attr("class", "bartransition")
			.attr("x1", function(d,i) { return (x(d.values[0].conf_low)) })
			.attr("x2", function(d) { return (x(d.values[0].conf_high)) })
			.attr("transform", function(d, i) { 
				var yheight = y.bandwidth();
				var ytick = yheight / properties.legend_labels.length;
				var yi = i + 1;
				return "translate(-" + (properties.bandLabelWidth+ypadding) + ", " + (ytick*yi)*.75 + ")"; })
			.attr("stroke", function (d){
				var color = properties.legend_labels.indexOf(d.key);
				return categorical8[color];
			})
			.attr("stroke-width", '2.8px')
			.style("width", 40)
			.on('mousemove', function(d){
				if (properties.mode == "hazard"){
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.values[0].element 
						+ "</strong><br><strong>HR:</strong> " + d.values[0].estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.values[0].conf_low.toLocaleString() + "-" + d.values[0].conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.values[0].p.toLocaleString());
				}else{
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.values[0].cohort 
						+ "</strong><br><strong>OR:</strong> " + d.values[0].estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.values[0].conf_low.toLocaleString() + "-" + d.values[0].conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.values[0].p_value.toLocaleString());
				}
			})
			 .on('mouseout', function(d){
				d3.selectAll(".tooltip").remove(); 
			 });
	
		// Show the left whisker
		categories.append("g")
			.selectAll("leftWhisker")
			.data(function(d) { return d.values; })
			.enter()
			.append("line")
			.attr("class", "opacitytransition")
			.style('opacity', 0)
			.attr("x1", function(d) { return (x(d.values[0].conf_low)) })
			.attr("x2", function(d) { return (x(d.values[0].conf_low)) })
			.attr("y1", function(d) { return -whiskerHeight/2; })
			.attr("y2", function(d) { return whiskerHeight/2; })
			.attr("transform", function(d, i) { 
				var yheight = y.bandwidth();
				var ytick = yheight / properties.legend_labels.length;
				var yi = i + 1;
				return "translate(-" + (properties.bandLabelWidth+ypadding) + ", " + (ytick*yi)*.75 + ")"; })
			.attr("stroke", function (d){
				var color = properties.legend_labels.indexOf(d.key);
				return categorical8[color];
			})
			.style("width", 40)
			.on('mousemove', function(d){
				if (properties.mode == "hazard"){
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.values[0].element 
						+ "</strong><br><strong>HR:</strong> " + d.values[0].estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.values[0].conf_low.toLocaleString() + "-" + d.values[0].conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.values[0].p.toLocaleString());
				}else{
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.values[0].cohort 
						+ "</strong><br><strong>OR:</strong> " + d.values[0].estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.values[0].conf_low.toLocaleString() + "-" + d.values[0].conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.values[0].p_value.toLocaleString());
				}
			})
			 .on('mouseout', function(d){
				d3.selectAll(".tooltip").remove(); 
			 });

		// Show the right whisker
		categories.append("g")
			.selectAll("rightWhisker")
			.data(function(d) { return d.values; })
			.enter()
			.append("line")
			.attr("class", "opacitytransition")
			.style('opacity', 0)
			.attr("x1", function(d) { return (x(d.values[0].conf_high)) })
			.attr("x2", function(d) { return (x(d.values[0].conf_high)) })
			.attr("y1", function(d) { return -whiskerHeight/2; })
			.attr("y2", function(d) { return whiskerHeight/2; })
			.attr("transform", function(d, i) { 
				var yheight = y.bandwidth();
				var ytick = yheight / properties.legend_labels.length;
				var yi = i + 1;
				return "translate(-" + (properties.bandLabelWidth+ypadding) + ", " + (ytick*yi)*.75 + ")"; })
			.attr("stroke", function (d){
				var color = properties.legend_labels.indexOf(d.key);
				return categorical8[color];
			})
			.style("width", 40)
			.on('mousemove', function(d){
				if (properties.mode == "hazard"){
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.values[0].element 
						+ "</strong><br><strong>HR:</strong> " + d.values[0].estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.values[0].conf_low.toLocaleString() + "-" + d.values[0].conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.values[0].p.toLocaleString());
				}else{
					d3.selectAll(".tooltip").remove(); 
					d3.select("body").append("div")
					.attr("class", "point tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.values[0].cohort 
						+ "</strong><br><strong>OR:</strong> " + d.values[0].estimate.toLocaleString()+ 
						"</strong><br><strong>95% CI:</strong> " + d.values[0].conf_low.toLocaleString() + "-" + d.values[0].conf_high.toLocaleString()+
						"</strong><br><strong>P-Value:</strong> " + d.values[0].p_value.toLocaleString());
				}
			})
			 .on('mouseout', function(d){
				d3.selectAll(".tooltip").remove(); 
			 });

		// glyph for the main symbol
		switch (properties.mode) {
			case "hazard":
				categories.append("g")
					.selectAll("rects")
					.data(function(d) { return d.values; })
					.enter()
	 			    .append("rect")
	 			    .attr("class", "opacitytransition")
					.style('opacity', 0)
	        		.attr("x", function(d){return x(d.values[0].estimate) - properties.symbolSize})
					.attr("y", function(d) { return 0; })
					.attr("width", function(d){return properties.symbolSize * 2})
					.attr("transform", function(d, i) { 
						var yheight = y.bandwidth();
						var ytick = yheight / properties.legend_labels.length;
						var yi = i + 1;
						return "translate(-" + (properties.bandLabelWidth+ypadding) + ", " + (ytick*yi)*.75 + ")"; })
	        		.attr("height", properties.symbolSize * 2 )
	        		.attr("stroke", "black")
	        		.attr("fill", function (d){
						var color = properties.legend_labels.indexOf(d.key);
						return categorical8[color];
					})
				break;
			case "odds":
			default:
				categories.append("g")
					.selectAll("circles")
					.data(function(d) { return d.values; })
					.enter()
					.append("circle")
					.attr("class", "opacitytransition")
					.style('opacity', 0)
					.attr("cx", function(d) { return (x(d.values[0].estimate)); })
					.attr("r", function(d) { return (properties.symbolSize); })
					.attr("cy", function(d) { return 0; })
					.attr("transform", function(d, i) { 
						var yheight = y.bandwidth();
						var ytick = yheight / properties.legend_labels.length;
						var yi = i + 1;
						return "translate(-" + (properties.bandLabelWidth+ypadding) + ", " + (ytick*yi)*.75 + ")"; })
					.attr("stroke", "white")
					.attr("fill", function (d){
						var color = properties.legend_labels.indexOf(d.key);
						return categorical8[color];
					})
					.on('mousemove', function(d){
						d3.selectAll(".tooltip").remove(); 
						d3.select("body").append("div")
						.attr("class", "point tooltip")
						.style("left", (d3.event.pageX + 5) + "px")
						.style("top", (d3.event.pageY - 28) + "px")
						.html("<strong>" + d.values[0].cohort 
							+ "</strong><br><strong>OR:</strong> " + d.values[0].estimate.toLocaleString()+ 
							"</strong><br><strong>95% CI:</strong> " + d.values[0].conf_low.toLocaleString() + "-" + d.values[0].conf_high.toLocaleString()+
							"</strong><br><strong>P-Value:</strong> " + d.values[0].p_value.toLocaleString());
					})
			 		.on('mouseout', function(d){
						d3.selectAll(".tooltip").remove(); 
					 });
				break;
		}
		
		chart.selectAll('.opacitytransition')
			.transition().duration(1000)
			.style('opacity', 1);
	
		chart.selectAll(".bartransition").each(function(d){
			var totalLength = this.getTotalLength();
	        d3.select(this)
				.attr("stroke-dasharray", totalLength + " " + totalLength)
				.attr("stroke-dashoffset", totalLength)
				.transition()
					.duration(1500)
					.attr("stroke-dashoffset", 0);
	      
	    });
		
		// draw color key on to decoupled div
		function drawColorKey() {
			d3.select("#" + properties.legendid).html("");
        	var legend_div = d3.select("#" + properties.legendid).append("div").attr("class", "row").attr("id", "floating_legend");
        	
        	legend_div.selectAll(".legend-title")
        		.data([properties.legendlabel])
    			.enter().append("div")
        		.attr("class", "col col-12")
        		.html(function(d){
    				return  '<h5></i>   ' + d + ' Legend</h5>';
    			});
        	
    		var legend_data = legend_div.selectAll(".new_legend")
    			.data(properties.legend_labels)
    			.enter().append("div")
    			.attr("class", "col col-12 col-lg-4")
    			.html(function(d,i){
    				return  '<i class="fas fa-circle" style="color:' + categorical8[i] + ';"></i> ' +  d;
    			});
	    };
	    
	    drawColorKey();

	}		
};

</script>
