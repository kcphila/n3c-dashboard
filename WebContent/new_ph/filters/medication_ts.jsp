<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<h6>Medications</h6>
	<select id="${param.block}-medications-select" multiple="multiple">
		<sql:query var="cases" dataSource="jdbc/N3CPublic">
			select distinct drug_name as medication from n3c_questions_new.drug_monthly_count_summary
			order by 1;
		</sql:query>
		<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
			<option value="${row.medication}">${row.medication}</option>
		</c:forEach>
	</select>
</div>
