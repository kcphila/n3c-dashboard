<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<style>

.base {
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

.remove {
    vector-effect: non-scaling-stroke; // line height won't scale
}
    
.links {
	stroke: #007bff;
    stroke-width: 0.5px;
    pointer-events: none;
    vector-effect: non-scaling-stroke; // line height won't scale
	}
    
.county {
	stroke: brown;
	stroke-width: 0.5;
    vector-effect: non-scaling-stroke; // line height won't scale
	}
	
.state {
	fill: none;
	stroke: #000000;
	stroke-width: 1.5;
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
<p>Node Value: <select id="county_node_selector">
		<option value="non_count">COVID- Patient Count</option>
		<option value="covid_count">COVID+ Patient Count</option>
		<option value="patient_count_died">Mortality Count</option>
		<option value="patient_count_died_cause_covid">Mortality due to COVID Count</option>
	</select>
	<button id="reset" > Reset Zoom </button>
<p>Click on a state to zoom to that state, click on that state again to return to the default view. Drag pans the map. Scroll zooms in/out relative to the mouse position

<div id="graph" style="overflow: hidden;"></div>
<p>This is implemented by a layered map D3 widget, supporting an arbitrary number of layers. For this example:
<ul>
<li>Layer 0 - the base map, parameterized by geographic projection and shape data. We currently have multiple resolutions for the US and the world
<li>Layer 1 - EPA data for patients by county. Intensity reflects one of the metrics from the "Node Value" dropdown above.
<li>Layer 2 - state border darkening
<li>Layer 3 - the OCHIN sites rendered as black dots
<li>Layer 4 - N3C sites contributing data, color coded by type of site (this is basically the contributing site dashboard, sans the table)
</ul>
<div id="site-roster"></div>

<script>
	function getApplicationRoot() {
		// placing this here allows us to use pure javascript layers while still being flexible about feed paths
		return "<util:applicationRoot/>";
	}
</script>

<jsp:include page="../../graph_support/layeredMap.jsp">
	<jsp:param name="layer1" value="/graph_support/map_layers/counties_env.js"/>
	<jsp:param name="layer2" value="/graph_support/map_layers/states.js"/>
	<jsp:param name="layer3" value="/graph_support/map_layers/ochin_sites.js"/>
	<jsp:param name="layer4" value="/graph_support/map_layers/contributing_sites.js"/>
</jsp:include>

<script>
	var properties = {
		dom_element: "graph",
		//projection: "geoNaturalEarth1",
		//base_layer_feed: "graph_support/world-110m.geojson",
		base_layer_feed: "/resources/map_data/gz_2010_us_040_00_5m.json",
		reset_id: "reset"
	};
	
	$(document).ready(function() {
		createLayeredMap(properties);
	});
	
</script>