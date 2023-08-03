//
// steps to instantiating a layer:
//

//
// 1 - load the remote data and cache locally
//

var collab_data = null;
var collab_edge_data = null;

async function collaboration_init() {
	const response1 = await fetch(getApplicationRoot() + "/feeds/siteCollaborations.jsp");
	collab_data = await response1.json();

	const response2 = await fetch(getApplicationRoot() + "/feeds/siteCollaborationEdges.jsp");
	collab_edge_data = (await response2.json()).edges;

	console.log("collab_data", collab_data);
	console.log("collab_edge_data", collab_edge_data);

	collaboration_draw();
}

//
// 2 - define a draw function to be called from the base draw function
//

var collaboration_g = null;
var nodeScale = null;

function collaboration_draw() {
	console.log("called", collab_data, collab_edge_data)
	var node_map = d3.map(collab_data.sites, d => d.id);

	collaboration_g = svg.append("g").attr("class", "layer"); // we need to class this for zooming by the vase code

	var color = d3.scaleOrdinal()
		.domain(["N3C", "CTSA", "GOV", "CTR", "COM", "UNAFFILIATED", "REGIONAL", "X1", "X2", "X3"])
		.range(["#007bff", "#8406D1", "#09405A", "#AD1181", "#ffa600", "#ff7155", "#a6a6a6", "8B8B8B", "black", "yellow"]);

	nodeScale = d3.scaleLinear()
		.domain([0, d3.max(collab_data.sites, function(d) { return d.count; })])
		.range([3, 25]);


	var locationBySite = [],
		positions = [];

	var sites = collab_data.sites.filter(function(site) {
		var location = [site.longitude, site.latitude];
		if (projection(location) == undefined)
			return false;
		locationBySite[site.id] = projection(location);
		positions.push(projection(location));
		return true;
	});

	var edges = [];
	collab_edge_data.filter(function(link) {
		//console.log(link);
		var source = node_map.get(link.source);
		var target = node_map.get(link.target);
		//console.log(link, source, target);
		if (source == undefined || target == undefined)
			return false;
		var count = link.count;
		var source_loc = projection([source.longitude, source.latitude]);
		var target_loc = projection([target.longitude, target.latitude]);
		//console.log(source_loc, target_loc);
		if (source_loc != undefined && target_loc != undefined)
			edges.push({ source, source_loc, target, target_loc, count })
	});

	var edgeScale = d3.scaleLinear()
		.domain([0, d3.max(edges, function(d) { return d.count; })])
		.range([0, 1]);

	var link = collaboration_g.selectAll("line")
		.data(edges)
		.enter()
		.append("line")
		.attr("class", "links")
		.style("stroke-opacity", function(d) { return edgeScale(d.count); })
		.attr("x1", function(d) { return d.source_loc[0]; })
		.attr("x2", function(d) { return d.target_loc[0]; })
		.attr("y1", function(d) { return d.source_loc[1]; })
		.attr("y2", function(d) { return d.target_loc[1]; });


	function fade(opacity, out) {
		return function(d) {
			link.style("stroke-opacity", function(o) {
				if (out) {
					return edgeScale(o.count);
				}
				return o.source == d || o.target == d ? 1 : opacity * edgeScale(o.count);
			});
		};
	}

	function collaborator_count(d) {
		var coll_count = 0;
		collab_edge_data.filter(function(o) {
			if (o.source == d.id || o.target == d.id)
				coll_count = coll_count + 1;
		});
		return coll_count;
	}

	collaboration_g.selectAll("circle")
		.data(sites)
		.enter()
		.append("svg:circle")
		.attr('class', "remove")
		.attr("transform", function(d, i) { return "translate(" + positions[i][0] + ", " + positions[i][1] + ")"; })
		.attr("r", function(d) { return nodeScale(d.count); })
		.style("fill", function(d) { return color(d.type); })
		.attr("fill-opacity", 1.0)
		.attr("fill", function(d) { return color(d.status); })
		.on("mouseover", fade(.2, false))
		.on("mouseout", fade(1, true))
		.append('title')
		.text(function(d) { return ("Site: " + d.site + "\nType: " + d.type + "\n# Investigators: " + d.count + "\n# Collaborating Sites: " + collaborator_count(d)); });
}

function collaboration_zoom(transform) {
	collaboration_g.selectAll("circle").attr('r', function(d) { return nodeScale(d.count) / transform.k; });
}

//
// 3 - register the draw function with the base code
//

register_layer("collaboration");
