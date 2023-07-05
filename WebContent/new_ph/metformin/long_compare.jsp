<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div class="row">
	<div class="col-12 col-md-6">
		<div class="row">
			<div class="col-12 viz-header-section">
				<h2 id="${param.block}long-title2" class="viz-title"></h2>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long2('.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long2('.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long2('.svg');">Save as SVG</a>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div id="${param.block}_long2_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6">
		<div class="row">
			<div class="col-12 viz-header-section">
				<h2 id="${param.block}long-title1" class="viz-title"></h2>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long1('.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long1('.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long1('.svg');">Save as SVG</a>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div id="${param.block}_long1_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6">
		<div class="row">
			<div class="col-12 viz-header-section">
				<h2 id="${param.block}long-title4" class="viz-title"></h2>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long4('.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long4('.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long4('.svg');">Save as SVG</a>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div id="${param.block}_long4_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6">
		<div class="row">
			<div class="col-12 viz-header-section">
				<h2 id="${param.block}long-title3" class="viz-title"></h2>
				<div class="btn-group float-right">
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long3('.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long3('.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="${param.block}save_viz_pass_long3('.svg');">Save as SVG</a>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div id="${param.block}_long3_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	
</div>


<script>
//this is to change the title of the download based on which visualization mode is selected
function ${param.block}save_viz_pass_long1(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "Long COVID Status Percentages of All Metformin Patients" + extension;
	} else if (mode == 'bar'){
		text = "Counts of All Metformin Patients by Long COVID Status" + extension;
	} else {
		text = "Long COVID Status Percentages of All Metformin Patients" + extension;
	};
	
	saveVisualization('${param.block}_long1_viz', text);
};

function ${param.block}save_viz_pass_long2(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "Long COVID Status Percentages of All Non-Metformin Patients" + extension;
	} else if (mode == 'bar'){
		text = "Counts of All Non-Metformin Patients by Long COVID Status" + extension;
	} else {
		text = "Long COVID Status Percentages of All Non-Metformin Patients" + extension;
	};
	
	saveVisualization('${param.block}_long2_viz', text);
};

function ${param.block}save_viz_pass_long3(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "Long COVID Status Percentages of Diabetic Metformin Patients" + extension;
	} else if (mode == 'bar'){
		text = "Counts of Diabetic Metformin Patients by Long COVID Status" + extension;
	} else {
		text = "Long COVID Status Percentages of Diabetic Metformin Patients" + extension;
	};
	
	saveVisualization('${param.block}_long3_viz', text);
};

function ${param.block}save_viz_pass_long4(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "Long COVID Status Percentages of Diabetic Non-Metformin Patients" + extension;
	} else if (mode == 'bar'){
		text = "Counts of Diabetic Non-Metformin Patients by Long COVID Status" + extension;
	} else {
		text = "Long COVID Status Percentages of Diabetic Non-Metformin Patients" + extension;
	};
	
	saveVisualization('${param.block}_long4_viz', text);
};

// set inital title based on load mode
var title_id = $("#${param.block}-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode =='pie'){		
	var title = "LC Status Percentages of All Metformin Patients";
	$("#${param.block}long-title1").text(title);
} else if (title_mode == 'bar'){
	var title = "Counts of All Metformin Patients by LC Status";
	$("#${param.block}long-title1").text(title);
} else {
	var title = "LC Status Percentages of All Metformin Patients";
	$("#${param.block}long-title1").text(title);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-mode-barpercent').on('mouseup', function() {
	var title = "LC Status Percentages of All Metformin Patients";
	$("#${param.block}long-title1").text(title);
});
$('#${param.block}-mode-bar').on('mouseup', function() {
	var title = "Counts of All Metformin Patients by LC Status";
	$("#${param.block}long-title1").text(title);
});
$('#${param.block}-mode-pie').on('mouseup', function() {
	var title = "LC Status Percentages of All Metformin Patients";
	$("#${param.block}long-title1").text(title);
});

//set inital title based on load mode
var title_id2 = $("#${param.block}-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode =='pie'){		
	var title = "LC Status Percentages of All Non-Metformin Patients";
	$("#${param.block}long-title2").text(title);
} else if (title_mode == 'bar'){
	var title = "Counts of All Non-Metformin Patients by LC Status";
	$("#${param.block}long-title2").text(title);
} else {
	var title = "LC Status Percentages of All Non-Metformin Patients";
	$("#${param.block}long-title2").text(title);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-mode-barpercent').on('mouseup', function() {
	var title = "LC Status Percentages of All Non-Metformin Patients";
	$("#${param.block}long-title2").text(title);
});
$('#${param.block}-mode-bar').on('mouseup', function() {
	var title = "Counts of All Non-Metformin Patients by LC Status";
	$("#${param.block}long-title2").text(title);
});
$('#${param.block}-mode-pie').on('mouseup', function() {
	var title = "LC Status Percentages of All Non-Metformin Patients";
	$("#${param.block}long-title2").text(title);
});

