<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="balance-proportion" />
	<jsp:param name="block_header" value="Proportions" />
	
	<jsp:param name="long_title" value="ucda/long_title/ucda_6.jsp" />
	<jsp:param name="short_desc" value="ucda/short_desc/ucda_6.jsp" />
	
	<jsp:param name="did" value="930" />
	<jsp:param name="floating_legend" value="true" />
	<jsp:param name="viz_panel" value="balance_proportion-viz" />
	
	<jsp:param name="simple_panel" value="ucda/tables/balance_proportion.jsp" />
</jsp:include>

<script>

function balance_proportion_refresh() {
	var properties = {
			domName: 'balance_proportion-viz',
			block: 'balance_proportion',
			primary: 'variable',
			secondary: 'before_after_weighting',
			count: 'proportion',
			stack_group: 'treatment',
			xaxis_label: 'Proportion',
			legend_label: ['UDCA', 'No UDCA'],
			stack_order: ['Before','After'],
			colorscale: categorical8,
			label1: 'Variable',
			label2: 'Weighting',
			offset: 260,
			legendid: 'balance-proportionlegend',
			legendlabel: 'Treatment'
	};
   	d3.select("#balance_proportion_plot").select("svg").remove();
	fetch('feeds/balance_proportion.jsp')
	  .then(response => response.json())
	  .then(data => grouped_stacked_bar_horizontal(data.rows, properties));
}

balance_proportion_refresh();

</script>