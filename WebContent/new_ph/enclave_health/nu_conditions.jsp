<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 id="conditioncount-title" class="viz-title"></h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="save_viz_pass('.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="save_viz_pass('.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="save_viz_pass('.svg');">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div class="loading">
			<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
		</div>
		<div id="${param.block}_conditioncount_viz" class="dash_viz clip"></div>
	</div>
</div>

<script>
//save viz function
function save_viz_pass(extension){	
	var text = "Counts of ${param.topic_title} by Comorbidity Cluster and Count Type" + extension;
	saveVisualization('${param.block}_conditioncount_viz', text);
};

// set inital title
var title = "Counts of ${param.topic_title} by Comorbidity Cluster and Count Type";
$("#conditioncount-title").text(title);


function ${param.block}_conditioncount_refresh() {
	d3.select("#${param.block}_conditioncount_viz").select("svg").remove();
	
	var properties = {
			domName: '${param.block}_conditioncount_viz',
			block: '${param.block}',
			primary: 'list_of_conditions',
			secondary: 'count',
			count: 'patient_count',
			xaxis_label: 'Count',
			legend_label: count_legend,
			colorscale: count_range,
			label1: 'Conditions',
			label2: 'Count',
			offset: 250,
			array: 'count',
			legendid: '${param.block}legend',
			nopercent: true,
			nosum: true,
			abbrev_label: true
	};

	localHorizontalGroupedBarChart_new(${param.block}_countArray, properties);	

};
</script>
