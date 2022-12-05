<style>
chart {
	font: 10px sans-serif;
}

.arc path {
	stroke-width: 1px;
	stroke: #fff;
}
</style>

<script>

function localPieChart(data, domName, colorgroup) {
	var width = 325, //var width = parseInt(d3.select("${param.dom_element}").style("width"))-10,
		height = width,
		border = 10,
		full_width = 325;

	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select(domName).select("svg").remove();
				d3.select(domName+"_legend").selectAll("div").remove();
				width = newWidth/1.5;
				height = newWidth/1.5;
				full_width = newWidth;
				draw();
			}
		});
	});
	myObserver.observe(d3.select(domName).node());

	draw();

	function draw() {
		
		var formatComma = d3.format(",");
		var radius = Math.min(width - border, height - border) / 2;
		
		var outer1 = 0.8;
		var innter1 = 0.5;
		var outer2 = 0.85;

		var arc = d3.arc()
			.outerRadius(radius * outer1)
			.innerRadius(radius * innter1)
			.padAngle(0.02)
            .cornerRadius(8);
		
		var outerArc = d3.arc()
		  .innerRadius(radius * outer2)
		  .outerRadius(radius * outer2)

		var pie = d3.pie()
			.sort(null)
			.value(function(d) { return d.count; });
		
		var pieData = pie(data);

		var svg = d3.select(domName).append("svg")
			.attr("width", full_width)
			.attr("height", height)
			.append("g")
			.attr("transform", "translate(" + full_width / 2 + "," + ((height / 2)) + ")");
		

		data.forEach(function(d) {
			d.count = +d.count;
		});

		
		var legend_div = d3.select(domName+"_legend").append("div").attr("class", "row");
		
		var legend_data = legend_div.selectAll(".new_legend")
			.data(pieData)
			.enter().append("div")
			.attr("class", function(d){
				return "col col-6 col-sm-12 col-md-6 col-lg-12 filt-" + d.data.element.replace(/[^a-z0-9]/gi, '');
			})
			.on("mouseout", function() {
				d3.select(domName)
      				.selectAll("path")
      				.style("opacity", 1);
			})
			.on("mouseover", function(d){
				var classname = "filt-" + d.data.element.replace(/[^a-z0-9]/gi, '');
				d3.select(domName)
          			.selectAll("path:not(." + classname + ")")
          			.style("opacity", 0.2);
			})
			.html(function(d,i){
				var total = d3.sum(data.map(function(d) {
					return d.count;
				}));

				var percent = Math.round(1000 * d.data.count / total) / 10;
				return '<i class="fas fa-circle" style="color:' + colorgroup[d.data.seq] + ';"></i> ' + d.data.element + ' (' + percent + '%)';
			});
		
		var g = svg.selectAll(".arc")
			.data(pieData)
			.enter().append("g")
			.attr("class", "arc");
		
// 		var enteringLabels = svg.selectAll('.label').data(pieData).enter();
// 		var labelGroups = enteringLabels.append('g').attr('class', 'label');

// 		var lines = labelGroups.append('line')
// 			.attr("x1", function(d, i) {return arc.centroid(d)[0];})
// 			.attr("y1", function(d) {return arc.centroid(d)[1];})
// 			.attr("x2", function(d) {
// 		    	var centroid = arc.centroid(d),
// 		        midAngle = Math.atan2(centroid[1], centroid[0]);
// 		    	return Math.cos(midAngle) * (radius * (outer1+0.1));
// 		  	})
// 		  	.attr("y2", function(d) {
// 			    var centroid = arc.centroid(d),
// 			      midAngle = Math.atan2(centroid[1], centroid[0]);
// 			    return Math.sin(midAngle) * (radius * (outer1+0.1));
// 		  	})
// 		  	.attr("class", 'label-line')
// 		  	.attr("stroke", 'black');

// 		var textLabels = labelGroups.append('text')
// 			.attr("x", function(d, i) {
// 				var centroid = arc.centroid(d),
// 				midAngle = Math.atan2(centroid[1], centroid[0]),
// 				x = Math.cos(midAngle) * (radius * (outer1+0.1)),
// 				sign = x > 0? 1: -1;
// 				return x + (5*sign);
// 		    })
// 			.attr("y", function(d, i) {
// 				var centroid = arc.centroid(d),
// 				midAngle = Math.atan2(centroid[1], centroid[0]),
// 				y = Math.sin(midAngle) * (radius * (outer1+0.1));
// 				return y;
// 		    })
// 			.attr("text-anchor", function(d, i) {
// 				var centroid = arc.centroid(d),
// 				midAngle = Math.atan2(centroid[1], centroid[0]),
// 				x = Math.cos(midAngle) * (radius * (outer1+0.1));
// 				return x > 0? 'start' : 'end';
// 			})
// 			.attr("class", 'label-text')
// 			.text(function(d){
// 				var total = d3.sum(data.map(function(d) {
// 					return d.count;
// 				}));

// 				var percent = Math.round(1000 * d.data.count / total) / 10;
// 				return d.data.element + " (" + percent + "%)";
// 			});
		
// 		// relax the label!
// 		var alpha = 0.5,
// 		    spacing = 15;

// 		function relax() {
// 			var again = false;
// 			textLabels.each(function(d, i) {
// 				var a = this,
// 					da = d3.select(a),
// 					y1 = da.attr('y');
// 				textLabels.each(function(d, j) {
// 					var b = this;
// 					if (a === b) {
// 						return ;
// 					}
// 					db = d3.select(b);
// 					if (da.attr('text-anchor') !== db.attr('text-anchor')) {
// 						return ;
// 					}
// 					var y2 = db.attr('y');
// 					var deltaY = y1 - y2;
// 					if (Math.abs(deltaY) > spacing) {
// 						return ;
// 					}
// 					again = true;
// 					sign = deltaY > 0? 1: -1;
// 					var adjust = sign * alpha;
// 					da.attr('y', +y1 + adjust);
// 					db.attr('y', +y2 - adjust);
// 				});
// 			});
		  
// 			if (again) {
// 				var labelElements = textLabels['_groups'][0];
// 				lines.attr('y2', function(d, i) {
// 					var labelForLine = d3.select(labelElements[i]);
// 					return labelForLine.attr('y');
// 				});
// 				setTimeout(relax, 20);
// 			};
// 		};

// 		relax();
		

		var path = g.append("path")
			.attr("d", arc)
			.style("fill", function(d) { return colorgroup[d.data.seq]; })
			.attr("class", function(d){
				return "filt-" + d.data.element.replace(/[^a-z0-9]/gi, '');
			})
			.on("mouseout", function() {
 				d3.selectAll(".tooltip").remove(); 
 				d3.selectAll("path").attr("transform", "scale(1)");
				d3.select(domName+"_legend")
      				.selectAll(".col")
      				.style("opacity", 1);
			})
			.on("mouseover", function(d){
				var classname = "filt-" + d.data.element.replace(/[^a-z0-9]/gi, '');
				d3.select(this).attr("transform", "scale(1.05)");
				d3.select(domName+"_legend")
          			.selectAll(".col:not(." + classname + ")")
          			.style("opacity", 0.4);
			})
			.on('mousemove', function(d, i){
				var total = d3.sum(data.map(function(d) {
	 				return d.count;
	 			}));
				var percent = Math.round(1000 * d.data.count / total) / 10;
				
 				d3.selectAll(".tooltip").remove(); 
				d3.select("body").append("div")
					.attr("class", "composite tooltip")
					.style("left", (d3.event.pageX + 5) + "px")
					.style("top", (d3.event.pageY - 28) + "px")
					.html("<strong>" + d.data.element + ":</strong> " + percent + "%<br>" + d.data.count.toLocaleString());
			});
	}
}

</script>