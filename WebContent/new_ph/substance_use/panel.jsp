<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
.background {
  fill: #eee;
}
line {
  stroke: #fff;
}
text.active {
  fill: red;
}
</style>

<jsp:include page="../../graph_support/percentage_bar_local_new.jsp"/>
<jsp:include page="../../graph_support/pieChart_local_new.jsp"/>
<jsp:include page="../../graph_support/horizontalBarChart_local_new.jsp"/>
<jsp:include page="../../graph_support/horizontalStackedBarChart_local_new.jsp"/>

<div class="topic_dropdown" style="text-align:center; font-size: 1.3rem;">
	<h4 class="viz_color_header">Select a Topic to Explore:</h4>
	<select id="selectMe">
		<optgroup label="Demographics">
			<option value="substance_use_7">All Demographics (Alcohol/Opioids/Smoking/Cannabis)</option>
			<option value="substance_use_1">COVID+ Alcohol-Related Condition Demographics</option>
			<option value="substance_use_2">COVID+ Opioids Demographics</option>
			<option value="substance_use_3">COVID+ Smoking Demographics</option>
		</optgroup>
		<optgroup label="Cohort Clusters">
			<option value="substance_use_4">Alcohol & Opioid Heatmap</option>		
			<option value="substance_use_5">Alcohol & Smoking Heatmap</option>		
			<option value="substance_use_6">Opioid & Smoking Heatmap</option>	
		</optgroup>
		<option value="substance_use_8">Anti-Opioid Interventions</option>	
		<option value="substance_use_9">Geospatial - Patient Count by County</option>	
	</select>
</div>

<div id="frame">
	<div id="substance_use_1" class="group"></div>
	<div id="substance_use_2" class="group"></div>
	<div id="substance_use_3" class="group"></div>
	<div id="substance_use_4" class="group"></div>
	<div id="substance_use_5" class="group"></div>
	<div id="substance_use_6" class="group"></div>
	<div id="substance_use_7" class="group"></div>
	<div id="substance_use_8" class="group"></div>
	<div id="substance_use_9" class="group"></div>
</div>

<script>

function url_map(selection) {
	return selection.substring(selection.lastIndexOf("_")+1);
}

function url_unmap(selector) {
	return 'substance_use_'+selector;
}

var frame_crumbs = '';

<c:choose>
	<c:when test="${empty param.tertiary_tab || param.tertiary_tab == 'undefined'}">
		frame_load('substance_use_7');
	</c:when>
	<c:otherwise>
		$('#selectMe').val(url_unmap('${param.tertiary_tab}'));
		frame_load(url_unmap('${param.tertiary_tab}'));
	</c:otherwise>
</c:choose>

function frame_load(selection) {
	var $this = $("#"+selection);

	if (!frame_crumbs.includes(selection)) {
		$this.load("<util:applicationRoot/>/new_ph/substance_use/"+selection+".jsp?did=${param.did}");
		frame_crumbs = frame_crumbs + selection;
	}
	if (typeof embedded_mode == 'undefined' || !embedded_mode)
		cache_browser_history("public-health", "public-health/substance-use/"+url_map(selection));
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

$(document).ready(function () {
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

	    // this resets the datatable after selecting a new panel to display b/c graph resets
	    var val = $(this).val();
	    try {
	    	eval(val + "_constraint(null, null)");
	    } catch (e) {
	    	
	    };

    }); 
});

</script>