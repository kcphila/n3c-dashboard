<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="${param.block}_diabetest1_over_viz" class="dash_viz"></div>

<div id="${param.block}_diabetest1_over_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_diabetest1_over_viz', '${param.block}_diabetes_t1_over.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_diabetest1_over_viz', '${param.block}_diabetes_t1_over.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_diabetest1_over_viz', '${param.block}_diabetes_t1_over.jpg');">Save as JPEG</button>
</div>

<script>
function ${param.block}_refresh() {
	var properties = {
			domName: '#${param.block}_diabetest1_over_viz',
			barLabelWidth: 250,
			min_height: 300,
			colorscale: categorical,
			colorIndexActual: true
		}

   	d3.select("#${param.block}_diabetest1_over_viz").select("svg").remove();
	localHorizontalBarChart(${param.block}_ObservationArray, properties);	
}

</script>
