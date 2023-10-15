<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<div class="col-3 card">
	<h4 class="nav-card">Grants Mentioning N3C</h4>
	<sql:query var="grants" dataSource="jdbc/N3CPublic">
		select count(*),sum(award_amount)
		from nih_exporter_current.ror_binding natural join nih_exporter_current.n3c
		where ror_id = ?
		<sql:param>${param.ror}</sql:param>
	</sql:query>
	<c:forEach items="${grants.rows}" var="row" varStatus="rowCounter">
		<p>${row.count} awards, ${row.sum} total amount</p>
	</c:forEach>
	<sql:query var="grants" dataSource="jdbc/N3CPublic">
		select count(*) from n3c_collaboration.subcontracts where subaward_ror = ?
		<sql:param>${param.ror}</sql:param>
	</sql:query>
	<c:forEach items="${grants.rows}" var="row" varStatus="rowCounter">
		<p>${row.count} subcontracts</p>
	</c:forEach>
</div>
