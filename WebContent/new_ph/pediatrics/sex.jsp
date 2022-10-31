<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<jsp:include page="../barPieToggle.jsp">
	<jsp:param name="block" value="${param.block}" />
	<jsp:param name="dimension" value="sex" />
	<jsp:param name="dimension_name" value="Sex" />
	<jsp:param name="dimension_range" value="sex_range" />
	<jsp:param name="dimension_legend" value="sex_legend" />
	<jsp:param name="dimension_minheight" value="300" />
</jsp:include>

<div id="${param.block}_sex_viz" class="dash_viz"></div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../pediatrics/secondary_text/${param.topic_description}.jsp"/>
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
			barLabelWidth: 140,
			min_height: 300,
			ordered: 0,
			colorscale: sex_range,
			legend_label: 'Sex',
			legend_data: sex_legend,
			donutRatio: 0.5
		}

	var id = $("#${param.block}-sex-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	d3.select("#${param.block}_sex_viz").select("svg").remove();
	
	if (mode =='pie'){		
		localPieChart(${param.block}_SexArray, properties);
	} else if (mode == 'bar'){
		localHorizontalBarChart_legend(${param.block}_SexArray, properties);
	} else {
		localPercentageBarChart(${param.block}_SexArray, properties);
	};

}

${param.block}_sex_refresh();

</script>
