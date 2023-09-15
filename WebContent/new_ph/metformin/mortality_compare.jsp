<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div class="row">
	<div class="col-12 col-md-6 viz-container">
		<div class="row">
			<div class="col-12 viz-header-section">
				<div style="display:flex; flex-wrap: nowrap;">
					<h2 id="${param.block}mortality-title2" class="viz-title"></h2>
					<div>
						<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fas fa-download"></i>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality2('.jpg');">Save as JPG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality2('.png');">Save as PNG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality2('.svg');">Save as SVG</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div class="loading">
					<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
				</div>
				<div id="${param.block}_mortality2_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6 viz-container">
		<div class="row">
			<div class="col-12 viz-header-section">
				<div style="display:flex; flex-wrap: nowrap;">
					<h2 id="${param.block}mortality-title1" class="viz-title"></h2>
					<div>
						<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fas fa-download"></i>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality1('.jpg');">Save as JPG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality1('.png');">Save as PNG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality1('.svg');">Save as SVG</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div class="loading">
					<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
				</div>
				<div id="${param.block}_mortality1_viz" class="dash_viz"></div>
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
					<h2 id="${param.block}mortality-title4" class="viz-title"></h2>
					<div>
						<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fas fa-download"></i>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality4('.jpg');">Save as JPG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality4('.png');">Save as PNG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality4('.svg');">Save as SVG</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div class="loading">
					<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
				</div>
				<div id="${param.block}_mortality4_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6 viz-container">
		<div class="row">
			<div class="col-12 viz-header-section">
				<div style="display:flex; flex-wrap: nowrap;">
					<h2 id="${param.block}mortality-title3" class="viz-title"></h2>
					<div>
						<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fas fa-download"></i>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality3('.jpg');">Save as JPG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality3('.png');">Save as PNG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality3('.svg');">Save as SVG</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div class="loading">
					<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
				</div>
				<div id="${param.block}_mortality3_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6 viz-container">
		<div class="row">
			<div class="col-12 viz-header-section">
				<div style="display:flex; flex-wrap: nowrap;">
					<h2 id="${param.block}mortality-title6" class="viz-title"></h2>
					<div>
						<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fas fa-download"></i>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality6('.jpg');">Save as JPG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality6('.png');">Save as PNG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality6('.svg');">Save as SVG</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div class="loading">
					<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
				</div>
				<div id="${param.block}_mortality6_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-6 viz-container">
		<div class="row">
			<div class="col-12 viz-header-section">
				<div style="display:flex; flex-wrap: nowrap;">
					<h2 id="${param.block}mortality-title5" class="viz-title"></h2>
					<div>
						<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fas fa-download"></i>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality5('.jpg');">Save as JPG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality5('.png');">Save as PNG</a>
							<a class="dropdown-item" onclick="${param.block}save_viz_pass_mortality5('.svg');">Save as SVG</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-12">
				<div class="loading">
					<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
				</div>
				<div id="${param.block}_mortality5_viz" class="dash_viz"></div>
			</div>
		</div>
	</div>
</div>


<script>
//this is to change the title of the download based on which visualization mode is selected
function ${param.block}save_viz_pass_mortality1(extension){
	
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "% Mortality of Total Patients in the Enclave who were Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "Mortality of Total Patients in the Enclave who were Prescribed Metformin" + extension;
	} else {
		text = "% Mortality of Total Patients in the Enclave who were Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_mortality1_viz', text);
};

function ${param.block}save_viz_pass_mortality2(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "% Mortality of Total Patients in the Enclave who were not Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "Mortality of Total Patients in the Enclave who were not Prescribed Metformin" + extension;
	} else {
		text = "% Mortality of Total Patients in the Enclave who were not Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_mortality2_viz', text);
};

function ${param.block}save_viz_pass_mortality3(extension){
	
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "% Mortality of Diabetic Patients in the Enclave who were Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "Mortality of Diabetic Patients in the Enclave who were Prescribed Metformin" + extension;
	} else {
		text = "% Mortality of Diabetic Patients in the Enclave who were Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_mortality3_viz', text);
};

function ${param.block}save_viz_pass_mortality4(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "% Mortality of Diabetic Patients in the Enclave who were not Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "Mortality of Diabetic Patients in the Enclave who were not Prescribed Metformin" + extension;
	} else {
		text = "% Mortality of Diabetic Patients in the Enclave who were not Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_mortality4_viz', text);
};

