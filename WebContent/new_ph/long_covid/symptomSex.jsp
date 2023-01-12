<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} and Sex</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} and Sex');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} and Sex');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} and Sex')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_sex_viz" class="col-12 dash_viz"></div>
	</div>
</div>


<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../long_covid/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>


<script>
var labeltest = '${param.label_width}';
var labelWidth = 150;

if (labeltest.length != 0){
	labelWidth = Number('${param.label_width}');
};

function ${param.block}_sex_refresh() {
	var properties = {
			domName: '${param.block}_sex_viz',
			barLabelWidth: labelWidth,
			legend_data: sex_legend,
			secondary_range: sex_range,
			legend_label: 'Sex',
			min_height: "${param.viz_height}",
			nofilter: 0,
			ordered: 1
		}

	// console.log("sex graph", "${param.block}_sex_viz", ${param.block}_SymptomSexArray)
   	d3.select("#${param.block}_sex_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_SymptomSexArray, properties);	
}

${param.block}_sex_refresh();
</script>
