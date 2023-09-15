<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} by Race and Ethnicity</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_raceethnicity_viz', '${param.topic_title} by Race and Ethnicity.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_raceethnicity_viz', '${param.topic_title} by Race and Ethnicity.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_raceethnicity_viz', '${param.topic_title} by Race and Ethnicity.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12 mb-4"> 
		<div id="${param.block}_ethnicity_legend"></div>
	</div>
	<div class="col-12">
		<div id="${param.block}_raceethnicity_viz" class="dash_viz clip"></div>
	</div>
</div>

<script>

function ${param.block}_raceethnicity_refresh() {
	var properties = {
			domName: '${param.block}_raceethnicity_viz',
			barLabelWidth: 120,
			legend_data: ethnicity_legend,
			secondary_range: ethnicity_range,
			legend_label: 'Ethnicity',
			legendid: '${param.block}_ethnicity_legend'
		};

	d3.select("#${param.block}_raceethnicity_viz").select("svg").remove();
	localHorizontalStackedBarChart_new(${param.block}_raceEthnicityArray, properties);
}

</script>
