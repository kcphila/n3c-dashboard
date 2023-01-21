<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} by Age</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} by Age.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} by Age.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} by Age.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_age_viz" class="col-12 dash_viz"></div>
	</div>
</div>


<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../long_covid/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>


<script>

function ${param.block}_age_refresh() {
	var properties = {
			domName: '#${param.block}_age_viz',
			barLabelWidth: 70,
			min_height: 300,
			ordered: 0,
			colorscale: age_range
	}

	// console.log("age graph", "${param.block}_age_viz", ${param.block}_AgeArray)
	d3.select("#${param.block}_age_viz").select("svg").remove();
	localHorizontalBarChart(${param.block}_AgeArray, properties);
}

${param.block}_age_refresh();

</script>
