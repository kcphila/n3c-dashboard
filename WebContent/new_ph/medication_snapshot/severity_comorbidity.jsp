<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_severitycomorbidity_viz', '${param.topic_title}.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_severitycomorbidity_viz', '${param.topic_title}.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_severitycomorbidity_viz', '${param.topic_title}.svg');")">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_severitycomorbidity_viz" class="dash_viz"></div>
	</div>
</div>


<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../medication_snapshot/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>


<script>

function ${param.block}_severitycomorbidity_refresh() {
	var properties = {
			domName: '${param.block}_severitycomorbidity_viz',
			barLabelWidth: 120,
			legend_data: comorbidity_number_legend,
			secondary_range: comorbidity_number_range,
			legend_label: 'Number of Comorbidities'
		}

	d3.select("#${param.block}_severitycomorbidity_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_comorbiditySeverityArray, properties);
}

${param.block}_severitycomorbidity_refresh();
</script>
