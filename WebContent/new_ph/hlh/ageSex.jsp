<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div id="${param.block}_age_viz" class="col-12 dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../hlh/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>
				
<div id="${param.block}_age_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_age_viz', '${param.block}_age.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_age_viz', '${param.block}_age.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_age_viz', '${param.block}_age.jpg');">Save as JPEG</button>
</div>

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
