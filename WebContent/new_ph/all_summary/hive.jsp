<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="${param.block}_hive_viz" class="dash_viz" style="text-align:center;"></div>

<div id="${param.block}_hive_save_viz">
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_hive_viz', 'hive.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_hive_viz', 'hive.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_hive_viz', 'hive.jpg');">Save as JPEG</button>
</div>

<p>Nodes here are values from each demographic dimension, scaled by patient counts.
Edges indicate the degree of connection between values in pairs of dimensions, scaled by shared patient counts.
Hover over a node or edge to highlight the respective connections.
Click on a node to display the cumulative summary graph for that dimension.</p>

<script>

function ${param.block}_hive_refresh() {
	var properties = {
		feed_path: "../../feeds/hive_data.jsp",
		scaling: 1.75,
		domName: "${param.block}_hive_viz",
		domTarget: "all_summary_1",
		color: [ age_range_all, severity_range, gender_range, race_range, ethnicity_range ]
	};
	
	d3.select("#${param.block}_hive_viz").select("svg").remove();
	localHiveChart(properties);
}

${param.block}_hive_refresh();
</script>
