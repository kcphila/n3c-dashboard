<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="viz_options_dropdown">
	<span class="align-middle">Explore Topic By </span>
	<select id="${param.block}toggle_viz_select">
		<option value="sotrovimab1">Severity & Medications</option>
		<option value="sotrovimab2">Additional Medications</option>
		<option hidden value="verylongtextverylongtext">verylongtextverylongtext</option>
	</select>
</div>
	
<div class="row" id="viz1">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">Aggregated ${param.topic_title} by Severity and Occurrence</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sotrovimab1_viz', 'Aggregated ${param.topic_title} by Severity and Occurrence.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sotrovimab1_viz', 'Aggregated ${param.topic_title} by Severity and Occurrence.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sotrovimab1_viz', 'Aggregated ${param.topic_title} by Severity and Occurrence.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_sotrovimab1_viz" class="dash_viz"></div>
	</div>
</div>

<div class="row" id="viz2" style="display:none;">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} by Medication and Occurrence</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sotrovimab2_viz', '${param.topic_title} by Medication and Occurrence.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sotrovimab2_viz', '${param.topic_title} by Medication and Occurrence.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sotrovimab2_viz', '${param.topic_title} by Medication and Occurrence.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_sotrovimab2_viz" class="dash_viz"></div>
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
	console.log(viz);
	if (viz == "sotrovimab1"){
		$('#viz2').css('display', 'none');
		$('#viz1').css('display', 'block');
	};
	if (viz == "sotrovimab2"){
		$('#viz1').css('display', 'none');
		$('#viz2').css('display', 'block');
	};
});

function ${param.block}_sotrovimab1_refresh() {
	var properties = {
			domName: '${param.block}_sotrovimab1_viz',
			barLabelWidth: 120,
			legend_data: sotrovimaboccurrence_legend,
			secondary_range: categorical,
			legend_label: 'Sotrovimab Occurrence'
		}

	d3.select("#${param.block}_sotrovimab1_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_medsSeverityArray, properties);
	
}

${param.block}_sotrovimab1_refresh();

function ${param.block}_sotrovimab2_refresh() {
	var properties = {
			domName: '${param.block}_sotrovimab2_viz',
			barLabelWidth: 350,
			legend_data: sotrovimaboccurrence_legend,
			secondary_range: categorical,
			legend_label: 'Sotrovimab Occurrence',
			min_height: 800
		}

	d3.select("#${param.block}_sotrovimab2_viz").select("svg").remove();
	localHorizontalStackedBarChart(${param.block}_sotrovimabMedsArray, properties);
}

${param.block}_sotrovimab2_refresh();
</script>
