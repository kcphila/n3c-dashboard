<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="analysis1-shap" />
	<jsp:param name="block_header" value="Analysis 1 SHAP" />

	<jsp:param name="did" value="929" />
	
	<jsp:param name="viz_panel" value="analysis1-shap-viz" />
	
	<jsp:param name="simple_panel" value="pasc-mortality/tables/analysis1_shap.jsp" />
</jsp:include>

<script>

function analysis1_shap_refresh() {
	var properties = {
		domName: "#analysis1-shap-viz",
		bandLabelWidth: 425,
		xaxis_label: "SHAP Value",
		min_height: 300,
		ordered: 0,
		colorscale: age_range_ideal,
		legend_label: 'age',
		legend_data: age_legend_ideal
	}
   	d3.select("#analysis1-shap_plot").select("svg").remove();
	fetch('feeds/analysis1_shap.jsp')
	  .then(response => response.json())
	  .then(data => localHorizontalBarChart(data.rows, properties));
}

analysis1_shap_refresh();

</script>