function ${param.block}save_viz_pass_mortality5(extension){
	
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "% Mortality of Non-Diabetic Patients in the Enclave who were Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "Mortality of Non-Diabetic Patients in the Enclave who were Prescribed Metformin" + extension;
	} else {
		text = "% Mortality of Non-Diabetic Patients in the Enclave who were Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_mortality5_viz', text);
};

function ${param.block}save_viz_pass_mortality6(extension){
	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = "% Mortality of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin (pie)" + extension;
	} else if (mode == 'bar'){
		text = "Mortality of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin" + extension;
	} else {
		text = "% Mortality of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin" + extension;
	};
	
	saveVisualization('${param.block}_mortality6_viz', text);
};

// set inital title based on load mode
var title_id = $("#${param.block}-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode == 'bar'){
	var title1 = "Mortality of Total Patients in the Enclave who were Prescribed Metformin";
	var title2 = "Mortality of Total Patients in the Enclave who were not Prescribed Metformin";
	var title3 = "Mortality of Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title4 = "Mortality of Diabetic Patients in the Enclave who were not Prescribed Metformin";
	var title5 = "Mortality of Non-Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title6 = "Mortality of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin";
	$("#${param.block}mortality-title1").text(title1);
	$("#${param.block}mortality-title2").text(title2);
	$("#${param.block}mortality-title3").text(title3);
	$("#${param.block}mortality-title4").text(title4);
	$("#${param.block}mortality-title5").text(title5);
	$("#${param.block}mortality-title6").text(title6);
} else {
	var title1 = "% Mortality of Total Patients in the Enclave who were Prescribed Metformin";
	var title2 = "% Mortality of Total Patients in the Enclave who were not Prescribed Metformin";
	var title3 = "% Mortality of Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title4 = "% Mortality of Diabetic Patients in the Enclave who were not Prescribed Metformin";
	var title5 = "% Mortality of Non-Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title6 = "% Mortality of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin";
	$("#${param.block}mortality-title1").text(title1);
	$("#${param.block}mortality-title2").text(title2);
	$("#${param.block}mortality-title3").text(title3);
	$("#${param.block}mortality-title4").text(title4);
	$("#${param.block}mortality-title5").text(title5);
	$("#${param.block}mortality-title6").text(title6);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-mode-barpercent').on('mouseup', function() {
	var title1 = "% Mortality of Total Patients in the Enclave who were Prescribed Metformin";
	var title2 = "% Mortality of Total Patients in the Enclave who were not Prescribed Metformin";
	var title3 = "% Mortality of Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title4 = "% Mortality of Diabetic Patients in the Enclave who were not Prescribed Metformin";
	var title5 = "% Mortality of Non-Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title6 = "% Mortality of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin";
	$("#${param.block}mortality-title1").text(title1);
	$("#${param.block}mortality-title2").text(title2);
	$("#${param.block}mortality-title3").text(title3);
	$("#${param.block}mortality-title4").text(title4);
	$("#${param.block}mortality-title5").text(title5);
	$("#${param.block}mortality-title6").text(title6);
});
$('#${param.block}-mode-bar').on('mouseup', function() {
	var title1 = "Mortality of Total Patients in the Enclave who were Prescribed Metformin";
	var title2 = "Mortality of Total Patients in the Enclave who were not Prescribed Metformin";
	var title3 = "Mortality of Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title4 = "Mortality of Diabetic Patients in the Enclave who were not Prescribed Metformin";
	var title5 = "Mortality of Non-Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title6 = "Mortality of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin";
	$("#${param.block}mortality-title1").text(title1);
	$("#${param.block}mortality-title2").text(title2);
	$("#${param.block}mortality-title3").text(title3);
	$("#${param.block}mortality-title4").text(title4);
	$("#${param.block}mortality-title5").text(title5);
	$("#${param.block}mortality-title6").text(title6);
});
$('#${param.block}-mode-pie').on('mouseup', function() {
	var title1 = "% Mortality of Total Patients in the Enclave who were Prescribed Metformin";
	var title2 = "% Mortality of Total Patients in the Enclave who were not Prescribed Metformin";
	var title3 = "% Mortality of Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title4 = "% Mortality of Diabetic Patients in the Enclave who were not Prescribed Metformin";
	var title5 = "% Mortality of Non-Diabetic Patients in the Enclave who were Prescribed Metformin";
	var title6 = "% Mortality of Non-Diabetic Patients in the Enclave who were not Prescribed Metformin";
	$("#${param.block}mortality-title1").text(title1);
	$("#${param.block}mortality-title2").text(title2);
	$("#${param.block}mortality-title3").text(title3);
	$("#${param.block}mortality-title4").text(title4);
	$("#${param.block}mortality-title5").text(title5);
	$("#${param.block}mortality-title6").text(title6);
});


