<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div class="row">
	<div class="col-12 col-md-6 viz-container">
		<div class="row">
			<div class="col-12 viz-header-section">
				<div style="display:flex; flex-wrap: nowrap;">
					<h2 id="${param.block}long-title2" class="viz-title"></h2>
					<div>
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
			</div>
			<div class="col-12">
				<div id="${param.block}_long2_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6 viz-container">
		<div class="row">
			<div class="col-12 viz-header-section">
				<div style="display:flex; flex-wrap: nowrap;">
					<h2 id="${param.block}long-title1" class="viz-title"></h2>
					<div>
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
			</div>
			<div class="col-12">
				<div id="${param.block}_long1_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 viz-container alert alert-primary">
		<span> Note that total patients include all diabetic patients, who comprise a substantial portion of the total patients taking Metformin. 
		Trends are broken down by Diabetes Status below. </span>
	</div>
	<div class="col-12 col-md-6 viz-container">
		<div class="row">
			<div class="col-12 viz-header-section">
				<div style="display:flex; flex-wrap: nowrap;">
					<h2 id="${param.block}long-title4" class="viz-title"></h2>
					<div>
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
			</div>
			<div class="col-12">
				<div id="${param.block}_long4_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6 viz-container">
		<div class="row">
			<div class="col-12 viz-header-section">
				<div style="display:flex; flex-wrap: nowrap;">
					<h2 id="${param.block}long-title3" class="viz-title"></h2>
					<div>
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
			</div>
			<div class="col-12">
				<div id="${param.block}_long3_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6 viz-container">
		<div class="row">
			<div class="col-12 viz-header-section">
				<div style="display:flex; flex-wrap: nowrap;">
					<h2 id="${param.block}long-title6" class="viz-title"></h2>
					<div>
						<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fas fa-download"></i>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_long6('.jpg');">Save as JPG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_long6('.png');">Save as PNG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_long6('.svg');">Save as SVG</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div id="${param.block}_long6_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6 viz-container">
		<div class="row">
			<div class="col-12 viz-header-section">
				<div style="display:flex; flex-wrap: nowrap;">
					<h2 id="${param.block}long-title5" class="viz-title"></h2>
					<div>
						<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fas fa-download"></i>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_long5('.jpg');">Save as JPG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_long5('.png');">Save as PNG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_long5('.svg');">Save as SVG</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div id="${param.block}_long5_viz" class="dash_viz"></div>
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
		text = "% Long COVID Status of Total Patients in the Enclave who were Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "% Long COVID Status of Total Patients in the Enclave who were Prescribed Metformin" + extension;
	} else {
		text = "% Long COVID Status of Total Patients in the Enclave who were Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_long1_viz', text);
};

function ${param.block}save_viz_pass_long2(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "% Long COVID Status of Total Patients in the Enclave who were not Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "Long COVID Status of Total Patients in the Enclave who were not Prescribed Metformin" + extension;
	} else {
		text = "% Long COVID Status of Total Patients in the Enclave who were not Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_long2_viz', text);
};

function ${param.block}save_viz_pass_long3(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "% Long COVID Status of Diabetic Patients in the Enclave who were Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "Long COVID Status of Diabetic Patients in the Enclave who were Prescribed Metformin" + extension;
	} else {
		text = "% Long COVID Status of Diabetic Patients in the Enclave who were Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_long3_viz', text);
};

function ${param.block}save_viz_pass_long4(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "% Long COVID Status of Diabetic Patients in the Enclave who were not Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "Long COVID Status of Diabetic Patients in the Enclave who were not Prescribed Metformin" + extension;
	} else {
		text = "% Long COVID Status of Diabetic Patients in the Enclave who were not Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_long4_viz', text);
};

function ${param.block}save_viz_pass_long5(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "% Long COVID Status of Non-Diabetic Patients in the Enclave who were Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "Long COVID Status of Non-Diabetic Patients in the Enclave who were Prescribed Metformin" + extension;
	} else {
		text = "% Long COVID Status of Non-Diabetic Patients in the Enclave who were Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_long5_viz', text);
};

function ${param.block}save_viz_pass_long6(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "% Long COVID Status of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "Long COVID Status of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin" + extension;
	} else {
		text = "% Long COVID Status of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_long6_viz', text);
};

