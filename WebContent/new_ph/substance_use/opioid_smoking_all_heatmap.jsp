<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="substance_use6_all">
	<div class="row">
		<div class="col-12 viz-header-section">
			<h2 class="viz-title">Opioid and Smoking Use - All Patients</h2>
			<div class="btn-group float-right">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="save_${param.block}_heatmap_all_viz_pass('.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="save_${param.block}_heatmap_all_viz_pass('.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="save_${param.block}_heatmap_all_viz_pass('.svg');">Save as SVG</a>
				</div>
			</div>
		</div>
		<div class="col-12">
			<div id="${param.block}_heatmap_all_viz" class="col-12 dash_viz"></div>
		</div>
	</div>
</div>

<script>

function save_${param.block}_heatmap_all_viz_pass(extension){
	var date = $( "#current_date" ).text();
	var text = "Opioid and Smoking Use - All Patients in " + date + extension;
	saveVisualization('${param.block}_heatmap_all_viz', text);
};


function ${param.block}_opioid_smoking_all_refresh() {
	var properties = {
		domName: "${param.block}_heatmap_all_viz"
	}
   	d3.select("#${param.block}_heatmap_all_viz").select("svg").remove();
	localHeatMap(${param.block}_OpioidSmokingAllArray, properties);	
}

${param.block}_opioid_smoking_all_refresh();
</script>
