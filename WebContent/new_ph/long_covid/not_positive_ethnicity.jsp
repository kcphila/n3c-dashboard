<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<div style="display:flex; flex-wrap: nowrap;">
			<h2 class="viz-title">${param.topic_title} by Ethnicity</h2>
			<div>
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.topic_title} by Ethnicity.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.topic_title} by Ethnicity.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.topic_title} by Ethnicity.svg')">Save as SVG</a>
				</div>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div class="loading">
			<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
		</div>
		<div id="${param.block}_ethnicity_viz" class="col-12 dash_viz"></div>
	</div>
</div>

<script>

function ${param.block}_ethnicity_refresh() {
	var properties = {
			domName: '#${param.block}_ethnicity_viz',
			barLabelWidth: 100,
			min_height: 300,
			colorscale: ethnicity_range
	}

	// console.log("ethnicity graph", "${param.block}_ethnicity_viz", ${param.block}_EthnicityArray)
	d3.select("#${param.block}_ethnicity_viz").select("svg").remove();
	localHorizontalBarChart_new(${param.block}_EthnicityArray, properties);
}

</script>