//set inital title based on load mode
var title_id3 = $("#${param.block}-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode =='pie'){		
	var title = "LC Status Percentages of Diabetic Metformin Patients";
	$("#${param.block}long-title3").text(title);
} else if (title_mode == 'bar'){
	var title = "Counts of Diabetic Metformin Patients by LC Status";
	$("#${param.block}long-title3").text(title);
} else {
	var title = "LC Status Percentages of Diabetic Metformin Patients";
	$("#${param.block}long-title3").text(title);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-mode-barpercent').on('mouseup', function() {
	var title = "LC Status Percentages of Diabetic Metformin Patients";
	$("#${param.block}long-title3").text(title);
});
$('#${param.block}-mode-bar').on('mouseup', function() {
	var title = "Counts of Diabetic Metformin Patients by LC Status";
	$("#${param.block}long-title3").text(title);
});
$('#${param.block}-mode-pie').on('mouseup', function() {
	var title = "LC Status Percentages of Diabetic Metformin Patients";
	$("#${param.block}long-title3").text(title);
});

//set inital title based on load mode
var title_id4 = $("#${param.block}-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode =='pie'){		
	var title = "LC Status Percentages of Diabetic Non-Metformin Patients";
	$("#${param.block}long-title4").text(title);
} else if (title_mode == 'bar'){
	var title = "Counts of Diabetic Non-Metformin Patients by LC Status";
	$("#${param.block}long-title4").text(title);
} else {
	var title = "LC Status Percentages of Diabetic Non-Metformin Patients";
	$("#${param.block}long-title4").text(title);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-mode-barpercent').on('mouseup', function() {
	var title = "LC Status Percentages of Diabetic Non-Metformin Patients";
	$("#${param.block}long-title4").text(title);
});
$('#${param.block}-mode-bar').on('mouseup', function() {
	var title = "Counts of Diabetic Non-Metformin Patients by LC Status";
	$("#${param.block}long-title4").text(title);
});
$('#${param.block}-mode-pie').on('mouseup', function() {
	var title = "LC Status Percentages of Diabetic Non-Metformin Patients";
	$("#${param.block}long-title4").text(title);
});



function ${param.block}_long_refresh() {
	var properties1 = {
		domName: '#${param.block}_long1_viz',
		barLabelWidth: 100,
		min_height: 300,
		ordered: 0,
		colorscale: longstatus_range,
		legend_label: 'Longstatus',
		legend_data: longstatus_legend,
		donutRatio: 0.5
	}
	
	var properties2 = {
		domName: '#${param.block}_long2_viz',
		barLabelWidth: 100,
		min_height: 300,
		ordered: 0,
		colorscale: longstatus_range,
		legend_label: 'Longstatus',
		legend_data: longstatus_legend,
		donutRatio: 0.5
	}
	
	var properties3 = {
		domName: '#${param.block}_long3_viz',
		barLabelWidth: 100,
		min_height: 300,
		ordered: 0,
		colorscale: longstatus_range,
		legend_label: 'Longstatus',
		legend_data: longstatus_legend,
		donutRatio: 0.5
	}
	
	var properties4 = {
		domName: '#${param.block}_long4_viz',
		barLabelWidth: 100,
		min_height: 300,
		ordered: 0,
		colorscale: longstatus_range,
		legend_label: 'Longstatus',
		legend_data: longstatus_legend,
		donutRatio: 0.5
	}

	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	d3.select("#${param.block}_long1_viz").select("svg").remove();
	d3.select("#${param.block}_long2_viz").select("svg").remove();
	
	if (mode =='pie'){		
		localPieChart_new(${param.block}_LongMetArray, properties1);
		localPieChart_new(${param.block}_LongNoMetArray, properties2);
		localPieChart_new(${param.block}_LongDiabMetArray, properties3);
		localPieChart_new(${param.block}_LongDiabNoMetArray, properties3);
	} else if (mode == 'bar'){
		localHorizontalBarChart_new(${param.block}_LongMetArray, properties1);
		localHorizontalBarChart_new(${param.block}_LongNoMetArray, properties2);
		localHorizontalBarChart_new(${param.block}_LongDiabMetArray, properties3);
		localHorizontalBarChart_new(${param.block}_LongDiabNoMetArray, properties4);
	} else {
		localPercentageBarChart_new(${param.block}_LongMetArray, properties1);
		localPercentageBarChart_new(${param.block}_LongNoMetArray, properties2);
		localPercentageBarChart_new(${param.block}_LongDiabMetArray, properties3);
		localPercentageBarChart_new(${param.block}_LongDiabNoMetArray, properties4);
	};

	
}

${param.block}_long_refresh();

</script>