//set inital title based on load mode
var title_id = $("#${param.block}-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode == 'bar'){
	var title1 = "Long COVID Status of Total Patients in the Enclave who were Prescribed Metformin";
	var title2 = "Long COVID Status of Total Patients in the Enclave who were not Prescribed Metformin";
	var title3 = "Long COVID Status of Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title4 = "Long COVID Status of Diabetic Patients in the Enclave who were not Prescribed Metformin";
	var title5 = "Long COVID Status of Non-Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title6 = "Long COVID Status of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin";
	$("#${param.block}long-title1").text(title1);
	$("#${param.block}long-title2").text(title2);
	$("#${param.block}long-title3").text(title3);
	$("#${param.block}long-title4").text(title4);
	$("#${param.block}long-title5").text(title5);
	$("#${param.block}long-title6").text(title6);
} else {
	var title1 = "% Long COVID Status of Total Patients in the Enclave who were Prescribed Metformin";
	var title2 = "% Long COVID Status of Total Patients in the Enclave who were not Prescribed Metformin";
	var title3 = "% Long COVID Status of Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title4 = "% Long COVID Status of Diabetic Patients in the Enclave who were not Prescribed Metformin";
	var title5 = "% Long COVID Status of Non-Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title6 = "% Long COVID Status of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin";
	$("#${param.block}long-title1").text(title1);
	$("#${param.block}long-title2").text(title2);
	$("#${param.block}long-title3").text(title3);
	$("#${param.block}long-title4").text(title4);
	$("#${param.block}long-title5").text(title5);
	$("#${param.block}long-title6").text(title6);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-mode-barpercent').on('mouseup', function() {
	var title1 = "% Long COVID Status of Total Patients in the Enclave who were Prescribed Metformin";
	var title2 = "% Long COVID Status of Total Patients in the Enclave who were not Prescribed Metformin";
	var title3 = "% Long COVID Status of Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title4 = "% Long COVID Status of Diabetic Patients in the Enclave who were not Prescribed Metformin";
	var title5 = "% Long COVID Status of Non-Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title6 = "% Long COVID Status of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin";
	$("#${param.block}long-title1").text(title1);
	$("#${param.block}long-title2").text(title2);
	$("#${param.block}long-title3").text(title3);
	$("#${param.block}long-title4").text(title4);
	$("#${param.block}long-title5").text(title5);
	$("#${param.block}long-title6").text(title6);
});
$('#${param.block}-mode-bar').on('mouseup', function() {
	var title1 = "Long COVID Status of Total Patients in the Enclave who were Prescribed Metformin";
	var title2 = "Long COVID Status of Total Patients in the Enclave who were not Prescribed Metformin";
	var title3 = "Long COVID Status of Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title4 = "Long COVID Status of Diabetic Patients in the Enclave who were not Prescribed Metformin";
	var title5 = "Long COVID Status of Non-Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title6 = "Long COVID Status of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin";
	$("#${param.block}long-title1").text(title1);
	$("#${param.block}long-title2").text(title2);
	$("#${param.block}long-title3").text(title3);
	$("#${param.block}long-title4").text(title4);
	$("#${param.block}long-title5").text(title5);
	$("#${param.block}long-title6").text(title6);
});
$('#${param.block}-mode-pie').on('mouseup', function() {
	var title1 = "% Long COVID Status of Total Patients in the Enclave who were Prescribed Metformin";
	var title2 = "% Long COVID Status of Total Patients in the Enclave who were not Prescribed Metformin";
	var title3 = "% Long COVID Status of Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title4 = "% Long COVID Status of Diabetic Patients in the Enclave who were not Prescribed Metformin";
	var title5 = "% Long COVID Status of Non-Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title6 = "% Long COVID Status of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin";
	$("#${param.block}long-title1").text(title1);
	$("#${param.block}long-title2").text(title2);
	$("#${param.block}long-title3").text(title3);
	$("#${param.block}long-title4").text(title4);
	$("#${param.block}long-title5").text(title5);
	$("#${param.block}long-title6").text(title6);
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
	
	var properties5 = {
			domName: '#${param.block}_long5_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: longstatus_range,
			legend_label: 'Longstatus',
			legend_data: longstatus_legend,
			donutRatio: 0.5
	}
	
	var properties6 = {
		domName: '#${param.block}_long6_viz',
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
	d3.select("#${param.block}_long3_viz").select("svg").remove();
	d3.select("#${param.block}_long4_viz").select("svg").remove();
	d3.select("#${param.block}_long5_viz").select("svg").remove();
	d3.select("#${param.block}_long6_viz").select("svg").remove();
	
	if (mode =='pie'){		
		localPieChart_new(${param.block}_LongMetArray, properties1);
		localPieChart_new(${param.block}_LongNoMetArray, properties2);
		localPieChart_new(${param.block}_LongDiabMetArray, properties3);
		localPieChart_new(${param.block}_LongDiabNoMetArray, properties3);
		localPieChart_new(${param.block}_LongNoDiabMetArray, properties5);
		localPieChart_new(${param.block}_LongNoDiabNoMetArray, properties6);
	} else if (mode == 'bar'){
		localHorizontalBarChart_new(${param.block}_LongMetArray, properties1);
		localHorizontalBarChart_new(${param.block}_LongNoMetArray, properties2);
		localHorizontalBarChart_new(${param.block}_LongDiabMetArray, properties3);
		localHorizontalBarChart_new(${param.block}_LongDiabNoMetArray, properties4);
		localHorizontalBarChart_new(${param.block}_LongNoDiabMetArray, properties5);
		localHorizontalBarChart_new(${param.block}_LongNoDiabNoMetArray, properties6);
	} else {
		localPercentageBarChart_new(${param.block}_LongMetArray, properties1);
		localPercentageBarChart_new(${param.block}_LongNoMetArray, properties2);
		localPercentageBarChart_new(${param.block}_LongDiabMetArray, properties3);
		localPercentageBarChart_new(${param.block}_LongDiabNoMetArray, properties4);
		localPercentageBarChart_new(${param.block}_LongNoDiabMetArray, properties5);
		localPercentageBarChart_new(${param.block}_LongNoDiabNoMetArray, properties6);
	};

	
}

${param.block}_long_refresh();

</script>
