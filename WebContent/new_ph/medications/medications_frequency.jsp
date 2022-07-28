<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div id="${param.block}_medication_viz" class="dash_viz"></div>

<div id="${param.block}_medication_save_viz"> 
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_medication_viz', '${param.block}_medication.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_medication_viz', '${param.block}_medication.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('${param.block}_medication_viz', '${param.block}_medication.jpg');">Save as JPEG</button>
</div>

<script>

function ${param.block}_medication_refresh() {
	var properties = {
			domName: '${param.block}_medication_viz',
			barLabelWidth: 190,
			legend_data: age_legend_4,
			secondary_range: age_range,
			legend_label: 'Age',
			min_height: 900
		}

	// console.log("medication graph", "${param.block}_medication_viz", ${param.block}_MedicationAgeArray);
   	d3.select("#${param.block}_medication_viz").select("svg").remove(); 
	localHorizontalStackedBarChart(${param.block}_MedicationAgeArray, properties);
}

</script>
