<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div id="${param.block}_sex_viz" class="col-12 dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../long_covid/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<div id="${param.block}_sex_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_sex_viz', '${param.block}_sex.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_sex_viz', '${param.block}_sex.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_sex_viz', '${param.block}_sex.jpg');">Save as JPEG</button>
</div>

<script>

function ${param.block}_sex_refresh() {
	var properties = {
			domName: '#${param.block}_sex_viz',
			barLabelWidth: 70,
			min_height: 300,
			ordered: 1,
			colorscale: sex_range
	}

	// console.log("sex graph", "${param.block}_sex_viz", ${param.block}_SexArray)
	d3.select("#${param.block}_sex_viz").select("svg").remove();
    localHorizontalBarChart(${param.block}_SexArray, properties);
}

${param.block}_sex_refresh();

</script>
