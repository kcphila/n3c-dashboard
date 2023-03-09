<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="viz_options_dropdown">
	<span class="align-middle">Explore Topic By </span>
	<select id="${param.block}toggle_viz_select">
		<option value="age">Age</option>
		<option value="sex">Sex</option>
		<option hidden value="verylongtextverylongtext">verylongtextverylongtext</option>
	</select>
</div>

<div class="row" id="${param.block}viz1">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Age</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Age.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Age.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Age.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_age_viz" class="col-12 dash_viz"></div>
	</div>
</div>

<div class="row" id="${param.block}viz2" style="display:none;">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Sex</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Sex.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Sex.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} ${param.topic_disease} by Diagnosis Timeframe and Sex.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_sex_viz" class="col-12 dash_viz"></div>
	</div>
</div>
		

<script>

$('#${param.block}toggle_viz_select').select2({
	minimumResultsForSearch: Infinity,
	templateResult: function(option) {
	      if(option.element && (option.element).hasAttribute('hidden')){
	         return null;
	      }
	      return option.text;
	   }
});

$('#${param.block}toggle_viz_select').change(function () {
	var viz = $(this).val();
	
	if (viz == "age"){
		$('#${param.block}viz2').css('display', 'none');
		$('#${param.block}viz1').css('display', 'block');
		${param.block}_age_refresh();
	};
	if (viz == "sex"){
		$('#${param.block}viz1').css('display', 'none');
		$('#${param.block}viz2').css('display', 'block');
		${param.block}_sex_refresh();
	};
});

function ${param.block}_age_refresh() {
	var properties = {
			domName: '${param.block}_age_viz',
			primary: 'observation',
			secondary: 'age',
			count: 'patient_count',
			stack_group: 'sex',
			xaxis_label: 'Sex',
			legend_label: sex_legend,
			colorscale: sex_range,
			label1: 'Observation',
			label2: 'Age',
			offset: 250
	}
	
   	d3.select("#${param.block}_age_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart(${param.block}_AgeSexArray, properties);	
}

${param.block}_age_refresh();

function ${param.block}_sex_refresh() {
	var properties = {
			domName: '${param.block}_sex_viz',
			primary: 'observation',
			secondary: 'sex',
			count: 'patient_count',
			stack_group: 'age',
			xaxis_label: 'Age',
			legend_label: age_legend_4,
			colorscale: age_range,
			label1: 'Observation',
			label2: 'Sex',
			offset: 250
	}

	// console.log('reached sex refresh');
   	d3.select("#${param.block}_sex_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart(${param.block}_SexAgeArray, properties);	
}

${param.block}_sex_refresh();
</script>
