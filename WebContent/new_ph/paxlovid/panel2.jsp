<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<style>
	#paxlovid .dataTables_filter{
		display: unset;
	}
	
	.select2-container--default .select2-results__option--disabled{
		display:none;
	}
</style>

<jsp:include page="../../graph_support/grouped_bar_horizontal_local_new.jsp"/>
<jsp:include page="../../graph_support/horizontalBarChart_local_new.jsp"/>
<jsp:include page="../../graph_support/horizontalStackedBarChart_local.jsp"/>

<div class="topic_dropdown" style="text-align:center; font-size: 1.3rem;">
	<h4 class="viz_color_header">Select a Topic to Explore:</h4>
	<select id="selectMe">
		<optgroup label="Overview">
			<option value="paxlovid_4">Demographics</option>
			<option value="paxlovid_9">Days Between COVID+ and Prescription</option>
		</optgroup>
		<optgroup label=" Pre-COVID Factors">
			<option value="paxlovid_5"># of Vaccinations Before COVID+</option>
			<option value="paxlovid_6">Pre-COVID Dr. Visits</option>
			<option value="paxlovid_7">Charlson Comorbidity Index (CCI)</option>
		</optgroup>
		<optgroup label=" Post-COVID Factors">
			<option value="paxlovid_10">Post-COVID Dr. Visits</option>
			<option value="paxlovid_11"># Days Between COVID+ and Hospitalization</option>
		</optgroup>
		<optgroup label="Static Data">
			<option value="paxlovid_8">Paxlovid Outcomes (Extract)</option>
			<option value="paxlovid_1">Related Conditions (Extract: July 22, 2022)</option>
			<option value="paxlovid_2">Related Medications (Extract: July 22, 2022)</option>
			<option value="paxlovid_3">Visits (Extract: July 22, 2022)</option>
		</optgroup>
	</select>
</div>
	
<div id="paxlovid">
	<div id="frame">
		<div id="paxlovid_1" class="group"></div>
		<div id="paxlovid_2" class="group"></div>
		<div id="paxlovid_3" class="group"></div>
		<div id="paxlovid_4" class="group"></div>
		<div id="paxlovid_5" class="group"></div>
		<div id="paxlovid_6" class="group"></div>
		<div id="paxlovid_7" class="group"></div>
		<div id="paxlovid_8" class="group"></div>
		<div id="paxlovid_9" class="group"></div>
		<div id="paxlovid_10" class="group"></div>
		<div id="paxlovid_11" class="group"></div>
	</div>
</div>
<script>

function url_map(selection) {
	return selection.substring(selection.lastIndexOf("_")+1);
}

function url_unmap(selector) {
	return 'paxlovid_'+selector;
}

var frame_crumbs = [];

<c:choose>
	<c:when test="${empty param.tertiary_tab || param.tertiary_tab == 'undefined'}">
		frame_load('paxlovid_4');
	</c:when>
	<c:otherwise>
		$('#selectMe').val(url_unmap('${param.tertiary_tab}'));
		frame_load(url_unmap('${param.tertiary_tab}'));
	</c:otherwise>
</c:choose>

function frame_load(selection) {
	var $this = $("#"+selection);

	if (!frame_crumbs.includes(selection)) {
		$this.load("<util:applicationRoot/>/new_ph/paxlovid/"+selection+".jsp");
		frame_crumbs.push(selection);
	}
	if (typeof embedded_mode == 'undefined' || !embedded_mode)
		cache_browser_history("public-health", "public-health/Paxlovid/"+url_map(selection));
};
	
function modelMatcher (params, data) {
	  data.parentText = data.parentText || "";

	  // Always return the object if there is nothing to compare
	  if ($.trim(params.term) === '') {
	    return data;
	  }

	  // Do a recursive check for options with children
	  if (data.children && data.children.length > 0) {
	    // Clone the data object if there are children
	    // This is required as we modify the object to remove any non-matches
	    var match = $.extend(true, {}, data);

	    // Check each child of the option
	    for (var c = data.children.length - 1; c >= 0; c--) {
	      var child = data.children[c];
	      child.parentText += data.parentText + " " + data.text;

	      var matches = modelMatcher(params, child);

	      // If there wasn't a match, remove the object in the array
	      if (matches == null) {
	        match.children.splice(c, 1);
	      }
	    }

	    // If any children matched, return the new object
	    if (match.children.length > 0) {
	      return match;
	    }

	    // If there were no matching children, check just the plain object
	    return modelMatcher(params, match);
	  }

	  // If the typed-in term matches the text of this term, or the text from any
	  // parent term, then it's a match.
	  var original = (data.parentText + ' ' + data.text).toUpperCase();
	  var term = params.term.toUpperCase();


	  // Check if the text contains the term
	  if (original.indexOf(term) > -1) {
	    return data;
	  }

	  // If it doesn't contain the term, don't return anything
	  return null;
}

$(document).ready(function() {
	$('#selectMe').select2({
		matcher: modelMatcher,
		searchInputPlaceholder: 'Search Topics...'
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
