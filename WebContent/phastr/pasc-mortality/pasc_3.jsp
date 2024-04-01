<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="analysis1-hazard" />
	<jsp:param name="block_header" value="Analysis 1 Hazard Ratio" />

	<jsp:param name="did" value="929" />
	
	<jsp:param name="viz_panel" value="analysis1-hazard-viz" />
	
	<jsp:param name="simple_panel" value="pasc-mortality/tables/analysis1_hazard.jsp" />
</jsp:include>

<script>

function analysis1_hazard_refresh() {
	var properties = {
		domName: "analysis1-hazard-viz",
		xaxis_label: "Hazard Ratio",
		bandLabelWidth: 375,
		minX: -0.2,
		maxX: 0.4,
		mode: "hazard",
		symbolSize: 4
	}
   	d3.select("#analysis1-hazard_plot").select("svg").remove();
	fetch('feeds/analysis1_hazard.jsp')
	  .then(response => response.json())
	  .then(data => OddsRatioChart(data.rows, properties));
}

analysis1_hazard_refresh();

</script>
