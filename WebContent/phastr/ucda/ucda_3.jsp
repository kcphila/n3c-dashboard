<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="survival_inpatient" />
	<jsp:param name="block_header" value="Kaplan-Meier" />
	
	<jsp:param name="long_title" value="ucda/long_title/ucda_3.jsp" />
	<jsp:param name="short_desc" value="ucda/short_desc/ucda_3.jsp" />

	<jsp:param name="did" value="930" />
	<jsp:param name="floating_legend" value="true" />
	<jsp:param name="viz_panel" value="survival_inpatient-viz" />
	
	<jsp:param name="simple_panel" value="ucda/tables/survival_inpatient.jsp" />
</jsp:include>

<script>

function survival_inpatient_refresh() {
	var properties = {
		domName: "survival_inpatient-viz",
		legend_labels: ['UDCA','No UDCA'],
		xaxis_label: "Days",
		yaxis_label: "Survival Probability (Proportion Alive)",
		extendXAxis: 1,
		legendid: 'survival_inpatientlegend',
		legendlabel: 'Treatment Group',
		starty: 0.8,
		xtool: "Day"
	}
   	d3.select("#survival_inpatient_plot").select("svg").remove();
	fetch('feeds/survival_inpatient_d3.jsp')
	  .then(response => response.json())
	  .then(data => LineNConfidence(data, properties));
}

survival_inpatient_refresh();

</script>
