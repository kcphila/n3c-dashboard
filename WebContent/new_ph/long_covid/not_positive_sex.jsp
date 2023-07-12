<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<div style="display:flex; flex-wrap: nowrap;">
			<h2 class="viz-title">${param.topic_title} by Sex</h2>
			<div>
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} by Sex.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} by Sex.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} by Sex.svg')">Save as SVG</a>
				</div>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_sex_viz" class="col-12 dash_viz"></div>
	</div>
</div>

<script>

function ${param.block}_sex_refresh() {
	var properties = {
			domName: '#${param.block}_sex_viz',
			barLabelWidth: 100,
			min_height: 300,
			colorscale: sex_range
	}

	// console.log("sex graph", "${param.block}_sex_viz", ${param.block}_SexArray)
	d3.select("#${param.block}_sex_viz").select("svg").remove();
	localHorizontalBarChart_new(${param.block}_SexArray, properties);
}

${param.block}_sex_refresh();

</script>
