<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} by Race and Sex</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_racesex_viz', '${param.topic_title} by Race and Sex.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_racesex_viz', '${param.topic_title} by Race and Sex.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_racesex_viz', '${param.topic_title} by Race and Sex.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_racesex_viz" class="dash_viz"></div>
	</div>
</div>


<script>

function ${param.block}_racesex_refresh() {
	var properties = {
			domName: '${param.block}_racesex_viz',
			barLabelWidth: 120,
			legend_data: sex_legend,
			secondary_range: sex_range,
			legend_label: 'Sex'
		}

	d3.select("#${param.block}_racesex_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_raceSexArray, properties);
}

${param.block}_racesex_refresh();

</script>
