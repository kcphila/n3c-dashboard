<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="analysis1-hazard" />
	<jsp:param name="block_header" value="Analysis 1 Hazard Ratio" />
	
	<jsp:param name="long_title" value="pasc-mortality/long_title/pasc_3.jsp" />
	<jsp:param name="short_desc" value="pasc-mortality/short_desc/pasc_3.jsp" />

	<jsp:param name="did" value="929" />
	
	<jsp:param name="viz_panel" value="analysis1-hazard-viz" />
	
	<jsp:param name="simple_panel" value="pasc-mortality/tables/analysis1_hazard.jsp" />
</jsp:include>

<script>

function analysis1_hazard_refresh() {
	var properties = {
		domName: "analysis1-hazard-viz",
		xaxis_label: "Log Hazard Ratio (HR) (95% CI)",
		bandLabelWidth: 405,
		minX: -0.2,
		maxX: 0.4,
		mode: "hazard",
		symbolSize: 5
	}
   	d3.select("#analysis1-hazard_plot").select("svg").remove();
	fetch('feeds/analysis1_hazard.jsp')
	  .then(response => response.json())
	  .then(data => OddsRatioChart(data.rows, properties));
}

analysis1_hazard_refresh();

</script>
