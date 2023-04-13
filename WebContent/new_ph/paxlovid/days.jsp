<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 id="days-title" class="viz-title"></h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="save_viz_pass_days('.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="save_viz_pass_days('.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="save_viz_pass_days('.svg');">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_days_viz" class="dash_viz clip">
		</div>
	</div>
</div>

<script>

//this is to change the title of the download based on which visualization mode is selected
function save_viz_pass_days(extension){
	var text = text = "Counts of ${param.topic_title} by # of Days Between COVID+ Diagnosis and Prescription" + extension;
	saveVisualization('${param.block}_days_viz', text);
};


var title = "Counts of ${param.topic_title} by # of Days Between COVID+ Diagnosis and Prescription";
$("#days-title").text(title);


function ${param.block}_days_refresh() {
	var properties = {
			domName: '#${param.block}_days_viz',
			barLabelWidth: 50,
			min_height: 300,
			ordered: 0,
			colorscale: sequential_1_5,
			legend_label: 'Days',
			legend_data: days_pax_legend
		}
	
	d3.select("#${param.block}_days_viz").select("svg").remove();
	
	localHorizontalBarChart_new(${param.block}_DaysArray, properties);
}

${param.block}_days_refresh();

</script>
