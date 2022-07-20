<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="${param.block}_diabetest1_viz" class="dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../diabetes/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<script>
function ${param.block}_refresh() {
   	d3.select("#${param.block}_diabetest1_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart(${param.block}_GenderAgeArray,"${param.block}_diabetest1_viz", "observation", "gender", "patient_count", "age", "Age", age_legend_4, age_range, "Observation", "Gender", 350);	
}
</script>
