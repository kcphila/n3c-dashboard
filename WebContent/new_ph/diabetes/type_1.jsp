<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="${param.block}_diabetest1_viz" class="dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../diabetes/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<div id="${param.block}_diabetest1_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_diabetest1_viz', '${param.block}_diabetes_t1.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_diabetest1_viz', '${param.block}_diabetes_t1.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_diabetest1_viz', '${param.block}_diabetes_t1.jpg');">Save as JPEG</button>
</div>

<script>
function ${param.block}_refresh() {
	var properties = {
			domName: '${param.block}_diabetest1_viz',
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

   	d3.select("#${param.block}_diabetest1_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart(${param.block}_SexAgeArray, properties);	
}
</script>
