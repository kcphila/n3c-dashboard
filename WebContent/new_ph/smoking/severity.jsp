<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 id="severity-title" class="viz-title"></h2>
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
		<div id="${param.block}_severity_viz" class="dash_viz clip"></div>
	</div>
</div>

<script>
//this is to change the title of the download based on which visualization mode is selected
function save_viz_pass(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode == 'bar'){
		text = "Counts of ${param.topic_title} by Severity and Smoking Status" + extension;
	} else {
		text = "% of COVID+ Smokers In Each Severity Category Vs. % of COVID+ Non-Smokers In Each Severity Category" + extension;
	};
	
	saveVisualization('${param.block}_severity_viz', text);
};

// set inital title based on load mode
var title_id = $("#${param.block}-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode == 'bar'){
	var title = "Counts of ${param.topic_title} by Severity and Smoking Status";
	$("#severity-title").text(title);
} else {
	var title = "% of COVID+ Smokers In Each Severity Category Vs. % of COVID+ Non-Smokers In Each Severity Category";
	$("#severity-title").text(title);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-mode-barpercent').on('mouseup', function() {
	var title = "% of COVID+ Smokers In Each Severity Category Vs. % of COVID+ Non-Smokers In Each Severity Category";
	$("#severity-title").text(title);
});
$('#${param.block}-mode-bar').on('mouseup', function() {
	var title = "Counts of ${param.topic_title} by Severity and Smoking Status";
	$("#severity-title").text(title);
});


function ${param.block}_severity_refresh() {
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	d3.select("#${param.block}_severity_viz").select("svg").remove();
	
	var properties = {
			domName: '${param.block}_severity_viz',
			block: '${param.block}',
			primary: 'severity',
			secondary: 'smoking_status',
			count: 'patient_count',
			xaxis_label: 'Count',
			xaxis_label2: 'Percent',
			legend_label: status_legend,
			colorscale: status_range,
			label1: 'Severity',
			label2: 'Smoking Status',
			offset: 90,
			array: 'status',
			legendid: '${param.block}legend'
	};

	if (mode == 'bar'){
		localHorizontalGroupedBarChart_new(${param.block}_statusArray, properties);	
	} else if (mode == 'barpercent'){
		localHorizontalGroupedPercentageBarChart_new(${param.block}_statusArray, properties);	
	};
};
</script>
