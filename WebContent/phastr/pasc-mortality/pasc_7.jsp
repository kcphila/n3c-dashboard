<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="combined-roc" />
	<jsp:param name="block_header" value="Combined ROC" />
	
	<jsp:param name="long_title" value="pasc-mortality/long_title/pasc_7.jsp" />
	<jsp:param name="short_desc" value="pasc-mortality/short_desc/pasc_7.jsp" />

	<jsp:param name="did" value="929" />
	<jsp:param name="floating_legend" value="true" />
	<jsp:param name="viz_panel" value="combined-roc-viz" />
	
	<jsp:param name="simple_panel" value="pasc-mortality/tables/combined_roc.jsp" />
</jsp:include>



<script>

<sql:query var="roc" dataSource="jdbc/N3CPublic">
	select CONCAT((CASE
    		WHEN cohort = 'COHORT A' THEN 'Cohort A'
    		WHEN cohort = 'COHORT B' THEN 'Cohort B'
    		WHEN cohort = 'COHORT C' THEN 'Cohort C'
    		ELSE cohort
    	END), ' (AUC: ' , ROUND(max(auc)::decimal,4), ')' )
  	from phastr_pasc.combined_cohort_roc
  	group by distinct(CASE
    		WHEN cohort = 'COHORT A' THEN 'Cohort A'
    		WHEN cohort = 'COHORT B' THEN 'Cohort B'
    		WHEN cohort = 'COHORT C' THEN 'Cohort C'
    		ELSE cohort
    	END) order by 1;
</sql:query>

var legendvalues = []

<c:forEach items="${roc.rows}" var="row" varStatus="rowCounter">
	legendvalues.push('${row.concat}');
</c:forEach>

function combined_roc_refresh() {
	var properties = {
		domName: "combined-roc-viz",
		legend_labels: ['Cohort A', 'Cohort B', 'Cohort C'],
		xaxis_label: "False Positive Rate",
		yaxis_label: "True Positive Rate",
		extendXAxis: 1,
		legendid: 'combined-roclegend',
		legendlabel: 'Cohort',
		starty: 0.0,
		xtool: "FP Rate",
		legend_labels2: legendvalues
	}
   	d3.select("#combined_roc_plot").select("svg").remove();
	fetch('feeds/combined_rocd3.jsp')
	  .then(response => response.json())
	  .then(data => LineNConfidence(data, properties));
}

combined_roc_refresh();

</script>