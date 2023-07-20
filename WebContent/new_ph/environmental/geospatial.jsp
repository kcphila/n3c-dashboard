<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<style>

.links {
	stroke: #007bff;
    stroke-width: 0.5px;
    pointer-events: all;
	}
</style>
						<div class="btn-group float-right">
							<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="fas fa-download"></i>
							</button>
							<div class="dropdown-menu dropdown-menu-right">
								<a class="dropdown-item" onclick="saveVisualization('graph', 'environmental_map.jpg');">Save as JPG</a>
								<a class="dropdown-item" onclick="saveVisualization('graph', 'environmental_map.png');">Save as PNG</a>
								<a class="dropdown-item" onclick="saveVisualization('graph', 'environmental_map.svg');">Save as SVG</a>
							</div>
						</div>

<div id="graph" style="overflow: hidden;">Note: currently only sites with 5-digit zipcodes appear.</div>
<div id="site-roster"></div>

<script>
	
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
	var links = null;
	var node_map = null;
	
	function createD3Chart(sites_data) {
		console.log("sites_data", sites_data);
		d3.select("#graph").select("svg").remove();
	
//		node_map = d3.map(sites_data.sites, d => d.id);
	
		// Load the Cohort Data
		d3.json("<util:applicationRoot/>/feeds/map_data.jsp", function(error, data) {
			if (error) throw error;
	
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
	
				var nodeScale = d3.scaleLinear()
				.domain([0, d3.max(sites_data.sites, function(d) { return d.non_count; })])
				.range([2, 15]);

				const zoom = d3.zoom()
					.scaleExtent([1, 30])
					.on('zoom', function() {
						const { transform } = d3.event;
						g.attr('transform', transform);
						g.selectAll(".remove").attr('d', d3.symbol().type(d3.symbolCircle).size(10 / transform.k));
						g.selectAll("circle").attr('r', function(d) { return nodeScale(d.non_count) / transform.k; });
					});
	
				svg.call(zoom);
	
	
				// Color Scale For Legend and Map 
				var color = d3.scaleOrdinal()
					.domain(["N3C", "CTSA", "GOV", "CTR", "COM", "UNAFFILIATED", "REGIONAL", "X1", "X2", "X3"])
					.range(["#007bff", "#8406D1","#09405A", "#AD1181",  "#ffa600", "#ff7155", "#a6a6a6", "8B8B8B", "black", "yellow"]);
	
				var stroke = d3.scaleOrdinal()
					.domain(["available", "submitted", "pending"])
					.range(["#64286b", "#545454", "#545454"]);
	
				var dataArray = [];
	
				var states = data.states;
	
				for (var d = 0; d < states.length; d++) {
					dataArray.push(parseFloat(states[d].count))
				}
	
				// Load GeoJSON data and merge with cohort data
				d3.json("<util:applicationRoot/>/feeds/us-states.json", function(json) {
	
					// Loop through each state data value in the json array
					for (var i = 0; i < states.length; i++) {
						var dataState = states[i].name;
						var dataValue = states[i].count;
						var dataRegion = states[i].region;
						// Find the corresponding state inside the GeoJSON
						for (var j = 0; j < json.features.length; j++) {
							var jsonState = json.features[j].properties.name;
							if (dataState == jsonState) {
								// Copy the data value into the JSON
								json.features[j].properties.value = dataValue;
								json.features[j].properties.color = dataRegion;
								break;
							}
						}
					}
	
					// Bind the data to the SVG and create one path per GeoJSON feature
					g.selectAll("path")
						.data(json.features)
						.enter()
						.append("path")
						.attr("d", path)
						.style("stroke", "#d4d4d4")
						.style("stroke-width", "1")
						.style("fill", "gray");
	
	
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
	
					var nodeScaleEnv = d3.scaleLinear()
						.domain([0, d3.max(sites, function(d) { return d.non_count; })])
						.range([3, 15]);
					
					var other = g.selectAll("circle")
					.data(sites)
					.enter().append("svg:circle")
					.style("fill", function(d) { return "yellow"; })
					.attr("fill-opacity", 1.0)
					.attr('class', "remove")
					.attr("cx", function(d, i) { return positions[i][0]; })
					.attr("cy", function(d, i) { return positions[i][1]; })
					.attr("r", function(d, i) { return nodeScaleEnv(d.non_count); })
					.append('title')
					.text(function(d) { return "Site: " + d.cityname; });
				});
	
	
			};
		});
	
		function org_label(x) {
			return "<br>" + x;
		}
	
		function status_label(x) {
			return "<br>" + x;
		}
	
	
	}
	
	function clickfilter(){
		table2.draw();
	}
	
    function drawColorKey() {
		$.getJSON("<util:applicationRoot/>/feeds/${param.legend}", function(data) {
			var legendData = data.sites;
        	var colorScale = d3.scaleOrdinal()
				.domain(["N3C", "CTSA", "GOV", "CTR", "COM", "UNAFFILIATED", "REGIONAL", "X1", "X2", "X3"])
				.range(["#007bff", "#8406D1","#09405A", "#AD1181",  "#ffa600", "#ff7155", "#a6a6a6", "8B8B8B", "black", "yellow"]);


        	var legend_div = d3.select("#legend").append("div").attr("class", "row").attr("id", "filters");
    		
    		var legend_data = legend_div.selectAll(".new_legend")
    			.data(legendData)
    			.enter().append("div")
    			.attr("class", "col col-6 col-lg-4")
    			.html(function(d,i){
    				return  '<label class="testcheck"><input onclick="clickfilter()" class="checkbox" type="checkbox" name="type" value="' + legendData[i].org_type + '"><i class="fas fa-circle" style="color:' + colorScale(legendData[i].org_type) + ';"></i> ' +  d.org_type + " [" + d.count + "]</label>";
    			});
		});
    }
    
	
	function update(data) {
		console.log("data", data);
	
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
	
	
		var nodeScale = d3.scaleLinear()
			.domain([0, d3.max(sites, function(d) { return d.non_count; })])
			.range([2, 15]);
	
		const zoom = d3.zoom()
			.scaleExtent([1, 30])
			.on('zoom', function() {
				const { transform } = d3.event;
				g.attr('transform', transform);
				g.selectAll(".remove").attr('d', d3.symbol().type(d3.symbolCircle).size(10 / transform.k));
				g.selectAll("circle").attr('r', function(d) { return nodeScale(d.non_count) / transform.k; });
			});
	
		d3.select("#graph").select("svg").selectAll("line").remove();
	
		function fade(opacity, out) {
			return function(d) {
				//		          node.style("stroke-opacity", function(o) {
				//		              thisOpacity = isConnected(d, o) ? 1 : opacity;
				//		              this.setAttribute('fill-opacity', thisOpacity);
				//		              return thisOpacity;
				//		          });
	
			};
		}
	
		var color = d3.scaleOrdinal()
			.domain(["N3C", "CTSA", "GOV", "CTR", "COM", "UNAFFILIATED", "REGIONAL", "X1", "X2", "X3"])
			.range(["#007bff", "#8406D1","#09405A", "#AD1181",  "#ffa600", "#ff7155", "#a6a6a6", "8B8B8B", "black", "yellow"]);
	
		var ochin_check = [];
		for (i in data["sites"]) {
			ochin_check.push(data["sites"][i]["site"])
		};
	
		d3.select("#graph").select("svg").selectAll("path.remove").remove();
	
		var path = g.selectAll("path.return").data(sites);
		path.exit().remove();
	
		d3.select("#graph").select("svg").selectAll("circle.remove").remove();
	
		var circle = g.selectAll("circle.return").data(sites);
	
		circle
			.enter().append("circle")
			.attr("class", "remove")
			.style("fill", function(d) { return "yellow"; })
			.attr("fill-opacity", 1.0)
			.attr("cx", function(d, i) { return positions[i][0]; })
			.attr("cy", function(d, i) { return positions[i][1]; })
			.attr("r", function(d, i) { return nodeScale(d.non_count); })
			.append('title')
			.text(function(d) { return "Site: " + d.cityname; });;
	
	
		circle.exit().remove();
	
	
	
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
