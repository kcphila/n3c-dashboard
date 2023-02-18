<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 id="race-title" class="viz-title"></h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="save_viz_pass_race('.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="save_viz_pass_race('.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="save_viz_pass_race('.svg');">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_race_viz" class="col-12 dash_viz clip"></div>
	</div>
</div>

<script>
//this is to change the title of the download based on which visualization mode is selected
function save_viz_pass_race(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode == 'bar'){
		text = "Counts of ${param.topic_title} by Race and Smoking Status" + extension;
	} else {
		text = "% of COVID+ Smokers In Each Race Category Vs. % of COVID+ Non-Smokers In Each Race Category" + extension;
	};
	
	saveVisualization('${param.block}_race_viz', text);
};

// set inital title based on load mode
var title_id = $("#${param.block}-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode == 'bar'){
	var title = "Counts of ${param.topic_title} by Race and Smoking Status";
	$("#race-title").text(title);
} else {
	var title = "% of COVID+ Smokers In Each Race Category Vs. % of COVID+ Non-Smokers In Each Race Category";
	$("#race-title").text(title);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-mode-barpercent').on('mouseup', function() {
	var title = "% of COVID+ Smokers In Each Race Category Vs. % of COVID+ Non-Smokers In Each Race Category";
	$("#race-title").text(title);
});
$('#${param.block}-mode-bar').on('mouseup', function() {
	var title = "Counts of ${param.topic_title} by Race and Smoking Status";
	$("#race-title").text(title);
});

function ${param.block}_race_refresh() {
	var properties = {
			domName: '${param.block}_race_viz',
			primary: 'race',
			secondary: 'smoking_status',
			count: 'patient_count',
			xaxis_label: 'Count',
			xaxis_label2: 'Percent',
			legend_label: status_legend,
			colorscale: status_range,
			label1: 'Race',
			label2: 'Smoking Status',
			offset: 70,
			array: 'status'
	}
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	d3.select("#${param.block}_race_viz").select("svg").remove();
	
	if (mode == 'bar'){
		localHorizontalGroupedBarChart_new(${param.block}_statusArray, properties);	
	} else if (mode == 'barpercent'){
		localHorizontalGroupedPercentageBarChart_new(${param.block}_statusArray, properties);	
	};
}

${param.block}_race_refresh();

</script>
