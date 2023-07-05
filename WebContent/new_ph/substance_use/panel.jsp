<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
#d3viz .dataTables_filter{
    display: none;
}
</style>

<script>
	<jsp:include page="../../feeds/configuration.jsp"/>
	
	<sql:query var="covid" dataSource="jdbc/N3CPublic">
		select jsonb_pretty(jsonb_agg(done order by secondary_seq))
		from (select alcohol_condition as secondary, alcohol_condition as secondary_abbrev, row_number() OVER (ORDER BY alcohol_condition) AS secondary_seq
			  from (select distinct alcohol_condition from n3c_dashboard_ph.sub_covalcdemoageideal_csd) as foo
			  ) as done;
	</sql:query>
	<c:forEach items="${covid.rows}" var="row" varStatus="rowCounter">
		var alcohol_legend = ${row.jsonb_pretty};
	</c:forEach>
	
	<sql:query var="covid" dataSource="jdbc/N3CPublic">
		select jsonb_pretty(jsonb_agg(done order by secondary_seq))
		from (select opioids as secondary, opioids as secondary_abbrev, row_number() OVER (ORDER BY opioids) AS secondary_seq
			  from (select distinct opioids from n3c_dashboard_ph.sub_covopidemoageideal_csd) as foo
			  ) as done;
	</sql:query>
	<c:forEach items="${covid.rows}" var="row" varStatus="rowCounter">
		var opioid_legend = ${row.jsonb_pretty};
	</c:forEach>
</script>

<jsp:include page="../../graph_support/percentage_bar_local_new.jsp"/>
<jsp:include page="../../graph_support/pieChart_local_new.jsp"/>
<jsp:include page="../../graph_support/horizontalBarChart_local_new.jsp"/>
<jsp:include page="../../graph_support/heatMap_local.jsp"/>

<div class="topic_dropdown" style="text-align:center; font-size: 1.3rem;">
	<h4 class="viz_color_header">Select a Topic to Explore:</h4>
	<select id="selectMe">
		<option value="substance_use_1">Alcohol Demographics</option>
		<option value="substance_use_2">Opioids Demographics</option>
		<option value="substance_use_3">Smoking Demographics</option>		
		<option value="substance_use_4">Alcohol/Opioid Heatmap</option>		
		<option value="substance_use_6">Opioid/Smoking Heatmap</option>		
	</select>
</div>
<div id="frame">
	<div id="substance_use_1" class="group"></div>
	<div id="substance_use_2" class="group"></div>
	<div id="substance_use_3" class="group"></div>
	<div id="substance_use_4" class="group"></div>
	<div id="substance_use_6" class="group"></div>
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
		frame_load('substance_use_1');
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

	    // this resets the datatable after selecting a new panel to display b/c graph resets
	    var val = $(this).val();
	    try {
	    	eval(val + "_constraint(null, null)");
	    } catch (e) {
	    	
	    };

    }); 
});

</script>