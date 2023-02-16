<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="col-12 viz-header-section">
	<h2 class="viz-title">${param.topic_title}</h2>
	<div class="btn-group float-right">
		<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			<i class="fas fa-download"></i>
		</button>
		<div class="dropdown-menu dropdown-menu-right">
			<a class="dropdown-item" onclick="saveVisualization('${param.block}_medication_timeline', '${param.topic_title}.jpg');">Save as JPG</a>
			<a class="dropdown-item" onclick="saveVisualization('${param.block}_medication_timeline', '${param.topic_title}.png');">Save as PNG</a>
			<a class="dropdown-item" onclick="saveVisualization('${param.block}_medication_timeline', '${param.topic_title}.svg');">Save as SVG</a>
		</div>
	</div>
</div>
<div id="medication_ts_1">
	<div id="${param.block}_medication_timeline" class="col-12 dash_viz"></div>	
</div>

<script>

function ${param.block}_medication_ts_refresh() {
	var properties = {
		domName: "${param.block}_medication_timeline",
		legend_labels: medication_legend,
		xaxis_label: "Month",
		yaxis_label: "Patient Count",
		extendXAxis: 1
	}
   	d3.select("#${param.block}_medication_timeline").select("svg").remove();
//	console.log(${param.block}_MedicationTSArray)
	TimeLineNColumnChart(${param.block}_MedicationTSArray, properties);	
}

</script>
