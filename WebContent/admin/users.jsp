<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<jsp:include page="../graph_support/graphic_save.jsp" />

<table class="table table-hover">
	<thead>
		<tr><th>Users</th><th>Count</th></tr>
	</thead>
	<sql:query var="duas" dataSource="jdbc/N3CPublic">
		select count(*) from n3c_admin.registration;
	</sql:query>
	<c:forEach items="${duas.rows}" var="row" varStatus="rowCounter">
		<tr><td>Total User Registrations</td><td align=right>${row.count}</td></tr>
	</c:forEach>
	<sql:query var="duas" dataSource="jdbc/N3CPublic">
		select count(*) from n3c_admin.registration where enclave;
	</sql:query>
	<c:forEach items="${duas.rows}" var="row" varStatus="rowCounter">
		<tr><td>Users Requesting Enclave Access</td><td align=right>${row.count}</td></tr>
	</c:forEach>
	<sql:query var="duas" dataSource="jdbc/N3CPublic">
		select count(*) from palantir.n3c_user;
	</sql:query>
	<c:forEach items="${duas.rows}" var="row" varStatus="rowCounter">
		<tr><td>Registered Enclave Users From DUA Institutions</td><td align=right>${row.count}</td></tr>
	</c:forEach>
</table>

<div class="btn-group float-right viz-demo">
	<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		<i class="fas fa-download"></i>
	</button>
	<div class="dropdown-menu dropdown-menu-right">
		<a class="dropdown-item" onclick="saveVisualization('registration_line', 'registration_timeline.jpg');">Save as JPG</a>
		<a class="dropdown-item" onclick="saveVisualization('registration_line', 'registration_timeline.png');">Save as PNG</a>
		<a class="dropdown-item" onclick="saveVisualization('registration_line', 'registration_timeline.svg');">Save as SVG</a>
	</div>
</div>
<div id="registration_line" class="panel-body">
	<c:import url="modules/line_registrations.jsp">
		<c:param name="data_page" value="/feeds/line_dua_dta_regs.jsp" />
		<c:param name="dom_element" value="#registration_line" />
	</c:import>
</div>
