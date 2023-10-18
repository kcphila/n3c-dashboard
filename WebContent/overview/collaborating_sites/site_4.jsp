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

<sql:query var="grants" dataSource="jdbc/N3CPublic">
	select count(*)
	from scholar_profile.citation where id in (select id from scholar_profile.authorship
												natural join scholar_profile.authorship_map as bar where ror_id = ?)
	<sql:param>${param.ror}</sql:param>
</sql:query>
<c:forEach items="${grants.rows}" var="row" varStatus="rowCounter">
	<c:set var="count" value="${row.count}"/>
</c:forEach>

<h4 class="nav-card">Publications</h4>
<c:choose>
	<c:when test="${count == 0 }">
		<p>No data</p>
	</c:when>
	<c:otherwise>
		<div id="publications" />
		<jsp:include page="tables/publications.jsp">
			<jsp:param name="feed" value="publications.jsp?ror=${param.ror}" />
			<jsp:param name="target_div" value="publications" />
			<jsp:param name="block" value="publications" />
		</jsp:include>
	</c:otherwise>
</c:choose>
