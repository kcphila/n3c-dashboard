<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} and Age</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} and Age.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} and Age.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} and Age.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_age_viz" class="col-12 dash_viz"></div>
	</div>
	<c:if test="${not empty param.symptom}">
		<div class="col-12 viz-header-section">
			<h2 class="viz-title">${param.topic_title2}</h2>
			<div class="btn-group float-right">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('${param.block}-long-age', '${param.topic_title2}.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('${param.block}-long-age', '${param.topic_title2}.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('${param.block}-long-age', '${param.topic_title2}.svg')">Save as SVG</a>
				</div>
			</div>
		</div>
		<div class="col-12" id="${param.block}-long-age">
			<jsp:include page="../long_covid/long_before_static.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="type" value="age" />
				<jsp:param name="symptom" value="${param.symptom}" />
			</jsp:include>
		</div>
	</c:if>
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


function ${param.block}_age_refresh() {
	var properties = {
			domName: '${param.block}_age_viz',
			barLabelWidth: labelWidth,
			legend_data: age_legend_4,
			secondary_range: age_range,
			legend_label: 'Age',
			min_height: 100,
			nofilter: 0,
			ordered: 1
		}

	// console.log("age graph", "${param.block}_age_viz", ${param.block}_ObservationAgeArray)
   	d3.select("#${param.block}_age_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_ObservationAgeArray, properties);	
}

${param.block}_age_refresh();
</script>
