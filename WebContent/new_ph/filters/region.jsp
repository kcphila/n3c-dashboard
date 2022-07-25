<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<h6>Region</h6>
	<select id="${param.block}-region-select" multiple="multiple">
		<sql:query var="cases" dataSource="jdbc/N3CPublic">
			select distinct(division_name) as division from n3c_dashboard.state_map order by division_name;
		</sql:query>
		<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
			<option value="${row.division}">${row.division}</option>
		</c:forEach>
	</select>
</div>
