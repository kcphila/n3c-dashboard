<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="master" dataSource="jdbc/N3CPublic">
	select institutionname from n3c_admin.dua_master where institutionid = ?
	<sql:param>${param.ror}</sql:param>
</sql:query>
<c:forEach items="${master.rows}" var="row" varStatus="rowCounter">
	<h1>${row.institutionname}</h1>
	<c:set var="name" value="${row.institutionname}"/>
</c:forEach>

<div id="grants-wrapper">
	<h4 class="nav-card">Grants</h4>
	<div id="grants"></div>
	<jsp:include page="tables/grants.jsp">
		<jsp:param name="feed" value="grants.jsp?ror=${param.ror}"/>
		<jsp:param name="target_div" value="grants"/>
		<jsp:param name="block" value="grants"/>
	</jsp:include>
</div>

<div id="subcontracts-wrapper">
	<h4 class="nav-card">Subcontracts</h4>
	<div id="subcontracts"></div>
	<jsp:include page="tables/subcontracts.jsp">
		<jsp:param name="feed" value="subcontracts.jsp?ror=${param.ror}"/>
		<jsp:param name="target_div" value="subcontracts"/>
		<jsp:param name="block" value="subcontracts"/>
	</jsp:include>
</div>
