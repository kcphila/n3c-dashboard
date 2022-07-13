<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="${param.block}_severitydiagnosis_viz" class="dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../medication_snapshot/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<div id="${param.block}_severitydiagnosis_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_severitydiagnosis_viz', '${param.block}_severitydiagnosis.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_severitydiagnosis_viz', '${param.block}_severitydiagnosis.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_severitydiagnosis_viz', '${param.block}_severitydiagnosis.jpg');">Save as JPEG</button>
</div>

<script>

function ${param.block}_severitydiagnosis_refresh() {
	d3.select("#${param.block}_severitydiagnosis_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_diagnosisSeverityArray,"${param.block}_severitydiagnosis_viz", 120, diagnosis_legend, diagnosis_range, "Diagnosis");
}

${param.block}_severitydiagnosis_refresh();
</script>
