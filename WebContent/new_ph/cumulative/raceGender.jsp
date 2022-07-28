<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div id="${param.block}_racegender_viz" class="dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../cumulative/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<div id="${param.block}_racegender_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_racegender_viz', '${param.block}_racegender.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_racegender_viz', '${param.block}_racegender.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_racegender_viz', '${param.block}_racegender.jpg');">Save as JPEG</button>
</div>

<script>

function ${param.block}_racegender_refresh() {
	var properties = {
			domName: '${param.block}_racegender_viz',
			barLabelWidth: 120,
			legend_data: gender_legend,
			secondary_range: gender_range,
			legend_label: 'Gender'
		}

	d3.select("#${param.block}_racegender_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_raceGenderArray, properties);
}

${param.block}_racegender_refresh();

</script>
