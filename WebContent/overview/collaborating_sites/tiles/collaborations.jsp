<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<div class="col-6 card">
	<h4 class="nav-card">Sites Collaborating with ${param.name}</h4>
	<div class="row flex-wrap ">
		<div class="col-3">
			<sql:query var="grants" dataSource="jdbc/N3CPublic">
				select investigator_count from n3c_collaboration.organization_organization where ror_id = ?
				<sql:param>${param.ror}</sql:param>
			</sql:query>
			<c:forEach items="${grants.rows}" var="row" varStatus="rowCounter">
				<p>${row.investigator_count} Local Investigators</p>
			</c:forEach>
			<sql:query var="grants" dataSource="jdbc/N3CPublic">
				select membership_count from n3c_collaboration.organization_organization where ror_id = ?
				<sql:param>${param.ror}</sql:param>
			</sql:query>
			<c:forEach items="${grants.rows}" var="row" varStatus="rowCounter">
				<p>${row.membership_count} Project Memberships</p>
			</c:forEach>
			<sql:query var="grants" dataSource="jdbc/N3CPublic">
				select project_count from n3c_collaboration.organization_organization where ror_id = ?
				<sql:param>${param.ror}</sql:param>
			</sql:query>
			<c:forEach items="${grants.rows}" var="row" varStatus="rowCounter">
				<p>${row.project_count} Enclave Projects</p>
			</c:forEach>
		</div>
		<div class="col-9">
			<img alt="testing" style="width: 100%; object-fit: contain" src="/n3c-dashboard/overview/collaborating_sites/tiles/projects.png">
		</div>
	</div>
</div>