function ${param.block}_mortality_refresh() {
	var properties1 = {
		domName: '#${param.block}_mortality1_viz',
		barLabelWidth: 100,
		min_height: 300,
		ordered: 0,
		colorscale: mortality_range,
		legend_label: 'Mortality',
		legend_data: mortality_legend,
		donutRatio: 0.5
	}
	
	var properties2 = {
		domName: '#${param.block}_mortality2_viz',
		barLabelWidth: 100,
		min_height: 300,
		ordered: 0,
		colorscale: mortality_range,
		legend_label: 'Mortality',
		legend_data: mortality_legend,
		donutRatio: 0.5
	}
	
	var properties3 = {
		domName: '#${param.block}_mortality3_viz',
		barLabelWidth: 100,
		min_height: 300,
		ordered: 0,
		colorscale: mortality_range,
		legend_label: 'Mortality',
		legend_data: mortality_legend,
		donutRatio: 0.5
	}
	
	var properties4 = {
		domName: '#${param.block}_mortality4_viz',
		barLabelWidth: 100,
		min_height: 300,
		ordered: 0,
		colorscale: mortality_range,
		legend_label: 'Mortality',
		legend_data: mortality_legend,
		donutRatio: 0.5
	}
	
	var properties5 = {
			domName: '#${param.block}_mortality5_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'Mortality',
			legend_data: mortality_legend,
			donutRatio: 0.5
		}
	
	var properties6 = {
			domName: '#${param.block}_mortality6_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'Mortality',
			legend_data: mortality_legend,
			donutRatio: 0.5
		}

	var id = $("#${param.block}-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	d3.select("#${param.block}_mortality1_viz").select("svg").remove();
	d3.select("#${param.block}_mortality2_viz").select("svg").remove();
	d3.select("#${param.block}_mortality3_viz").select("svg").remove();
	d3.select("#${param.block}_mortality4_viz").select("svg").remove();
	d3.select("#${param.block}_mortality5_viz").select("svg").remove();
	d3.select("#${param.block}_mortality6_viz").select("svg").remove();
	
	if (mode =='pie'){		
		localPieChart_new(${param.block}_MortalityMetArray, properties1);
		localPieChart_new(${param.block}_MortalityNoMetArray, properties2);
		localPieChart_new(${param.block}_MortalityDiabMetArray, properties3);
		localPieChart_new(${param.block}_MortalityDiabNoMetArray, properties4);
		localPieChart_new(${param.block}_MortalityNoDiabMetArray, properties5);
		localPieChart_new(${param.block}_MortalityNoDiabNoMetArray, properties6);
	} else if (mode == 'bar'){
		localHorizontalBarChart_new(${param.block}_MortalityMetArray, properties1);
		localHorizontalBarChart_new(${param.block}_MortalityNoMetArray, properties2);
		localHorizontalBarChart_new(${param.block}_MortalityDiabMetArray, properties3);
		localHorizontalBarChart_new(${param.block}_MortalityDiabNoMetArray, properties4);
		localHorizontalBarChart_new(${param.block}_MortalityNoDiabMetArray, properties5);
		localHorizontalBarChart_new(${param.block}_MortalityNoDiabNoMetArray, properties6);
	} else {
		localPercentageBarChart_new(${param.block}_MortalityMetArray, properties1);
		localPercentageBarChart_new(${param.block}_MortalityNoMetArray, properties2);
		localPercentageBarChart_new(${param.block}_MortalityDiabMetArray, properties3);
		localPercentageBarChart_new(${param.block}_MortalityDiabNoMetArray, properties4);
		localPercentageBarChart_new(${param.block}_MortalityNoDiabMetArray, properties5);
		localPercentageBarChart_new(${param.block}_MortalityNoDiabNoMetArray, properties6);
	};

	
}

</script>
