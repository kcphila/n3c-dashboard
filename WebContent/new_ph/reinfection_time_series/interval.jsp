<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="reinfection2">

	<div id="${param.block}_timeline_viz" class="col-12 dash_viz"></div>

	<div id="reinfection2_graph_save_viz"> 
		<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_timeline_viz', '${param.block}_graph.svg');">Save as SVG</button>
		<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_timeline_viz', '${param.block}_graph.png');">Save as PNG</button>
		<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_timeline_viz', '${param.block}_graph.jpg');">Save as JPEG</button>
	</div>
	
</div>

<script>

function ${param.block}_interval_refresh() {
	var properties = {
			domName: "${param.block}_timeline_viz",
			xaxis_label: "Interval Bin",
			yaxis_label: "Patient Count",
			tooltip_x_label: "Interval Bin: ",
			tooltip_y_label: "Patient Count: ",
			filter_type: "intervalbin"
			};
	
	${param.block}_refreshHistograms();
   	d3.select("#${param.block}_timeline_viz").select("svg").remove();
	localVerticalBarChart(${param.block}_IntervalBinArray, properties);	
}

$(document).ready( function () {
	${param.block}_interval_refresh();
});
</script>
