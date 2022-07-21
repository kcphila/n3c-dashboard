<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<jsp:include page="../groupedbarpercentToggle.jsp">
	<jsp:param name="block" value="${param.block}" />
	<jsp:param name="dimension" value="age" />
	<jsp:param name="dimension_name" value="Age" />
	<jsp:param name="array" value="statusArray" />
	<jsp:param name="primary" value="age" />
	<jsp:param name="secondary" value="smoking_status" />
	<jsp:param name="count" value="patient_count" />
	<jsp:param name="count_label" value="Count" />
	<jsp:param name="percent_label" value="Percent" />
	<jsp:param name="legend" value="status_legend" />
	<jsp:param name="range" value="status_range" />
	<jsp:param name="label1" value="age" />
	<jsp:param name="label2" value="Smoking Status" />
	<jsp:param name="left" value="60" />
</jsp:include>

<div id="${param.block}_age_viz" class="col-12 dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../smoking/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>
				
<div id="${param.block}_age_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_age_viz', '${param.block}_age.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_age_viz', '${param.block}_age.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_age_viz', '${param.block}_age.jpg');">Save as JPEG</button>
</div>

<script>

function ${param.block}_age_refresh() {
	var id = $("#${param.block}-age-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	d3.select("#${param.block}_age_viz").select("svg").remove();
	
	if (mode == 'bar'){
		localHorizontalGroupedBarChart(${param.block}_statusArray,"${param.block}_age_viz", "age", "smoking_status", "patient_count", "Count", status_legend, status_range, "Age", "Smoking Status", 60);	
	} else if (mode == 'barpercent'){
		localHorizontalGroupedPercentageBarChart(${param.block}_statusArray,"${param.block}_age_viz", "age", "smoking_status", "patient_count", "Percent", status_legend, status_range, "Age", "Smoking Status", 60);	
	};
   	
}

${param.block}_age_refresh();
</script>
