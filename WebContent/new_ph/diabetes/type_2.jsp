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
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_diabetest2_viz', '${param.topic_title}.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_diabetest2_viz', '${param.topic_title}.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_diabetest2_viz', '${param.topic_title}.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_diabetest2_viz" class="dash_viz"></div>
	</div>
</div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../diabetes/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>


<script>
function ${param.block}_refresh() {
	var properties = {
			domName: '${param.block}_diabetest2_viz',
			primary: 'observation',
			secondary: 'sex',
			count: 'patient_count',
			stack_group: 'age',
			xaxis_label: 'Age',
			legend_label: age_legend_4,
			colorscale: age_range,
			label1: 'Observation',
			label2: 'Sex',
			offset: 350
	}

   	d3.select("#${param.block}_diabetest2_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart(${param.block}_SexAgeArray, properties);	
}
</script>
