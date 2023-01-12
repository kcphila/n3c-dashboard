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
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sotrovimab1_viz', '${param.topic_title}_severity.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sotrovimab1_viz', '${param.topic_title}_severity.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sotrovimab1_viz', '${param.topic_title}_severity.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_sotrovimab1_viz" class="dash_viz"></div>
	</div>
</div>


<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../medication_snapshot/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<script>

function ${param.block}_sotrovimab1_refresh() {
	var properties = {
			domName: '${param.block}_sotrovimab1_viz',
			barLabelWidth: 120,
			legend_data: sotrovimaboccurrence_legend,
			secondary_range: categorical,
			legend_label: 'Sotrovimab Occurrence'
		}

	d3.select("#${param.block}_sotrovimab1_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_medsSeverityArray, properties);
	
}

${param.block}_sotrovimab1_refresh();
</script>
