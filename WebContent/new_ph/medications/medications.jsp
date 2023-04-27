<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title}</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_medication_viz', '${param.topic_title}.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_medication_viz', '${param.topic_title}.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_medication_viz', '${param.topic_title}.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12 mb-4"> 
		<div id="${param.block}legend"></div>
	</div>
	<div class="col-12">
		<div id="${param.block}_medication_viz" class="dash_viz clip"></div>
	</div>
</div>

<script>

function ${param.block}_medication_refresh() {
	var properties = {
			domName: '${param.block}_medication_viz',
			primary: 'drug_domain',
			secondary: 'concept_set_name',
			count: 'patient_count',
			stack_group: 'age',
			xaxis_label: 'Age',
			legend_label: age_legend_4,
			colorscale: age_range,
			label1: 'Drug Class',
			label2: 'Medications',
			offset: 400,
			legendid: '${param.block}legend'
	}

   	d3.select("#${param.block}_medication_viz").select("svg").remove(); 
	localHorizontalGroupedStackedBarChart_new(${param.block}_MedicationArray, properties);	
}

</script>
