<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../../graph_support/grouped_stacked_bar_horizontal_alexis_local.jsp"/>
<jsp:include page="../../graph_support/horizontalBarChart_local.jsp"/>

<div class="topic_dropdown" style="text-align:center; font-size: 1.5rem;">
	<h4 class="viz_color_header">Select a Topic to Explore:</h4>
	<select id="selectMe">
		<option value="diabetes_1">Diabetes Mellitus Type 2</option>
		<option value="diabetes_2">Diabetes Mellitus Type 1</option>
		<option value="diabetes_3">Type 1 Under the Age of 18</option>
		<option value="diabetes_4">Type 2 Under the Age of 18</option>
		<option value="diabetes_5">Type 1 Over the Age of 18</option>
		<option value="diabetes_6">Type 2 Over the Age of 18</option>
	</select>
</div>
<div id="frame">
	<div id="diabetes_1" class="group"></div>
	<div id="diabetes_2" class="group"></div>
	<div id="diabetes_3" class="group"></div>
	<div id="diabetes_4" class="group"></div>
	<div id="diabetes_5" class="group"></div>
	<div id="diabetes_6" class="group"></div>
</div>

<script>

function url_map(selection) {
	return selection.substring(selection.lastIndexOf("_")+1);
}

function url_unmap(selector) {
	return 'diabetes_'+selector;
}

var frame_crumbs = [];

<c:choose>
	<c:when test="${empty param.tertiary_tab || param.tertiary_tab == 'undefined'}">
		frame_load('diabetes_1');
	</c:when>
	<c:otherwise>
		$('#selectMe').val(url_unmap('${param.tertiary_tab}'));
		frame_load(url_unmap('${param.tertiary_tab}'));
	</c:otherwise>
</c:choose>

function frame_load(selection) {
	var $this = $("#"+selection);

	if (!frame_crumbs.includes(selection)) {
		$this.load("<util:applicationRoot/>/new_ph/diabetes/"+selection+".jsp");
		frame_crumbs.push(selection);
	}
	if (typeof embedded_mode == 'undefined' || !embedded_mode)
		cache_browser_history("public-health", "public-health/diabetes-mellitus/"+url_map(selection));
};

$(document).ready(function() {
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
