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
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_paxlovid_viz', '${param.topic_title}.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_paxlovid_viz', '${param.topic_title}.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_paxlovid_viz', '${param.topic_title}.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div class="loading">
			<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
		</div>
		<div id="${param.block}_paxlovid_viz" class="col-12 dash_viz"></div>
	</div>
</div>

<script>

function ${param.block}_visits_refresh() {
	var properties = {
			domName: '${param.block}_paxlovid_viz',
			barLabelWidth: 220,
			legend_data: result_legend2,
			secondary_range: result_range,
			legend_label: 'Test Result',
			min_height: 200,
			nofilter: 1
		}

   	d3.select("#${param.block}_paxlovid_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_CategoryResultArray, properties);
}
</script>
