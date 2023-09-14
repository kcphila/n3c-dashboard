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
	
<!-- this for the individual symptom dropdowns where there is a second chart below -->
<c:if test="${not empty param.symptom}">
	<div class="row">
		<div class="col-12 viz-header-section">
			<h2 class="viz-title">${param.topic_title2}</h2>
			<div class="btn-group float-right">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('${param.block}-long-age', '${param.topic_title2}.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('${param.block}-long-age', '${param.topic_title2}.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('${param.block}-long-age', '${param.topic_title2}.svg')">Save as SVG</a>
				</div>
			</div>
		</div>
		<div class="col-12" id="${param.block}-long-age">
			<jsp:include page="../long_covid/long_before_static.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="type" value="age" />
				<jsp:param name="symptom" value="${param.symptom}" />
			</jsp:include>
		</div>
	</div>
</c:if>


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
			primary: 'status',
			secondary: 'long',
			count: 'patient_count',
			stack_group: 'age',
			xaxis_label: 'Age',
			legend_label: age_legend_min,
			colorscale: age_range_min,
			label1: 'COVID Status',
			label2: 'Long COVID Status',
			offset: 300,
			legendid: '${param.block}agelegend'
			
		}
   	d3.select("#${param.block}_age_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart_new(${param.block}_StatusAgeArray, properties);	
}

function ${param.block}_race_refresh() {
	var properties = {
			domName: '${param.block}_race_viz',
			primary: 'status',
			secondary: 'long',
			count: 'patient_count',
			stack_group: 'race',
			xaxis_label: 'Race',
			legend_label: race_legend,
			colorscale: race_range,
			label1: 'COVID Status',
			label2: 'Long COVID Status',
			offset: 300,
			legendid: '${param.block}racelegend'
		}
   	d3.select("#${param.block}_race_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart_new(${param.block}_StatusRaceArray, properties);
}

function ${param.block}_sex_refresh() {
	var properties = {
			domName: '${param.block}_sex_viz',
			primary: 'status',
			secondary: 'long',
			count: 'patient_count',
			stack_group: 'sex',
			xaxis_label: 'Sex',
			legend_label: sex_legend,
			colorscale: sex_range,
			label1: 'COVID Status',
			label2: 'Long COVID Status',
			offset: 300,
			legendid: '${param.block}sexlegend'
		}
   	d3.select("#${param.block}_sex_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart_new(${param.block}_StatusSexArray, properties);	
}

function ${param.block}_ethnicity_refresh() {
	var properties = {
			domName: '${param.block}_ethnicity_viz',
			primary: 'status',
			secondary: 'long',
			count: 'patient_count',
			stack_group: 'ethnicity',
			xaxis_label: 'Ethnicity',
			legend_label: ethnicity_legend,
			colorscale: ethnicity_range,
			label1: 'COVID Status',
			label2: 'Long COVID Status',
			offset: 300,
			legendid: '${param.block}ethnicitylegend'
		}
   	d3.select("#${param.block}_ethnicity_viz").select("svg").remove();
	localHorizontalGroupedStackedBarChart_new(${param.block}_StatusEthnicityArray, properties);
}



</script>
