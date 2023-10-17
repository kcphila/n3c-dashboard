<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<div class="col-6 card">
	<h4 class="nav-card">Sites Publishing with ${param.name}</h4>
	<div class="row flex-wrap ">
		<div class="col-3">
			<sql:query var="grants" dataSource="jdbc/N3CPublic">
				select count(distinct last_name||' '||first_name) from scholar_profile.authorship_map where ror_id = ?
				<sql:param>${param.ror}</sql:param>
			</sql:query>
			<c:forEach items="${grants.rows}" var="row" varStatus="rowCounter">
				<p>${row.count} Local Authors</p>
			</c:forEach>
			<sql:query var="grants" dataSource="jdbc/N3CPublic">
				select count(*)
				from scholar_profile.citation where id in (select id from scholar_profile.authorship
															natural join scholar_profile.authorship_map as bar where ror_id = ?)
				<sql:param>${param.ror}</sql:param>
			</sql:query>
			<c:forEach items="${grants.rows}" var="row" varStatus="rowCounter">
				<p>${row.count} Publications</p>
			</c:forEach>
			<sql:query var="grants" dataSource="jdbc/N3CPublic">
				select count(*) from scholar_profile.authorship natural join scholar_profile.authorship_map where ror_id = ?
				<sql:param>${param.ror}</sql:param>
			</sql:query>
			<c:forEach items="${grants.rows}" var="row" varStatus="rowCounter">
				<p>${row.count} Authorships</p>
			</c:forEach>
		</div>
		<div class="col-9">
			<jsp:include page="include_tile.jsp">
				<jsp:param name="ror" value="${param.ror}"/>
				<jsp:param name="type" value="publication_sites"/>
			</jsp:include>
		</div>
	</div>
</div>
