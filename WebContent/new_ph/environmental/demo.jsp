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
    pointer-events: all;
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
	<button id="reset" > Reset Zoom </button>
<p>Click on a state to zoom to that state (currently only works outside of zip regions), click on that state again to return to the default view.
<div id="graph" style="overflow: hidden;"></div>
<div id="site-roster"></div>

<script>
	function getApplicationRoot() {
		// placing this here allows us to use pure javascript layers while still being flexible about feed paths
		return "<util:applicationRoot/>";
	}
</script>
<jsp:include page="../../graph_support/us_map.jsp">
	<jsp:param name="layer1" value="/graph_support/map_layers/ochin_sites.js"/>
	<jsp:param name="layer2" value="/graph_support/map_layers/zip35.js"/>
	<jsp:param name="layer3" value="/graph_support/map_layers/collaborating_sites.js"/>
</jsp:include>

<script>
	var properties = {
		dom_element: "graph",
		base_layer_feed: "graph_support/us-states.json",
		reset_id: "reset"
	};
	
	// variables shared by the internal and external blocks should be declared here
	var zips = null;
	var site_by_zip = null;

	$(document).ready(function() {
		createUSmap(properties);
	});
	
</script>