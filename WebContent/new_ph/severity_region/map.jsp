<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div id="${param.block}_region_viz" class="col-12 dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../severity_region/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<div id="${param.block}_region_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_region_viz', '${param.block}_region.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_region_viz', '${param.block}_region.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_region_viz', '${param.block}_region.jpg');">Save as JPEG</button>
</div>

<script>

function ${param.block}_region_refresh() {
	var properties = {
			domName: '#${param.block}_region_viz'
	}

   	d3.select("#${param.block}_region_viz").select("svg").remove();
   	regionalMap(${param.block}_SeverityRegionArray, properties)
}

${param.block}_region_refresh();
</script>

