<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="all_summary_0"></div>

<div id="hive_save_viz">
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('all_summary_0', 'hive.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('all_summary_0', 'hive.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('all_summary_0', 'hive.jpg');">Save as JPEG</button>
</div>

<script>

function ${param.block}_hive_refresh() {
	var properties = {
		feed_path: "../../feeds/hive_data.jsp",
		domName: "all_summary_0",
		domTarget: "all_summary_1",
		color: [ age_range_all, severity_range, gender_range, race_range, ethnicity_range ]
	};
	
	d3.select("#${param.block}_hive_viz").select("svg").remove();
	localHiveChart(properties);
}

${param.block}_hive_refresh();
</script>
