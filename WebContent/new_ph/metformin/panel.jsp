<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../../graph_support/percentage_bar_local_new.jsp"/>
<jsp:include page="../../graph_support/pieChart_local_new.jsp"/>
<jsp:include page="../../graph_support/horizontalBarChart_local_new.jsp"/>

<div class="topic_dropdown" style="text-align:center; font-size: 1.3rem;">
	<h4 class="viz_color_header">Select a Topic to Explore:</h4>
	<select id="selectMe">
		<optgroup label="All N3C Patients">
			<option value="metformin_1">Demographics of Metformin Patients</option>
			<option value="metformin_2">Metformin vs. Non-Metformin Severity (All Patients)</option>
			<option value="metformin_3">Metformin vs. Non-Metformin Long COVID (All Patients)</option>
			<option value="metformin_4">Metformin vs. Non-Metformin Mortality (All Patients)</option>
		</optgroup>
		<optgroup label="All Diabetic Patients">
			<option value="metformin_5">Demographics of Diabetic Metformin Patients</option>
			<option value="metformin_6">Metformin vs. Non-Metformin Severity (Diabetic Patients)</option>
			<option value="metformin_7">Metformin vs. Non-Metformin Long COVID (Diabetic Patients)</option>
			<option value="metformin_8">Metformin vs. Non-Metformin Mortality (Diabetic Patients)</option>
		</optgroup>
	</select>
</div>

<div id="frame">
	<div id="metformin_1" class="group"></div>
	<div id="metformin_2" class="group"></div>
	<div id="metformin_3" class="group"></div>
	<div id="metformin_4" class="group"></div>
	<div id="metformin_5" class="group"></div>
	<div id="metformin_6" class="group"></div>
	<div id="metformin_7" class="group"></div>
	<div id="metformin_8" class="group"></div>
</div>

<script>

function url_map(selection) {
	return selection.substring(selection.lastIndexOf("_")+1);
}

function url_unmap(selector) {
	return 'metformin_'+selector;
}

var frame_crumbs = [];

<c:choose>
	<c:when test="${empty param.tertiary_tab || param.tertiary_tab == 'undefined'}">
		frame_load('metformin_1');
	</c:when>
	<c:otherwise>
		$('#selectMe').val(url_unmap('${param.tertiary_tab}'));
		frame_load(url_unmap('${param.tertiary_tab}'));
	</c:otherwise>
</c:choose>


function frame_load(selection) {
	var $this = $("#"+selection);

	if (!frame_crumbs.includes(selection)) {
		$this.load("<util:applicationRoot/>/new_ph/metformin/"+selection+".jsp?did=${param.did}");
		frame_crumbs.push(selection);
	}
	if (typeof embedded_mode == 'undefined' || !embedded_mode)
		cache_browser_history("public-health", "public-health/metformin/"+url_map(selection));
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
