<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="analysis1-or" />
	<jsp:param name="block_header" value="Analysis 1 Odds Ratio" />
	
	<jsp:param name="long_title" value="pasc-mortality/long_title/pasc_2.jsp" />
	<jsp:param name="short_desc" value="pasc-mortality/short_desc/pasc_2.jsp" />
	
	<jsp:param name="did" value="929" />
	
	<jsp:param name="viz_panel" value="analysis1-or-viz" />
	
	<jsp:param name="simple_panel" value="pasc-mortality/tables/analysis1_or.jsp" />
</jsp:include>

<script>

function analysis1_or_refresh() {
	var properties = {
		domName: "analysis1-or-viz",
		xaxis_label: "Odds Ratio (OR) (95% CI)",
		bandLabelWidth: 405,
		minX: 0.8,
		maxX: 1.5,
		mode: "odds",
		symbolSize: 6,
		height: 300,
		estimate_label: "OR"
	}
   	d3.select("#analysis1-or_plot").select("svg").remove();
	fetch('feeds/analysis1_or.jsp')
	  .then(response => response.json())
	  .then(data => OddsRatioChart(data.rows, properties));
}

analysis1_or_refresh();

</script>
