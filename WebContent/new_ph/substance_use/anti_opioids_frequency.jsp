<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title}</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_anti_opioids_viz', '${param.topic_title}.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_anti_opioids_viz', '${param.topic_title}.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_anti_opioids_viz', '${param.topic_title}.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12 mb-4"> 
		<div id="${param.block}legend"></div>
	</div>
	<div class="col-12">
		<div class="loading">
			<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
		</div>
		<div id="${param.block}_anti_opioids_viz" class="dash_viz clip"></div>
	</div>
</div>


<script>

function ${param.block}_anti_opioids_refresh() {
	var properties = {
			domName: '${param.block}_anti_opioids_viz',
			barLabelWidth: 220,
			legend_data: anti_legend,
			secondary_range: categorical,
			legend_label: 'Anti-Opioid',
			legendid: '${param.block}legend'
		}

	//console.log("anti_opioids graph", "${param.block}_anti_opioids_viz", ${param.block}_AntiOpioidsArray);
   	d3.select("#${param.block}_anti_opioids_viz").select("svg").remove(); 
	localHorizontalStackedBarChart_new(${param.block}_AntiOpioidsArray, properties);
	${param.block}_refresh_kpis();
}

function ${param.block}_refresh_kpis() {
	var sum = ${param.block}_active_count;
	var sumString = '';
	
	if (sum < 1000) {
		sumString = sum+'';
	} else if (sum < 1000000) {
		sum = sum / 1000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "k";
	} else {
		sum = sum / 1000000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "M";		
	}

	document.getElementById('${param.block}'+'_patient_count_kpi').innerHTML = sumString;	
}

</script>
