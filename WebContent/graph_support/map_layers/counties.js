//
// steps to instantiating a layer:
//

//
// 1 - load the remote data and cache locally
//

var county_data = null;

async function county_init() {
	//console.log("county_init called")
	const fetchPromise1 = fetch(getApplicationRoot() + "/resources/map_data/gz_2010_us_050_00_5m.json");
	
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
			county_data = responses[0];
			console.log("county_data", county_data);
			return Promise.all([county_data]);
		});
}

//
// 2 - define a draw function to be called from the base draw function
//

var county_g = null;
var site_by_county = null;
var county_opacityScale = null;

function nodeValue(d) {
	switch (d3.select("#county_node_selector").node().value) {
		case "non_count":
			return d.non_count;
		case "covid_count":
			return d.covid_count;
		case "patient_count_died":
			return d.patient_count_died;
		case "patient_count_died_cause_covid":
			return d.patient_count_died_cause_covid;
		default:
			console.log("node selector unknowwn value:", value);
			return 0;
	}
}

function county_draw() {
	county_g = svg.append("g").attr("class", "layer"); // we need to class this for zooming by the base code

	county_g.selectAll(".county")
		.data(county_data.features)
		.enter()
		.append("path")
		.attr("d", path)
		.attr("class", "county")
		.on("click", county_clicked)
		;
}

// this triggers on a click on a county polygon, looks up the correct state and fakes a click on that state.
function county_clicked(d) {
	//console.log("county mouse",d,path.bounds(d),d3.mouse(this));
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

function county_zoom(transform) {

}

//
// 3 - register the draw function with the base code
//

register_layer("county");
