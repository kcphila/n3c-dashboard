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

<h4 class="nav-card">Publications</h4>
<div id="publications" />
<jsp:include page="tables/publications.jsp">
	<jsp:param name="feed" value="publications.jsp?ror=${param.ror}"/>
	<jsp:param name="target_div" value="publications"/>
	<jsp:param name="block" value="publications"/>
</jsp:include>
