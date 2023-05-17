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
			<a class="dropdown-item" onclick="saveVisualization('${param.block}_medication_overall', '${param.topic_title}.jpg');">Save as JPG</a>
			<a class="dropdown-item" onclick="saveVisualization('${param.block}_medication_overall', '${param.topic_title}.png');">Save as PNG</a>
			<a class="dropdown-item" onclick="saveVisualization('${param.block}_medication_overall', '${param.topic_title}.svg');">Save as SVG</a>
		</div>
	</div>
</div>
<div id="medication_ts_2">
	<div id="${param.block}_medication_overall" class="col-12 dash_viz"></div>	
</div>

<script>

function ${param.block}_medication_overall_refresh() {
	var properties = {
			domName: '#${param.block}_medication_overall',
			barLabelWidth: 250,
			min_height: 300,
			colorscale: categorical8,
			legend_label: 'Medication',
			legend_data: medication_legend2
	}

	d3.select("#${param.block}_medication_overall").select("svg").remove();
	localHorizontalBarChart_new(${param.block}_MedicationOverallArray, properties);	
}

</script>
