<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<div style="display:flex; flex-wrap: nowrap;">
			<h2 class="viz-title">${param.topic_title} by Age</h2>
			<div>
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
	</div>
	<div class="col-12">
		<div id="${param.block}_age_viz" class="col-12 dash_viz"></div>
	</div>
</div>


<script>

function ${param.block}_age_refresh() {
	var properties = {
			domName: '#${param.block}_age_viz',
			barLabelWidth: 100,
			min_height: 300,
			colorscale: age_range_min
	}

	// console.log("age graph", "${param.block}_age_viz", ${param.block}_AgeArray)
	d3.select("#${param.block}_age_viz").select("svg").remove();
	localHorizontalBarChart_new(${param.block}_AgeArray, properties);
}

</script>
