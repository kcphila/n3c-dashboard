<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<div class="topic_dropdown" style="text-align:center; font-size: 1.3rem;">
	<h4 class="viz_color_header">Select a Perspective:</h4>
	<select id="selectMe">
		<option value="ucda_1">Odds and Hazard Ratios</option>
		<option value="ucda_2">Odds and Hazard Ratios - Subcohort</option>
		<option value="ucda_3">Kaplan-Meier Survival</option>
		<option value="ucda_4">Kaplan-Meier Survival - Subcohort</option>
		<option value="ucda_5">Balance Tests</option>
		<option value="ucda_6">Proportions</option>
		<option value="ucda_7">Kaplan-Meier Survival Weighted</option>
		<option value="ucda_8">Kaplan-Meier Survival Weighted - Subcohort</option>
	</select>
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