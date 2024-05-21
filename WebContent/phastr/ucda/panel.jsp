<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="dashboard" uri="http://icts.uiowa.edu/N3CDashboardTagLib"%>

<div class="row stats block2 mx-auto">
	<div class="col-12">
	
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="<util:applicationRoot/>/#dashboards">Dashboards</a></li>
				<li class="breadcrumb-item"><a href="<util:applicationRoot/>/phastr">PHASTR</a></li>
				<li class="breadcrumb-item active" >UDCA and COVID-19</li>
				<li id="topic_breadcrumb" class="breadcrumb-item active" aria-current="page"></li>
			</ol>
		</nav>
		<div class="row">
			<dashboard:dashboard did="930">
				<div class="col-12">
					<h1 class="page-title"><dashboard:dashboardTitle /></h1>
				</div>
				<div id="question-description" class="section-description heading-text text-max mx-auto">
					<dashboard:dashboardDescription />
				</div>
			</dashboard:dashboard>
		</div>
	</div>
</div>

<div id="d3viz">
	<div class="panel">	
		<div class="topic_dropdown" style="text-align:center; font-size: 1.3rem;">
			<h4 class="viz_color_header">Select a Topic to Explore:</h4>
			<select id="selectMe">
				<optgroup label="Odds and Hazard Ratios">
					<option value="ucda_1">Full Inpatient Cohort Mortality Risk</option>
					<option value="ucda_2">Sub-Cohort w/Moderate-to-Severe Liver Disease Mortality Risk</option>
				</optgroup>
				<optgroup label="Kaplan-Meier Survival">
					<option value="ucda_3">Full Inpatient Cohort Survival</option>
					<option value="ucda_4">Sub-Cohort w/Moderate-to-Severe Liver Disease Survival</option>
				</optgroup>
				<optgroup label="Balance of Treatment Groups After Weighting">
					<option value="ucda_5">Balance Tests</option>
					<option value="ucda_6">Proportions</option>
				</optgroup>
				<optgroup label="Kaplan-Meier Survival Weighted">
					<option value="ucda_7">Full Inpatient Cohort Weighted Survival</option>
					<option value="ucda_8">Sub-Cohort w/Moderate-to-Severe Liver Disease Weighted Survival</option>
				</optgroup>
			</select>
		</div>
	</div>
</div>

<div id="frame">
	<div id="ucda_1" class="group"></div>
	<div id="ucda_2" class="group"></div>
	<div id="ucda_3" class="group"></div>
	<div id="ucda_4" class="group"></div>
	<div id="ucda_5" class="group"></div>
	<div id="ucda_6" class="group"></div>
	<div id="ucda_7" class="group"></div>
	<div id="ucda_8" class="group"></div>
</div>

<script>

function url_map(selection) {
	return selection.substring(selection.lastIndexOf("_")+1);
}

function url_unmap(selector) {
	return 'ucda_'+selector;
}

var frame_crumbs = [];

<c:choose>
	<c:when test="${empty param.tertiary_tab || param.tertiary_tab == 'undefined'}">
		frame_load('ucda_1');
	</c:when>
	<c:otherwise>
		$('#selectMe').val(url_unmap('${param.tertiary_tab}'));
		frame_load(url_unmap('${param.tertiary_tab}'));
	</c:otherwise>
</c:choose>


function frame_load(selection) {
	var $this = $("#"+selection);

	if (!frame_crumbs.includes(selection)) {
		$this.load("<util:applicationRoot/>/phastr/ucda/"+selection+".jsp");
		frame_crumbs.push(selection);
	}
	if (typeof embedded_mode == 'undefined' || !embedded_mode)
		cache_browser_history("phastr", "phastr/ucda/"+url_map(selection));
};

$(document).ready(function () {
	$('#selectMe').select2({
		minimumResultsForSearch: Infinity
    });
    
	// set breadcrumb text to panel on intial load
    $('#topic_breadcrumb').html($("#selectMe :selected").text());
    
    $('#selectMe').change(function () {
		frame_load($(this).val());
		$('.group').hide();
	    $('#'+$(this).val()).show();
	    // set breadcrumb to be the selected value
	    $('#topic_breadcrumb').html($("option:selected", $(this)).text());
    }); 
});

</script>
