<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="analysis1-km" />
	<jsp:param name="block_header" value="Analysis 1 Kaplan-Meier" />
	
	<jsp:param name="long_title" value="pasc-mortality/long_title/pasc_1.jsp" />
	<jsp:param name="short_desc" value="pasc-mortality/short_desc/pasc_1.jsp" />

	<jsp:param name="did" value="929" />
	<jsp:param name="floating_legend" value="true" />
	<jsp:param name="viz_panel" value="analysis1-km-viz" />
	
	<jsp:param name="simple_panel" value="pasc-mortality/tables/analysis1_km.jsp" />
</jsp:include>

<script>

function analysis1_km_refresh() {
	var properties = {
		domName: "analysis1-km-viz",
		legend_labels: ['COVID-19 Negative Control','COVID-19 Positive Control','PASC'],
		xaxis_label: "Days",
		yaxis_label: "Survival Probability (Proportion Alive)",
		extendXAxis: 1,
		legendid: 'analysis1-kmlegend',
		legendlabel: 'Cohort',
		starty: 0.88,
		xtool: "Day"
	}
   	d3.select("#analysis1-km_plot").select("svg").remove();
	fetch('feeds/analysis1_km_d3.jsp')
	  .then(response => response.json())
	  .then(data => LineNConfidence(data, properties));
}

analysis1_km_refresh();

</script>
