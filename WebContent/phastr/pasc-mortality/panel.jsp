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
					<li class="breadcrumb-item active" >PASC Mortality</li>
					<li id="topic_breadcrumb" class="breadcrumb-item active" aria-current="page"></li>
				</ol>
			</nav>
			<div class="row">
				<dashboard:dashboard did="929">
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
				<option value="pasc_1">Mortality Risk - Kaplan-Meier</option>
				<option value="pasc_2">Mortality Risk - Odds Ratio</option>
				<option value="pasc_3">Mortality Risk - Hazard Ratio</option>
				<option value="pasc_4">Mortality Risk - SHAP</option>
				<option value="pasc_5">Logistic Regression</option>
				<option value="pasc_6">Logistic Regression - SHAP</option>
				<option value="pasc_7">Combined ROC</option>
			</select>
		</div>
	</div>
	
	<div id="frame">
		<div id="pasc_1" class="group"></div>
		<div id="pasc_2" class="group"></div>
		<div id="pasc_3" class="group"></div>
		<div id="pasc_4" class="group"></div>
		<div id="pasc_5" class="group"></div>
		<div id="pasc_6" class="group"></div>
		<div id="pasc_7" class="group"></div>
	</div>
</div>

<script>

function url_map(selection) {
	return selection.substring(selection.lastIndexOf("_")+1);
}

function url_unmap(selector) {
	return 'pasc_'+selector;
}

var frame_crumbs = [];

<c:choose>
	<c:when test="${empty param.tertiary_tab || param.tertiary_tab == 'undefined'}">
		frame_load('pasc_1');
	</c:when>
	<c:otherwise>
		$('#selectMe').val(url_unmap('${param.tertiary_tab}'));
		frame_load(url_unmap('${param.tertiary_tab}'));
	</c:otherwise>
</c:choose>


function frame_load(selection) {
	var $this = $("#"+selection);

	if (!frame_crumbs.includes(selection)) {
		$this.load("<util:applicationRoot/>/phastr/pasc-mortality/"+selection+".jsp");
		frame_crumbs.push(selection);
	}
	if (typeof embedded_mode == 'undefined' || !embedded_mode)
		cache_browser_history("phastr", "phastr/pasc-mortality/"+url_map(selection));
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
