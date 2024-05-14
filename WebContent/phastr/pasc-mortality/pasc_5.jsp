<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="analysis2-ors" />
	<jsp:param name="block_header" value="Analysis 2 Odds Ratio" />
	
	<jsp:param name="long_title" value="pasc-mortality/long_title/pasc_5.jsp" />
	<jsp:param name="short_desc" value="pasc-mortality/short_desc/pasc_5.jsp" />

	<jsp:param name="did" value="929" />
	<jsp:param name="floating_legend" value="true" />
	<jsp:param name="viz_panel" value="analysis2-ors-viz" />
	
	<jsp:param name="simple_panel" value="pasc-mortality/tables/analysis2_ors.jsp" />
</jsp:include>

<script>

function analysis2_ors_refresh() {
	var properties = {
			domName: 'analysis2-ors-viz',
			block: 'analysis2-ors',
			primary: 'term',
			secondary: 'cohort',
			estimate: 'estimate',
			xaxis_label: 'Odds Ratio (OR)',
			bandLabelWidth: 325,
			minX: 0.0,
			maxX: 10.5,
			mode: "odds",
			symbolSize: 5,
			whiskerGap: 10,
			label1: 'Term',
			label2: 'Cohort',
			offset: 70,
			array: 'status',
			legendid: 'analysis2-orslegend',
			legendlabel: 'Cohort',
			legend_labels: ['Cohort A','Cohort B','Cohort C']
	};
   	d3.select("#analysis2-ors_plot").select("svg").remove();
	fetch('feeds/analysis2_ors.jsp')
	  .then(response => response.json())
	  .then(data => OddsRatioGroupedChart(data.rows, properties));
}

analysis2_ors_refresh();

</script>
