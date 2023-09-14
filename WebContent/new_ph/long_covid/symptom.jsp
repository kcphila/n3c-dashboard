<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="viz_options_dropdown">
	<span class="align-middle">Explore Topic By </span>
	<select id="${param.block}toggle_viz_select">
		<option value="age">Age</option>
		<option value="race">Race</option>
		<option value="sex">Sex</option>
		<option value="ethnicity">Ethnicity</option>
		<option hidden value="verylongtextverylongtext">verylongtextverylongtext</option>
	</select>
</div>

<div class="row" id="${param.block}viz1">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} and Age</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} and Age.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} and Age.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_age_viz', '${param.topic_title} and Age.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12 mb-4"> 
		<div id="${param.block}agelegend"></div>
	</div>
	<div class="col-12">
		<div id="${param.block}_age_viz" class="dash_viz clip"></div>
	</div>
</div>

<div class="row" id="${param.block}viz2" style="display:none;">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} and Race</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_race_viz', '${param.topic_title} and Race.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_race_viz', '${param.topic_title} and Race.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_race_viz', '${param.topic_title} and Race.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12 mb-4"> 
		<div id="${param.block}racelegend"></div>
	</div>
	<div class="col-12">
		<div id="${param.block}_race_viz" class="dash_viz clip"></div>
	</div>
</div>

<div class="row" id="${param.block}viz3" style="display:none;">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} and Sex</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} and Sex.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} and Sex.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_sex_viz', '${param.topic_title} and Sex.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12 mb-4"> 
		<div id="${param.block}sexlegend"></div>
	</div>
	<div class="col-12">
		<div id="${param.block}_sex_viz" class="dash_viz clip"></div>
	</div>
</div>

<div class="row" id="${param.block}viz4" style="display:none;">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title} and Ethnicity</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.topic_title} and Ethnicity.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.topic_title} and Ethnicity.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_ethnicity_viz', '${param.topic_title} and Ethnicity.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12 mb-4"> 
		<div id="${param.block}ethnicitylegend"></div>
	</div>
	<div class="col-12">
		<div id="${param.block}_ethnicity_viz" class="dash_viz clip"></div>
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
		$('#${param.block}viz3').css('display', 'none');
		$('#${param.block}viz4').css('display', 'none');
		$('#${param.block}viz1').css('display', 'block');
		${param.block}_age_refresh();
	};
	if (viz == "race"){
		$('#${param.block}viz1').css('display', 'none');
		$('#${param.block}viz3').css('display', 'none');
		$('#${param.block}viz4').css('display', 'none');
		$('#${param.block}viz2').css('display', 'block');
		${param.block}_race_refresh();
	};
	if (viz == "sex"){
		$('#${param.block}viz1').css('display', 'none');
		$('#${param.block}viz2').css('display', 'none');
		$('#${param.block}viz4').css('display', 'none');
		$('#${param.block}viz3').css('display', 'block');
		${param.block}_sex_refresh();
	};
	if (viz == "ethnicity"){
		$('#${param.block}viz1').css('display', 'none');
		$('#${param.block}viz2').css('display', 'none');
		$('#${param.block}viz3').css('display', 'none');
		$('#${param.block}viz4').css('display', 'block');
		${param.block}_ethnicity_refresh();
	};
});


var labeltest = '${param.labelwidth}';
var labelWidth = 150;

if (labeltest.length != 0){
	labelWidth = Number('${param.labelwidth}');
};

function ${param.block}_age_refresh() {
	var properties = {
			domName: '${param.block}_age_viz',
			barLabelWidth: labelWidth,
			legend_data: age_legend_4,
			secondary_range: age_range,
			legend_label: 'Age',
			ordered: 1,
			legendid: '${param.block}agelegend'
		}
   	d3.select("#${param.block}_age_viz").select("svg").remove();
	localHorizontalStackedBarChart_new(${param.block}_SymptomAgeArray, properties);	
}



function ${param.block}_race_refresh() {
	var properties = {
			domName: '${param.block}_race_viz',
			barLabelWidth: labelWidth,
			legend_data: race_legend,
			secondary_range: race_range,
			legend_label: 'Race',
			ordered: 1,
			legendid: '${param.block}racelegend'
		}
   	d3.select("#${param.block}_race_viz").select("svg").remove();
	localHorizontalStackedBarChart_new(${param.block}_SymptomRaceArray, properties);	
}



function ${param.block}_sex_refresh() {
	var properties = {
			domName: '${param.block}_sex_viz',
			barLabelWidth: labelWidth,
			legend_data: sex_legend,
			secondary_range: sex_range,
			legend_label: 'Sex',
			ordered: 1,
			legendid: '${param.block}sexlegend'
		}
   	d3.select("#${param.block}_sex_viz").select("svg").remove();
	localHorizontalStackedBarChart_new(${param.block}_SymptomSexArray, properties);	
}



function ${param.block}_ethnicity_refresh() {
	var properties = {
			domName: '${param.block}_ethnicity_viz',
			barLabelWidth: labelWidth,
			legend_data: ethnicity_legend,
			secondary_range: ethnicity_range,
			legend_label: 'Ethnicity',
			ordered: 1,
			legendid: '${param.block}ethnicitylegend'
		}
   	d3.select("#${param.block}_ethnicity_viz").select("svg").remove();
	localHorizontalStackedBarChart_new(${param.block}_SymptomEthnicityArray, properties);	
}


</script>
