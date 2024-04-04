<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="analysis2-ors" />
	<jsp:param name="block_header" value="Analysis 2 Odds Ratio" />

	<jsp:param name="did" value="929" />
	
	<jsp:param name="viz_panel" value="analysis2-ors-viz" />
	
	<jsp:param name="simple_panel" value="pasc-mortality/tables/analysis2_ors.jsp" />
</jsp:include>

<script>

function analysis2_ors_refresh() {
	var properties = {
			domName: 'analysis2-ors-viz',
			block: '${param.block}',
			primary: 'term',
			secondary: 'cohort',
			estimate: 'estimate',
			xaxis_label: 'Odds Ratio',
			bandLabelWidth: 375,
			minX: 0.0,
			maxX: 8.5,
			mode: "odds",
			symbolSize: 4,
			legend_label: status_legend,
			colorscale: status_range,
			label1: 'Term',
			label2: 'Cohort',
			offset: 70,
			array: 'status',
			legendid: '${param.block}legend'
	};
   	d3.select("#analysis2-ors_plot").select("svg").remove();
	fetch('feeds/analysis2_ors.jsp')
	  .then(response => response.json())
	  .then(data => OddsRatioGroupedChart(data.rows, properties));
}

analysis2_ors_refresh();

</script>
