<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script>
let draw2 = false;

init();

function init() {
	$.getJSON("<util:applicationRoot/>/feeds/siteCollaborations.jsp", function(data){
		// console.log(data);
		
		var json = $.parseJSON(JSON.stringify(data));
		var col = [];
		var hard_headers = ["Site", "Type", "Investigator Count"] ;
		var table = document.createElement("table");
			table.className = 'table table-hover compact site-wrapper';
			table.style.width = '100%';
			table.id="site-table";
		var header= table.createTHead();
		var header_row = header.insertRow(0); 
		for (i in hard_headers) {
			var th = document.createElement("th");
			th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + hard_headers[i].toString() + '</span>';
			header_row.appendChild(th);
		}
		var divContainer = document.getElementById("site-roster");
		divContainer.appendChild(table);
		data = json['sites'];
		const table2 = $('#site-table').DataTable( {
	    	data: data,
	       	paging: true,
	       	dom: 'lfr<"datatable_overflow"t>Bip',
	    	buttons: {
	    	    dom: {
	    	      button: {
	    	        tag: 'button',
	    	        className: ''
	    	      }
	    	    },
	    	    buttons: [{
	    	      extend: 'csv',
	    	      className: 'btn btn-sm btn-light',
	    	      titleAttr: 'CSV export.',
	    	      text: 'CSV',
	    	      filename: 'N3C_sites_csv_export',
	    	      extension: '.csv'
	    	    }, {
	    	      extend: 'copy',
	    	      className: 'btn btn-sm btn-light',
	    	      titleAttr: 'Copy table data.',
	    	      text: 'Copy'
	    	    }]
	    	},
	    	pageLength: 10,
	    	lengthMenu: [ 10, 25, 50, 75, 100 ],
	    	order: [[0, 'asc']],
	     	columns: [
	        	{ data: 'site', visible: true, orderable: true,
	        		render: function ( data, type, row ) {
	        			return '<a href="'+ row.url + '"><span>' + row.site + '<\/span></a>';
	             		}
	        		},
	        	{ data: 'type', visible: true, orderable: true },
	        	{ data: 'count', visible: true}
	    	]
		} );
		const tableData = getTableData(table2);
  		createD3Chart(tableData);
  		setTableEvents(table2);
	});
}


function getTableData(table) {
	var tableData = {};
	const dataArray = [];
	
	table.rows({search: "applied"}).every(function(){
		const data = this.data();
		dataArray.push(data);
	});
	
	tableData["sites"] = dataArray;
	return tableData;
}


//////////////////////////////////////////////// D3 VIZ /////////////////////////////////////////////////
var width = null;
var height = null;
	
