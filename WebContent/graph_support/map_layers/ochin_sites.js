//
// steps to instantiating a layer:
//

//
// 1 - load the remote data and cache locally
//

var ochin_data = null;

async function ochin_init() {
	//console.log("ochin_init called")
	const fetchPromise1 = fetch(getApplicationRoot() + "/feeds/ochinLocations.jsp");
	
	await Promise
		.all([fetchPromise1])
		.then(function(response) {
			var responsePromises = [];
		    for (var i = 0; i < response.length; i++) {
    		    responsePromises.push(response[i].json());
    		}
		    return Promise.all(responsePromises);
		})
		.then(function(responses) {
			ochin_data = responses[0];
			console.log("ochin_data", ochin_data);
			return Promise.all([ochin_data]);
		});
}

//
// 2 - define a draw function to be called from the base draw function
//

var ochin_g = null;

function ochin_draw() {
	if (ochin_data == null || svg == null)
		return;
		
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
		.attr("transform", function(d, i) { return "translate(" + positions[i][0] + ", " + positions[i][1] + ")"; })
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
