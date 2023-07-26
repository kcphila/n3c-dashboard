<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<style>

.state {
	fill: #cccccc;
	stroke: #ffffff;
	stroke-width: 1;
    vector-effect: non-scaling-stroke; // line height won't scale
}
    
.zip {
	fill: yellow;
	stroke: brown;
	stroke-width: 1;
    vector-effect: non-scaling-stroke; // line height won't scale
}

</style>
<div class="btn-group float-right">
	<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		<i class="fas fa-download"></i>
	</button>
	<div class="dropdown-menu dropdown-menu-right">
		<a class="dropdown-item" onclick="saveVisualization('graph', 'environmental_map.jpg');">Save as JPG</a> <a class="dropdown-item" onclick="saveVisualization('graph', 'environmental_map.png');">Save
			as PNG</a> <a class="dropdown-item" onclick="saveVisualization('graph', 'environmental_map.svg');">Save as SVG</a>
	</div>
</div>
<p>Node Value: <select id="node_selector">
		<option value="non_count">COVID- Patient Count</option>
		<option value="covid_count">COVID+ Patient Count</option>
		<option value="patient_count_died">Mortality Count</option>
		<option value="patient_count_died_cause_covid">Mortality due to COVID Count</option>
	</select>

<div id="graph" style="overflow: hidden;"></div>
<div id="site-roster"></div>
<script src="https://unpkg.com/topojson@3"></script>