function createD3Chart(sites_data){
	d3.select("#graph").select("svg").remove();
	
	
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
					height = (width / 2) +60;
					draw();
				}
			});
		});
		myObserver.observe(d3.select("#graph").node());
	
		draw();
	
		function draw() {
			d3.select("#graph").select("svg").remove();
			var legendText = ["Data Available", "Data transfer signed, pending availability"];
			var legendStatus = ["Yes", "No"];
			var legendLocation = [];
			var legendPosition = [];
			
			// D3 Projection 
			var projection = d3.geoAlbersUsa()
				.translate([width / 2, (height / 2)+20]) // translate to center of screen
				.scale([width]); // scale things down so see entire US
	
			// Define path generator
			var path = d3.geoPath() // path generator that will convert GeoJSON to SVG paths
				.projection(projection); // tell path generator to use albersUsa projection
				
	
			legendPosition.push(projection([-125.0, 20.0]));
			legendPosition.push(projection([-125.0, 25.0]));

	
			var svg = d3.select("#graph")
				.append("svg")
				.attr("width", width)
				.attr("height", height+40);
			
			var g = svg.append("g");
			
			
			var nodeScale = d3.scaleLinear()
				.domain([0, d3.max(sites_data.sites, function(d) { return d.count; })])
				.range([2, 15]);

			const zoom = d3.zoom()
    			.scaleExtent([1, 30])
    			.on('zoom', function() {
     				 const {transform} = d3.event;
      				 g.attr('transform', transform);
      				 g.selectAll(".remove").attr('d', d3.symbol().type(d3.symbolCircle).size(10 / transform.k));
					 g.selectAll("circle").attr('r', function(d) { return nodeScale(d.count) / transform.k; });
  			});

  			svg.call(zoom);
  			
			
			// Color Scale For Legend and Map 
		var color = d3.scaleOrdinal()
			.domain(["N3C", "CTSA", "GOV", "CTR", "COM", "UNAFFILIATED", "REGIONAL", "X1", "X2", "X3"])
			.range(d3.schemeCategory10)
	
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
					.style("stroke", "#808080")
					.style("stroke-width", "1")
					.style("fill", "#EEEEEE");
				
					
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
	
					var nodeScale = d3.scaleLinear()
					.domain([0, d3.max(sites, function(d) { return d.count; })])
					.range([2, 15]);

					var other = g.selectAll("circle")
						.data(sites)
						.enter().append("svg:circle")
						.style("fill", function(d) { return color(d.type); })
						.attr("fill-opacity", 1.0)
						.attr('class', "remove")
						.attr("cx", function(d, i) { return positions[i][0]; })
						.attr("cy", function(d, i) { return positions[i][1]; })
						.attr("r", function(d, i) { return nodeScale(d.count); })
						.append('title')
  						.text(function(d) { return ("Site: " + d.site + "\nType: "+d.type + "\nStatus: "+d.status); });

				
				svg.append("rect").attr("x", 0).attr("y", 0).attr("width", width).attr("height", 60).style("fill", "white");
				svg.append("circle")
					.attr("cx", 5)
					.attr("cy",8)
					.attr("r", 5)
					.attr("fill-opacity", .5)
					.style("fill", color("Yes"))
				svg.append("circle")
					.attr("cx", 5)
					.attr("cy",28)
					.attr("r", 5)
					.attr("fill-opacity", .5)
					.style("fill", color("No"))
				svg.append("path")
					.attr("d", function(d) {return d3.symbol().type(d3.symbolCircle).size("15")()})
					.attr("transform", function(d, index) {return "translate(5, 48)";})
	  				.attr("fill", "#64286b")
				svg.append("text").attr("x", 15).attr("y", 11).text("Data Available").style("font-size", "15px").attr("alignment-baseline","middle")
				svg.append("text").attr("x", 15).attr("y", 31).text("Data transfer signed, pending availability").style("font-size", "15px").attr("alignment-baseline","middle")
				svg.append("text").attr("x", 15).attr("y", 51).text("OCHIN contributing site").style("font-size", "15px").attr("alignment-baseline","middle")
			});
			
			
		};
	});
	
	function org_label(x) {
		return "<br>"+x;
	}
	
	function status_label(x) {
		return "<br>"+x;
	}
	
	
}

function update(data){
		
		var svg = d3.select("#graph").select("svg");
		var g = svg.select("g");
		
		svg.call(zoom.transform, d3.zoomIdentity);
		
		var projection = d3.geoAlbersUsa()
			.translate([width / 2, (height / 2)+20]) // translate to center of screen
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
			.domain([0, d3.max(sites, function(d) { return d.count; })])
			.range([2, 15]);
		
		const zoom = d3.zoom()
		.scaleExtent([1, 30])
		.on('zoom', function() {
			const {transform} = d3.event;
			g .attr('transform', transform);
			g.selectAll(".remove").attr('d', d3.symbol().type(d3.symbolCircle).size(10 / transform.k));
			g.selectAll("circle").attr('r', function(d) { console.log(d); return 7 / transform.k; });
		});

		var color = d3.scaleOrdinal()
		.domain(["N3C", "CTSA", "GOV", "CTR", "COM", "UNAFFILIATED", "REGIONAL", "X1", "X2", "X3"])
		.range(d3.schemeCategory10)
		
		var ochin_check = [];
		for (i in data["sites"]){
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
			.style("fill", function(d) { return color(d.type); })
			.attr("fill-opacity", 1.0)
			.attr("cx", function(d, i) { return positions[i][0]; })
			.attr("cy", function(d, i) { return positions[i][1]; })
			.attr("r", function(d, i) { return nodeScale(d.count); })
			.append('title')
  			.text(function(d) { return ("Site: " + d.site + "\nType: "+d.type + "\nStatus: "+d.status); });;
  			
		
		circle.exit().remove();
		
		
			
}

function setTableEvents(table) {
	  
	  table.on("page", function (){
	    draw2 = true;
	  });

	  // listen for updates and adjust the chart accordingly
	  table.on("draw", function () {
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