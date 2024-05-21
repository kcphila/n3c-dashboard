<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="odds" />
	<jsp:param name="block_header" value="Odds and Hazard Ratios" />
	
	<jsp:param name="long_title" value="ucda/long_title/ucda_1.jsp" />
	<jsp:param name="short_desc" value="ucda/short_desc/ucda_1.jsp" />

	<jsp:param name="did" value="930" />
	
	<jsp:param name="viz_panel" value="regression_inpatient-viz" />
	
	<jsp:param name="simple_panel" value="ucda/tables/regression_inpatient.jsp" />
</jsp:include>

<script>
function regression_inpatient_refresh() {
	var properties = {
		domName: "regression_inpatient-viz",
		xaxis_label: "Relative Risk (95% CI)",
		bandLabelWidth: 200,
		minX: 0.6,
		maxX: 6,
		mode: "odds",
		symbolSize: 6,
		height: 300,
		estimate_label: "Exp. Est."
	}
   	d3.select("#regression_inpatient_plot").select("svg").remove();
	fetch('feeds/regression_inpatient.jsp')
	  .then(response => response.json())
	  .then(data => OddsRatioChart(data.rows, properties));
}

regression_inpatient_refresh();
</script>