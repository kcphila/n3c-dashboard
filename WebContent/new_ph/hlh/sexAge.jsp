<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Sex</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Sex.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Sex.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Sex.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_sex_viz" class="col-12 dash_viz"></div>
	</div>
</div>


<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../hlh/secondary_text/${param.topic_description}.jsp?symptom=${param.symptom}"/>
	</div>
</c:if>
				
<div id="${param.block}_age_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_sex_viz', '${param.block}_sex.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_sex_viz', '${param.block}_sex.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_sex_viz', '${param.block}_sex.jpg');">Save as JPEG</button>
</div>

<script>

function ${param.block}_sex_refresh() {
	var properties = {
			domName: '${param.block}_sex_viz',
			primary: 'observation',
			secondary: 'sex',
			count: 'patient_count',
			stack_group: 'age',
			xaxis_label: 'Age',
			legend_label: age_legend_4,
			colorscale: age_range,
			label1: 'Observation',
			label2: 'Sex',
			offset: 250
	}

	// console.log('reached sex refresh');
   	d3.select("#${param.block}_sex_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart(${param.block}_SexAgeArray, properties);	
}

${param.block}_sex_refresh();
</script>