<script>
	// geojson / topojson tutorial: https://medium.com/@mbostock/command-line-cartography-part-1-897aa8f8ca2c#.i8ojtzq2z
	
	function getTableData(table) {
		var tableData = {};
		const dataArray = [];
	
		table.rows({ search: "applied" }).every(function() {
			const data = this.data();
			dataArray.push(data);
		});
	
		tableData["sites"] = dataArray;
		return tableData;
	}
	
	
	//////////////////////////////////////////////// D3 VIZ /////////////////////////////////////////////////
	var width = null;
	var height = null;
	var zips = null;
	var site_by_zip = null;
	
	function createD3Chart(sites_data) {
		//console.log("sites_data", sites_data);
		d3.select("#graph").select("svg").remove();
	
		// Load the Cohort Data
		d3.json("<util:applicationRoot/>/feeds/map_data.jsp", function(error, data) {
			if (error) throw error;
	
			site_by_zip = d3.map(sites_data.sites, function(d) { return d.postal_code; });

			var myObserver = new ResizeObserver(entries => {
				entries.forEach(entry => {
					var newWidth = Math.floor(entry.contentRect.width);
					// // console.log('body width '+newWidth);
					if (newWidth > 0) {
						d3.select("#graph").select("svg").remove();
						width = newWidth;
						height = (width / 2);
						draw();
					}
				});
			});
			myObserver.observe(d3.select("#graph").node());
	
			draw();
	
			function draw() {
				d3.select("#graph").select("svg").remove();
	
				// D3 Projection 
				var projection = d3.geoAlbersUsa()
					.translate([width / 2, (height / 2)]) // translate to center of screen
					.scale([width]); // scale things down so see entire US
	
				// Define path generator
				var path = d3.geoPath() // path generator that will convert GeoJSON to SVG paths
					.projection(projection); // tell path generator to use albersUsa projection
	
				var svg = d3.select("#graph")
					.append("svg")
					.attr("width", width)
					.attr("height", height);
	
				var g = svg.append("g");
	
				function nodeValue(d) {
					switch (d3.select("#node_selector").node().value) {
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
				
				var opacityScale = d3.scaleLinear()
				.domain([0, d3.max(sites_data.sites, function(d) { return Math.sqrt(nodeValue(d)); })])
				.range([0.20, 1.0]);

				const zoom = d3.zoom()
					.scaleExtent([1, 50])
					.on('zoom', function() {
						const { transform } = d3.event;
						g.attr('transform', transform);
					});
	
				svg.call(zoom);
	
				var tool_tip = d3.tip()
					.attr("class", "d3-tip")
					.offset([-8, 0])
					.html(function(d) {
						var zip = (typeof d.properties.ZIP3 === "undefined" ? d.properties.ZIP : d.properties.ZIP3+"xx");
						//console.log(zip, site_by_zip.get(zip));
						var site = site_by_zip.get(zip);
						return zip + ", " + site.cityname + ", " + site.statename;
					});
				svg.call(tool_tip);

				var dataArray = [];
	
				var states = data.states;
	
				for (var d = 0; d < states.length; d++) {
					dataArray.push(parseFloat(states[d].count))
				}
	
				// Load GeoJSON data and merge with cohort data
				d3.json("<util:applicationRoot/>/feeds/us-states.json", function(json) {
	
					// Bind the data to the SVG and create one path per GeoJSON feature
					g.selectAll(".state")
						.data(json.features)
						.enter()
						.append("path")
						.attr("d", path)
						.attr("class", "state");
	
					var graph = sites_data;
					var locationBySite = [],
						positions = [];
	
					var sites = graph.sites.filter(function(site) {
						var location = [site.longitude, site.latitude];
						locationBySite[site.id] = projection(location);
						if (projection(location) == undefined)
							return false;
						positions.push(projection(location));
						return true;
					});
	
				});
	
				d3.json("<util:applicationRoot/>/new_ph/environmental/data/zip35-simple.json", function(incoming_zips) {
					zips = incoming_zips;
					//console.log("zips", zips);
					// Bind the data to the SVG and create one path per GeoJSON feature
					g.selectAll(".zip")
						.data(topojson.feature(zips, zips.objects.zip35).features)
						.enter()
						.append("path")
						.attr("d", path)
						.style("opacity", function(d) { // problem states: CO KS MO TX WY
							//if (d.properties.STATE == "CO" || d.properties.STATE == "KS" || d.properties.STATE == "MO" || d.properties.STATE == "TX" || d.properties.STATE == "WY") {
							//	if (d.properties.STATE == "KS" && d.properties.ZIP3 != "660") {
							//		//console.log(d.properties.ZIP3, d.properties.ZIP, site_by_zip.get(d.properties.ZIP3+"xx"),site_by_zip.get(d.properties.ZIP),d.properties.STATE);
							//		//console.log(path(d))
							//	} else {
							//		return 0.0;
							//	}
							//}
							if (typeof site_by_zip.get(d.properties.ZIP3+"xx") !== "undefined") {
								//console.log(d.properties.ZIP3, site_by_zip.get(d.properties.ZIP3+"xx"), nodeValue(site_by_zip.get(d.properties.ZIP3+"xx")),d); 
								return opacityScale(Math.sqrt(nodeValue(site_by_zip.get(d.properties.ZIP3+"xx"))));
							} else if (typeof site_by_zip.get(d.properties.ZIP) !== "undefined") {
								//console.log(d.properties.ZIP, site_by_zip.get(d.properties.ZIP), nodeValue(site_by_zip.get(d.properties.ZIP)), d); 
								return opacityScale(Math.sqrt(nodeValue(site_by_zip.get(d.properties.ZIP))));								
							} else
								return 0.0;
						})
						.attr("class", "zip")
						.on("mouseover", tool_tip.show)
						.on("mouseout", tool_tip.hide);
				});
	
			};
		});
	
	}
	
	function clickfilter(){
		table2.draw();
	}
	
	function update(data) {
		//console.log("data", data);
	
		var svg = d3.select("#graph").select("svg");
		var g = svg.select("g");
	
		node_map = d3.map(data.sites, d => d.id);
	
		var projection = d3.geoAlbersUsa()
			.translate([width / 2, (height / 2)]) // translate to center of screen
			.scale([width]); // scale things down so see entire US
		var graph = data;
		var locationBySite = [], positions = [];
		var sites = graph.sites.filter(function(site) {
			var location = [site.longitude, site.latitude];
			locationBySite[site.id] = projection(location);
			if (projection(location) == undefined)
				return false;
			positions.push(projection(location));
			return true;
		});
	
		// Define path generator
		var path = d3.geoPath() // path generator that will convert GeoJSON to SVG paths
			.projection(projection); // tell path generator to use albersUsa projection

		var site_by_zip = d3.map(data.sites, function(d) { return d.postal_code; });

		function nodeValue(d) {
			switch (d3.select("#node_selector").node().value) {
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
		
		var opacityScale = d3.scaleLinear()
			.domain([0, d3.max(data.sites, function(d) { return Math.sqrt(nodeValue(d)); })])
			.range([0.20, 1.0]);

		var tool_tip = d3.tip()
			.attr("class", "d3-tip")
			.offset([-8, 0])
			.html(function(d) {
				var zip = (typeof d.properties.ZIP3 === "undefined" ? d.properties.ZIP : d.properties.ZIP3+"xx");
				//console.log(zip, site_by_zip.get(zip));
				var site = site_by_zip.get(zip);
				if (typeof site === "undefined")
					return "";
				else {
					return zip + ", " + site.cityname + ", " + site.statename;
				}
			});
		svg.call(tool_tip);

		const zoom = d3.zoom()
			.scaleExtent([1, 30])
			.on('zoom', function() {
				const { transform } = d3.event;
				g.attr('transform', transform);
			});
	
		g.selectAll(".zip").remove();
		
		// Bind the data to the SVG and create one path per GeoJSON feature
		g.selectAll(".zip")
			.data(topojson.feature(zips, zips.objects.zip35).features)
			.enter()
			.append("path")
			.attr("d", path)
			.style("opacity", function(d) {
				if (typeof site_by_zip.get(d.properties.ZIP3+"xx") !== "undefined") {
					//console.log(d.properties.ZIP3, site_by_zip.get(d.properties.ZIP3+"xx"), nodeValue(site_by_zip.get(d.properties.ZIP3+"xx")),d); 
					return opacityScale(Math.sqrt(nodeValue(site_by_zip.get(d.properties.ZIP3+"xx"))));
				} else if (typeof site_by_zip.get(d.properties.ZIP) !== "undefined") {
					//console.log(d.properties.ZIP, site_by_zip.get(d.properties.ZIP), nodeValue(site_by_zip.get(d.properties.ZIP)), d); 
					return opacityScale(Math.sqrt(nodeValue(site_by_zip.get(d.properties.ZIP))));								
				} else
					return 0.0;
			})
			.attr("class", "zip")
			.on("mouseover", tool_tip.show)
			//.on("mouseover", function(d) { conditionalTooltip(d); })
			.on("mouseout", tool_tip.hide);
	
		// the intention here is to not trigger zipcodes that aren't active based upon table filtering, but this doesn't work at the moment
		function conditionalTooltip(d) {
			console.log(d);
			if (typeof d.properties !== "undefined") tool_tip.show();
		}
		
	}
	
	d3.select("#node_selector").node().addEventListener("change", function(d) { ${param.namespace}_order(d3.select("#node_selector").node().value); });
	 
	function ${param.namespace}_order(value) {
		//console.log(value);
		update(getTableData(table2));
	}

	function setTableEvents(table) {
	
		table.on("page", function() {
			draw2 = true;
		});
	
		// listen for updates and adjust the chart accordingly
		table.on("draw", function() {
			if (draw2) {
				draw2 = false;
				return;
			} else {
				const tableData = getTableData(table);
	
				update(tableData);
			}
		});
	}



</script>
