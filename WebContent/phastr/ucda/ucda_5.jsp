<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="balance" />
	<jsp:param name="block_header" value="Balance Tests" />
	
	<jsp:param name="long_title" value="ucda/long_title/ucda_5.jsp" />
	<jsp:param name="short_desc" value="ucda/short_desc/ucda_5.jsp" />

	<jsp:param name="did" value="930" />
	<jsp:param name="floating_legend" value="true" />
	<jsp:param name="viz_panel" value="balance-viz" />
	
	<jsp:param name="simple_panel" value="ucda/tables/balance.jsp" />
</jsp:include>

<script>

function balance_refresh() {
	var properties = {
			domName: 'balance-viz',
			block: 'balance',
			primary: 'variable',
			secondary: 'sample',
			estimate: 'smd',
			xaxis_label: 'Absolute Standardized Mean Difference',
			bandLabelWidth: 200,
			barHeight: 15,
			barPadding: 3,
			minX: 0,
			maxX: 1.3,
			mode: "hazard",
			symbolSize: 4,
			colorscale: two_range,
			label1: 'Term',
			label2: 'Sample',
			offset: 70,
			dash: 0.1,
			array: 'status',
			legendid: 'balancelegend',
			legendlabel: 'Sample',
			legend_labels: ['Before Weighting','After Weighting'],
			xtoollabel: 'ASMD'
	};
   	d3.select("#balance_plot").select("svg").remove();
	fetch('feeds/balance.jsp')
	  .then(response => response.json())
	  .then(data => localHorizontalGroupedBarChart(data.rows, properties));
}

balance_refresh();

</script>