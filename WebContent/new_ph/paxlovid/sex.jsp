<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 id="sex-title" class="viz-title"></h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="save_viz_pass_sex('.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="save_viz_pass_sex('.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="save_viz_pass_sex('.svg');">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_sex_viz" class="dash_viz clip">
		</div>
	</div>
</div>

<script>

//this is to change the title of the download based on which visualization mode is selected
function save_viz_pass_sex(extension){
	var text = text = "Counts of ${param.topic_title} by Sex and Paxlovid Status" + extension;
	saveVisualization('${param.block}_sex_viz', text);
};


var title = "Counts of ${param.topic_title} by Sex and Paxlovid Status";
$("#sex-title").text(title);


function ${param.block}_sex_refresh() {
	var properties = {
			domName: '${param.block}_sex_viz',
			block: '${param.block}',
			primary: 'sex',
			secondary: 'pax',
			count: 'patient_count',
			xaxis_label: 'Count',
			xaxis_label2: 'Percent',
			legend_label: paxlovid_legend,
			colorscale: paxlovid_range,
			label1: 'Sex',
			label2: 'Paxlovid Status',
			offset: 100,
			array: 'paxlovid',
			legendid: '${param.block}legend', 
			nopercent: true
	};
	
	d3.select("#${param.block}_sex_viz").select("svg").remove();
	
	localHorizontalGroupedBarChart_new(${param.block}_statusArray, properties);	
}

${param.block}_sex_refresh();

</script>
