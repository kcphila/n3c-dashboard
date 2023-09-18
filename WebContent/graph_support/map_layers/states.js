//
// steps to instantiating a layer:
//

//
// 1 - load the remote data and cache locally
//

var state_data = null;

async function state_init() {
	//console.log("state_init called")
	const fetchPromise1 = fetch(getApplicationRoot() + "/resources/map_data/gz_2010_us_040_00_5m.json");
	
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
			state_data = responses[0];
			console.log("state_data", state_data);
			return Promise.all([state_data]);
		});
}

//
// 2 - define a draw function to be called from the base draw function
//

var state_g = null;
var site_by_state = null;
var state_opacityScale = null;

function state_draw() {
	if (state_data == null || svg == null)
		return;
		
	state_g = svg.append("g").attr("class", "layer"); // we need to class this for zooming by the base code

	state_g.selectAll(".state")
		.data(state_data.features)
		.enter()
		.append("path")
		.attr("d", path)
		.attr("class", "state")
//		.on("click", state_clicked)
		;
}

// this triggers on a click on a state polygon, looks up the correct state and fakes a click on that state.
function state_clicked(d) {
	//console.log("state mouse",d,path.bounds(d),d3.mouse(this));
	var mouse = d3.mouse(this);
	svg.selectAll(".base")
		.filter(function(d) {
			var bounds = path.bounds(d);
			if (bounds[0][0] <= mouse[0] && mouse[0] <= bounds[1][0]
				&& bounds[0][1] <= mouse[1] && mouse[1] <= bounds[1][1]) {
				//console.log(d,bounds,d3.mouse(this));
				clicked(d);
			}
		});
}

function state_zoom(transform) {

}

//
// 3 - register the draw function with the base code
//

register_layer("state");
