<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="medication_ts_2">
	<div id="${param.block}_medication_overall" class="col-12 dash_viz"></div>

	<div id="medication_ts_1_graph_save_viz"> 
		<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_medication_overall', '${param.block}_graph.svg');">Save as SVG</button>
		<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_medication_overall', '${param.block}_graph.png');">Save as PNG</button>
		<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_medication_overall', '${param.block}_graph.jpg');">Save as JPEG</button>
	</div>
	
</div>

<script>

function ${param.block}_medication_overall_refresh() {
	var properties = {
			domName: '#${param.block}_medication_overall',
			barLabelWidth: 230,
			min_height: 600,
			colorscale: categorical8,
			noseq: 1
	}

	d3.select("#${param.block}_medication_overall").select("svg").remove();
	localHorizontalBarChart(${param.block}_MedicationOverallArray, properties);	
}

</script>
