<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<div class="col-3 card">
	<h4 class="nav-card">Users</h4>
	<sql:query var="users" dataSource="jdbc/N3CPublic">
		select count(*) from n3c_admin.gsuite_view where ror_id = ? and enclave='TRUE'
		<sql:param>${param.ror}</sql:param>
	</sql:query>
	<c:forEach items="${users.rows}" var="row" varStatus="rowCounter">
		<p>${row.count} N3C Enclave Users</p>
	</c:forEach>
	<sql:query var="users" dataSource="jdbc/N3CPublic">
		select count(*) from n3c_admin.gsuite_view where ror_id = ? and enclave='FALSE'
		<sql:param>${param.ror}</sql:param>
	</sql:query>
	<c:forEach items="${users.rows}" var="row" varStatus="rowCounter">
		<p>${row.count} Additional N3C Members</p>
	</c:forEach>
</div>
