<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="substance_use4_all">
	<div class="row">
		<div class="col-12 viz-header-section">
			<h2 class="viz-title">Alcohol and Opioid Use - All Patients</h2>
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
			<p>Order: <select id="order">
					<option value="name">by Name</option>
					<option value="alc_score">by Alcohol Frequency</option>
					<option value="group">by Cluster</option>
				</select>
			<div id="${param.block}_heatmap_all_viz" class="col-12 dash_viz"></div>
		</div>
	</div>
</div>

<script>

function save_${param.block}_heatmap_all_viz_pass(extension){
	var date = $( "#current_date" ).text();
	var text = "Alcohol and Opioid Use - All Patients in " + date + extension;
	saveVisualization('${param.block}_heatmap_all_viz', text);
};


function ${param.block}_alcohol_opioid_all_refresh() {
	var properties = {
		domName: "${param.block}_heatmap_all_viz",
		feed_url: "<util:applicationRoot/>/new_ph/substance_use/feeds/heatmap_clustered_alc_opi.jsp",
		cell_size: 15,
		margin: { top: 80, right: 0, bottom: 10, left: 200 },
		source_label: "alcohol",
		target_label: "opioid",
		source_tooltip_label: "Alcohol Condition",
		target_tooltip_label: "Opioid"
	}
   	d3.select("#${param.block}_heatmap_all_viz").select("svg").remove();
	localHeatMap(${param.block}_AlcoholOpioidAllArray, properties);	
}

${param.block}_alcohol_opioid_all_refresh();
</script>
