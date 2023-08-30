<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>


// set the dimensions and margins of the graph
var ${param.container}_margin = {top: 0, right: 0, bottom: 0, left: 0},
	${param.container}_width = 445 - ${param.container}_margin.left - ${param.container}_margin.right,
	${param.container}_height = 445 - ${param.container}_margin.top - ${param.container}_margin.bottom;

var gap = 8;
var offset = 175;

// read json data
d3.json("<util:applicationRoot/>/new_ph/summary_blocks/pprl_summary_block_vizs/${param.feed}", function(error, data) {
	if (error) throw error;
	
	var data = data.rows; 
	
	var ${param.container}myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("#${param.container}").select("svg").remove();
				${param.container}_width = newWidth - ${param.container}_margin.left - ${param.container}_margin.right;
				${param.container}_height = ${param.min_height};
				draw();
			}
		});
	});

	${param.container}myObserver.observe(d3.select("#${param.container}").node());

	draw();

	function draw(){
		

		var dataRange = d3.max(data.map(function(d) { return Math.max(d.count) }));
		
		/* edit with care */
		var barWidth = ${param.container}_height / data.length,
		    yScale = d3.scaleLinear().domain([0, data.length]).range([0, ${param.container}_height-${param.container}_margin.top]),
		    total = d3.scaleLinear().domain([0, dataRange]).range([0, (${param.container}_width-offset)]);


		/* main panel */
		var vis = d3.select("#${param.graph_element}").append("svg")
		    .attr("width", ${param.container}_width)
		    .attr("height", ${param.container}_height + ${param.container}_margin.top + ${param.container}_margin.bottom);
        
		var bar = vis.selectAll("g.bar")
		    .data(data)
				.enter().append("g")
				.attr("class", "bar")
				.attr("transform", function(d, i) {return "translate(0," + (yScale(i) + ${param.container}_margin.top) + ")";});

		bar.append("a")
			.attr("href", function() {return "javascript:void(0)"})
			.on("click", function(d) {
  				console.log("reached");
  				div_id = "#" + d.viz_id;
  				$('html, body').animate({
  			        scrollTop: $(div_id).offset().top
  			    }, 500);
			})
			.append("text")
			.attr("class", "below")
			.attr("x", ${param.container}_margin.left+12)
			.attr("dy", 20)
			.attr("text-anchor", "left")
			.text(function(d) { return d.label + " (" + d.count.toLocaleString() + ")"; });
	

		bar.append("a")
			.attr("href", function() {return "javascript:void(0)"})
			.on("click", function(d) {
  				console.log("reached");
  				div_id = "#" + d.viz_id;
  				$('html, body').animate({
  			        scrollTop: $(div_id).offset().top
  			    }, 500);
			})
			.append("rect")
				.attr("transform", function(d, i) {return "translate("+offset+",0)";})
				.style("cursor", "pointer")
		    	.attr("class", "${param.container}longbar_bar")
		    	.attr("width", function(d) { return total(d.count); })
		    	.attr("height", barWidth - gap)
		    	.attr('rx', 5)
		    	.attr('fill', function(d) { return d.color; })
		    	.attr("x", ${param.container}_margin.left);

			
		
	}
})
</script>