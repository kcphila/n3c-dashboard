<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} by Severity and Sex</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_severity_viz', '${param.topic_title} by Severity and Sex.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_severity_viz', '${param.topic_title} by Severity and Sex.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_severity_viz', '${param.topic_title} by Severity and Sex.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_severity_viz" class="col-12 dash_viz"></div>
	</div>
</div>



<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../long_covid/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>
				

<script>

function ${param.block}_severity_refresh() {
	var properties = {
			domName: '${param.block}_severity_viz',
			barLabelWidth: 120,
			legend_data: sex_legend,
			secondary_range: sex_range,
			legend_label: 'Sex'
		}

	// console.log("reached");
   	d3.select("#${param.block}_severity_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_SeveritySexArray, properties);	
}

${param.block}_severity_refresh();
</script>
