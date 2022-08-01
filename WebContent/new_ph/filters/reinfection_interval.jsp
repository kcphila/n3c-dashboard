<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<h6>Days to Reinfection</h6>
	<select id="${param.block}-intervalbin-select" multiple="multiple">
		<sql:query var="cases" dataSource="jdbc/N3CPublic">
			select distinct
			((interval / 30) * 30)||' to '||((interval / 30 + 1) * 30) as interval_bin,
			interval / 30 as interval_bin_seq
	from (select
	 	distinct((subsequent_month||'/'||'01/'||subsequent_year)::date - (initial_month||'/'||'01/'||initial_year)::date) as interval
	 	from n3c_questions.all_tests_month_cohort
	) as bar order by interval_bin_seq
		</sql:query>
		<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
			<option value="${row.interval_bin}">${row.interval_bin}</option>
		</c:forEach>
	</select>
</div>
