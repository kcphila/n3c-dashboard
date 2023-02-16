<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="reinfection2" class="row">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title}</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_timeline_viz', '${param.topic_title}.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_timeline_viz', '${param.topic_title}.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_timeline_viz', '${param.topic_title}.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_timeline_viz" class="col-12 dash_viz"></div>
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
