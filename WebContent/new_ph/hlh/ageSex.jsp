<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div class="row">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Age</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Age.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Age.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Age.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_age_viz" class="col-12 dash_viz"></div>
	</div>
</div>



<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../hlh/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<script>

function ${param.block}_age_refresh() {
	var properties = {
			domName: '${param.block}_age_viz',
			primary: 'observation',
			secondary: 'age',
			count: 'patient_count',
			stack_group: 'sex',
			xaxis_label: 'Sex',
			legend_label: sex_legend,
			colorscale: sex_range,
			label1: 'Observation',
			label2: 'Age',
			offset: 250
	}
	// console.log('reached age refresh');
   	d3.select("#${param.block}_age_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart(${param.block}_AgeSexArray, properties);	
}

${param.block}_age_refresh();
</script>
