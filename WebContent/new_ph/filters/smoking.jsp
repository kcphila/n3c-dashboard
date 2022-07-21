<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<h6>Smoking Status</h6>
	<select id="${param.block}-smokingstatus-select" multiple="multiple">
		<sql:query var="cases" dataSource="jdbc/N3CPublic">
			select smoking_status_abbrev, smoking_status_seq from n3c_dashboard.status_map order by smoking_status_seq;
		</sql:query>
		<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
			<option value="${row.smoking_status_abbrev}">${row.smoking_status_abbrev}</option>
		</c:forEach>
	</select>
</div>
