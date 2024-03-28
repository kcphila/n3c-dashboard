<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="analysis1-or" />
	<jsp:param name="block_header" value="Analysis 1 Odds Ratio" />

	<jsp:param name="did" value="929" />
	
	<jsp:param name="viz_panel" value="analysis1-or-viz" />
	
	<jsp:param name="simple_panel" value="pasc-mortality/tables/analysis1_or.jsp" />
</jsp:include>

<script>

function analysis1_or_refresh() {
	var properties = {
		domName: "analysis1-or-viz",
		xaxis_label: "Odds Ratio",
		bandLabelWidth: 375,
		symbolSize: 4
	}
   	d3.select("#analysis1-or_plot").select("svg").remove();
	fetch('feeds/analysis1_or.jsp')
	  .then(response => response.json())
	  .then(data => OddsRatioChart(data.rows, properties));
}

analysis1_or_refresh();

</script>
