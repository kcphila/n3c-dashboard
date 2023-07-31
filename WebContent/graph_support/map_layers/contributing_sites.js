//
// steps to instantiating a layer:
//

//
// 1 - load the remote data and cache locally
//

var contrib_data = null;
d3.json(getApplicationRoot()+"/feeds/siteLocations.jsp", function(initial) {
	contrib_data = initial;
	console.log("contrib_data", contrib_data);
	contributing_draw();
});

//
// 2 - define a draw function to be called from the base draw function
//

var contrib_g = null;
function contributing_draw() {
	contrib_g = svg.append("g").attr("class", "layer"); // we need to class this for zooming by the vase code

			var color = d3.scaleOrdinal() 
				.domain(["available", "submitted", "pending"])
				.range(["#007bff", "#8406D1", "#8406D1"]);

	var locationBySite = [],
		positions = [];

	var sites = contrib_data.sites.filter(function(site) {
		var location = [site.longitude, site.latitude];
		if (projection(location) == "undefined")
			return false;
		locationBySite[site.id] = projection(location);
		positions.push(projection(location));
		return true;
	});


	contrib_g.selectAll("circle")
		.data(sites)
		.enter()
		.append("svg:circle")
		.attr('class', "remove")
		.attr("d", function(d) { return d3.symbol().type(d3.symbolCircle).size("10")() })
		.attr("transform", function(d, i) {return "translate("+positions[i][0]+", "+positions[i][1]+")";})
		.attr("r", function(d) { return 7; })
		.attr("fill-opacity", 0.5)
		.attr("fill", function(d) { return color(d.status); })
		.append('title')
		.html(function(d) { return ("<b>Site:</b> <a href='" + d.url + "'>" + d.site + "</a><br><b>Type:</b> " + d.type + "<br><b>Status:</b> " + d.status); });
		
}

function contributing_zoom(transform) {
	contrib_g.selectAll("circle").attr('r', function(d) { return 7 / transform.k; });
}

//
// 3 - register the draw function with the base code
//

register_layer("contributing");
