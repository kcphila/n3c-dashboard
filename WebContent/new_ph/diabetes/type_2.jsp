<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="${param.block}_diabetest2_viz" class="dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../diabetes/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<div id="${param.block}_diabetest2_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_diabetest2_viz', '${param.block}_diabetes_t2.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_diabetest2_viz', '${param.block}_diabetes_t2.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_diabetest2_viz', '${param.block}_diabetes_t2.jpg');">Save as JPEG</button>
</div>

<script>
function ${param.block}_refresh() {
   	d3.select("#${param.block}_diabetest2_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart(${param.block}_GenderAgeArray,"${param.block}_diabetest2_viz", "observation", "gender", "patient_count", "age", "Age", age_legend_4, age_range, "Observation", "Gender", 350);	
}
</script>
