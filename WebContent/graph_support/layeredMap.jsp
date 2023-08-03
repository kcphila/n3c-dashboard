<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script src="https://unpkg.com/topojson@3"></script>
<script src="<util:applicationRoot/>/graph_support/albers-usa-pr.js"></script>

<script>
	// geojson / topojson tutorial: https://medium.com/@mbostock/command-line-cartography-part-1-897aa8f8ca2c#.i8ojtzq2z
	// example zoom to bounding box: https://gist.github.com/iamkevinv/0a24e9126cd2fa6b283c6f2d774b69a2
	// call a random function by name: window["testing"]("hello", "there");
	
	var layers = [];
	
	function register_layer(layer) {
		console.log("registering", layer);
		layers.push(layer);
		//console.log("layers", layers);
	}
	
	<c:if test="${not empty param.layer1}">
		<jsp:include page="${param.layer1}"/>
	</c:if>
	<c:if test="${not empty param.layer2}">
		<jsp:include page="${param.layer2}"/>
	</c:if>
	<c:if test="${not empty param.layer3}">
		<jsp:include page="${param.layer3}"/>
	</c:if>
	<c:if test="${not empty param.layer4}">
		<jsp:include page="${param.layer4}"/>
	</c:if>
	
	var width = 500;
	var height = 500;
	var zoom = null;
	var active = null;
	var projection = null;
	var path = null;
	var dom_element = null;
	var svg = null;
	
	function createLayeredMap(properties) {
		console.log("properties", properties);
		dom_element = "#"+properties.dom_element;
		if (properties.hasOwnProperty("reset_id")) {
			d3.select("#"+properties.reset_id).node().addEventListener("click", function(d) {
				reset();
			});
		}

		// Load GeoJSON data and merge with cohort data
		d3.json("<util:applicationRoot/>/"+properties.base_layer_feed, function(json) {

			var myObserver = new ResizeObserver(entries => {
				entries.forEach(entry => {
					var newWidth = Math.floor(entry.contentRect.width);
					// // console.log('body width '+newWidth);
					if (newWidth > 0) {
						d3.select(dom_element).select("svg").remove();
						width = newWidth;
						height = (width / 2);
						draw();
					}
				});
			});
			myObserver.observe(d3.select(dom_element).node());
	
			//
			// the following forces all of the layers to load their data before we make the first draw call,
			// ensuring everthing shows up on the initial rendering
			//
			var q = d3.queue();
			layers.forEach(layer => {
				console.log("calling",layer+"_init");
			    q = q.defer(window[layer+"_init"]);
			});
			q.await(draw);
	
			function draw() {

				// D3 Projection 
				switch(properties.projection) {
				case 'geoNaturalEarth1':
					projection = d3.geoNaturalEarth1()
						.translate([width / 2, (height / 2)]) // translate to center of screen
						.rotate([100,-20])
						.scale(width / 2 / Math.PI); // scale things down so see entire US
					break;
				default:
					projection = geoAlbersUsaTerritories.geoAlbersUsaTerritories()
						.translate([width / 2, (height / 2)]) // translate to center of screen
						.scale([width]); // scale things down so see entire US
					break;
				}
	
				// Define path generator
				path = d3.geoPath() // path generator that will convert GeoJSON to SVG paths
					.projection(projection); // tell path generator to use albersUsa projection
	
				svg = d3.select(dom_element)
					.append("svg")
					.attr("width", width)
					.attr("height", height);
	
				var g = svg.append("g").attr("class", "layer"); // base counts as a layer
	
				zoom = d3.zoom()
					.scaleExtent([1, 50])
					.on('zoom', function() {
						const { transform } = d3.event;
						svg.selectAll(".layer").attr('transform', transform); // each layer has it's own "g"
						layers.forEach(layer => {
							//console.log("calling",layer+"zoom");
							window[layer+"_zoom"](transform);
						});
					});

				svg.call(zoom);

				// Bind the data to the SVG and create one path per GeoJSON feature
				g.selectAll(".base")
					.data(json.features)
					.enter()
					.append("path")
					.attr("d", path)
					.attr("class", "base")
					.on("click", clicked);
	
				layers.forEach(layer => {
					console.log("calling",layer+"_draw");
					window[layer+"_draw"]();
				});
			};
				
		});
		
	}
	
	function clicked(d) {
		//console.log("clicked", d, "this", this);
		if (active === d) return reset();

		active = d;

		var bounds = path.bounds(d),
			dx = bounds[1][0] - bounds[0][0],
			dy = bounds[1][1] - bounds[0][1],
			x = (bounds[0][0] + bounds[1][0]) / 2,
			y = (bounds[0][1] + bounds[1][1]) / 2,
			scale = Math.max(1, Math.min(8, 0.9 / Math.max(dx / width, dy / height))),
			translate = [width / 2 - scale * x, height / 2 - scale * y];

		svg.transition()
			.duration(1000)
			.call( zoom.transform, d3.zoomIdentity.translate(translate[0],translate[1]).scale(scale) );
	}
	
	function reset() {
		active = null;
		
		d3.select(dom_element)
			.select("svg")
    		.transition()
    		.duration(1000)
    		.call(zoom.transform, d3.zoomIdentity); // return to initial state		
	}

</script>
