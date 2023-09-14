<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 id="${param.block}-smokingstatus-title" class="viz-title"></h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="save_viz_pass_smokingstatus('.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="save_viz_pass_smokingstatus('.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="save_viz_pass_smokingstatus('.svg');">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_smokingstatus_viz" class="dash_viz"></div>
	</div>
</div>


<script>
//this is to change the title of the download based on which visualization mode is selected
function save_viz_pass_smokingstatus(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "Smoking Status Percentages of ${param.topic_title}" + extension;
	} else if (mode == 'bar'){
		text = "Counts of ${param.topic_title} by Smoking Status" + extension;
	} else {
		text = "Smoking Status Percentages of ${param.topic_title}" + extension;
	};
	
	saveVisualization('${param.block}_smokingstatus_viz', text);
};

// set inital title based on load mode
var title_id = $("#${param.block}-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode =='pie'){		
	var title = "Smoking Status Percentages of ${param.topic_title}";
	$("#${param.block}-smokingstatus-title").text(title);
} else if (title_mode == 'bar'){
	var title = "Counts of ${param.topic_title} by Smoking Status";
	$("#${param.block}-smokingstatus-title").text(title);
} else {
	var title = "Smoking Status Percentages of ${param.topic_title}";
	$("#${param.block}-smokingstatus-title").text(title);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-mode-barpercent').on('mouseup', function() {
	var title = "Smoking Status Percentages of ${param.topic_title}";
	$("#${param.block}-smokingstatus-title").text(title);
});
$('#${param.block}-mode-bar').on('mouseup', function() {
	var title = "Counts of ${param.topic_title} by Smoking Status";
	$("#${param.block}-smokingstatus-title").text(title);
});
$('#${param.block}-mode-pie').on('mouseup', function() {
	var title = "Smoking Status Percentages of ${param.topic_title}";
	$("#${param.block}-smokingstatus-title").text(title);
});

function ${param.block}_smokingstatus_refresh() {
	var properties = {
			domName: '#${param.block}_smokingstatus_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: smoking_status_range,
			donutRatio: 0.5
		}

	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	d3.select("#${param.block}_smokingstatus_viz").select("svg").remove();
	
	if (mode =='pie'){		
		localPieChart_new(${param.block}_SmokingStatusArray, properties);
	} else if (mode == 'bar'){
		localHorizontalBarChart_new(${param.block}_SmokingStatusArray, properties);
	} else {
		localPercentageBarChart_new(${param.block}_SmokingStatusArray, properties);
	};
	
}

${param.block}_smokingstatus_refresh();

</script>
