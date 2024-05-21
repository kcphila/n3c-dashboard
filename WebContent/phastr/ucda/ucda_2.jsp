<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="odds-subcohort" />
	<jsp:param name="block_header" value="Odds and Hazard Ratios Subcohort" />
	
	<jsp:param name="long_title" value="ucda/long_title/ucda_2.jsp" />
	<jsp:param name="short_desc" value="ucda/short_desc/ucda_2.jsp" />

	<jsp:param name="did" value="930" />
	
	<jsp:param name="viz_panel" value="regression_liver-viz" />
	
	<jsp:param name="simple_panel" value="ucda/tables/regression_liver.jsp" />
</jsp:include>

<script>
function regression_liver_refresh() {
	var properties = {
		domName: "regression_liver-viz",
		xaxis_label: "Relative Risk (95% CI)",
		bandLabelWidth: 200,
		minX: 0,
		maxX: 3,
		mode: "odds",
		symbolSize: 6,
		height: 300,
		estimate_label: "Exp. Est."
	}
   	d3.select("#regression_liver_plot").select("svg").remove();
	fetch('feeds/regression_liver.jsp')
	  .then(response => response.json())
	  .then(data => OddsRatioChart(data.rows, properties));
}

regression_liver_refresh();
</script>