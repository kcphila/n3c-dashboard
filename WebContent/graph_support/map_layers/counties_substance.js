//
// steps to instantiating a layer:
//

//
// 1 - load the remote data and cache locally
//

var county_data = null;
var site_data = null;

async function county_init() {
	//console.log("county_init called")
	const fetchPromise1 = fetch(getApplicationRoot() + "/resources/map_data/gz_2010_us_050_00_5m.json");
	const fetchPromise2 = fetch(getApplicationRoot() + "/new_ph/substance_use/feeds/geospatial_county.jsp");
	
	await Promise
		.all([fetchPromise1,fetchPromise2])
		.then(function(response) {
			var responsePromises = [];
		    for (var i = 0; i < response.length; i++) {
    		    responsePromises.push(response[i].json());
    		}
		    return Promise.all(responsePromises);
		})
		.then(function(responses) {
			county_data = responses[0];
			site_data = responses[1];
			console.log("county_data", county_data);
			console.log("site_data",site_data);
			return Promise.all([county_data,site_data]);
		});
}

//
// 2 - define a draw function to be called from the base draw function
//

var county_g = null;
var site_by_county = null;
var county_opacityScale = null;

function nodeValue(d) {
	return d.patient_count;
}

function county_draw() {
	if (county_data == null || site_data == null || svg == null)
		return;
		
	county_g = svg.append("g").attr("class", "layer"); // we need to class this for zooming by the base code

	site_by_county = d3.map(site_data, function(d) { return d.code+'|'+d.county; });

	county_opacityScale = d3.scaleLinear()
		.domain([0, d3.max(site_data, function(d) { return Math.sqrt(nodeValue(d)); })])
		.range([0.50, 1.0]);

	county_colorScale = d3.scaleLinear()
		.domain([0, d3.max(site_data, function(d) { return nodeValue(d); })])
		.range(["yellow", "red"]);

	county_g.selectAll(".county")
		.data(county_data.features)
		.enter()
		.append("path")
		.attr("fill", function(d) {
			if (site_by_county.get(d.properties.STATE+'|'+d.properties.NAME) == undefined)
				return "none";
			else
				return county_colorScale(nodeValue(site_by_county.get(d.properties.STATE+'|'+d.properties.NAME)));
		})
		.style("opacity", function(d) { //console.log(d.properties.STATE+'|'+d.properties.NAME)
			if (site_by_county.get(d.properties.STATE+'|'+d.properties.NAME) == undefined)
				return 1;
			else
				return county_opacityScale(Math.sqrt(nodeValue(site_by_county.get(d.properties.STATE+'|'+d.properties.NAME))));
		})
		.attr("d", path)
		.attr("class", "county")
		.on("click", county_clicked)
		.append('title')
		.html(function(d) {
			//console.log(zip, site_by_zip.get(zip));
			var site = site_by_county.get(d.properties.STATE+'|'+d.properties.NAME);
			if (site == undefined)
				return d.properties.STATE+', '+d.properties.NAME;
			else
				return site.county + ", " + site.state
					+ "<br><b>Patients</b>: " + (site.patient_count == 1 ? '<20' : site.patient_count)
					;
		});
}

function county_update() {
	county_g.selectAll(".county")
		.attr("fill", function(d) {
			if (site_by_county.get(d.properties.STATE+'|'+d.properties.NAME) == undefined)
				return "none";
			else
				return county_colorScale(nodeValue(site_by_county.get(d.properties.STATE+'|'+d.properties.NAME)));
		})
		.style("opacity", function(d) { //console.log(d.properties.STATE+'|'+d.properties.NAME)
			if (site_by_county.get(d.properties.STATE+'|'+d.properties.NAME) == undefined)
				return 1;
			else
				return county_opacityScale(Math.sqrt(nodeValue(site_by_county.get(d.properties.STATE+'|'+d.properties.NAME))));
		})
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
