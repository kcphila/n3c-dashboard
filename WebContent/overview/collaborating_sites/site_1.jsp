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

<div class="row flex-wrap ">
	<jsp:include page="tiles/users.jsp">
		<jsp:param name="ror" value="${param.ror }"/>
	</jsp:include>
	<jsp:include page="tiles/institutions.jsp">
		<jsp:param name="ror" value="${param.ror }"/>
	</jsp:include>
	<jsp:include page="tiles/grants.jsp">
		<jsp:param name="ror" value="${param.ror }"/>
	</jsp:include>
</div>

<div class="row flex-wrap ">
	<jsp:include page="tiles/collaborations.jsp">
		<jsp:param name="ror" value="${param.ror }"/>
		<jsp:param name="name" value="${name}"/>
	</jsp:include>
	<jsp:include page="tiles/publications.jsp">
		<jsp:param name="ror" value="${param.ror }"/>
		<jsp:param name="name" value="${name}"/>
	</jsp:include>
</div>
