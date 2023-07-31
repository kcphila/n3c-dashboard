//
// steps to instantiating a layer:
//

//
// 1 - load the remote data and cache locally
//

var ochin_data = null;
d3.json(getApplicationRoot()+"/feeds/ochinLocations.jsp", function(initial) {
	ochin_data = initial;
	console.log("ochin", ochin_data);
	ochin_draw();
});

//
// 2 - define a draw function to be called from the base draw function
//

var ochin_g = null;

function ochin_draw() {
	ochin_g = svg.append("g").attr("class", "layer"); // we need to class this for zooming by the vase code

	var locationBySite = [],
		positions = [];

	var sites = ochin_data.sites.filter(function(site) {
		var location = [site.longitude, site.latitude];
		locationBySite[site.id] = projection(location);
		positions.push(projection(location));
		return true;
	});


	ochin_g.selectAll("circle")
		.data(sites)
		.enter()
		.append("svg:circle")
		.attr('class', "remove")
		.attr("d", function(d) { return d3.symbol().type(d3.symbolCircle).size("10")() })
		.attr("transform", function(d, i) {return "translate("+positions[i][0]+", "+positions[i][1]+")";})
		.attr("r", function(d) { return 3; })
		.attr("fill-opacity", 1)
		.attr("fill", "#0b4865");
}

function ochin_zoom(transform) {
	ochin_g.selectAll("circle").attr('r', function(d) { return 3 / transform.k; });
}

//
// 3 - register the draw function with the base code
//

register_layer("ochin");
