<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<div class="col-6 card">
	<h4 class="nav-card">Collaborating Institutions</h4>
	<div class="row flex-wrap ">
		<div class="col-6">
			<sql:query var="collabs" dataSource="jdbc/N3CPublic">
				select bar.org_type,count(distinct bar.ror_id)
				from n3c_collaboration.organization_organization as foo, n3c_collaboration.organization_edge as foo1,
					n3c_collaboration.organization_organization as bar, n3c_collaboration.organization_edge as bar1
				where foo.ror_id=foo1.ror_id and foo1.project_uid=bar1.project_uid
				  and bar.ror_id=bar1.ror_id and foo.ror_id!=bar.ror_id
				  and foo.ror_id = ?
				group by 1 order by 2 desc,1
				<sql:param>${param.ror}</sql:param>
			</sql:query>
			<c:forEach items="${collabs.rows}" var="row" varStatus="rowCounter">
				<p>${row.count} ${row.org_type}</p>
			</c:forEach>
		</div>
		<div class="col-6">
			<img alt="testing" style="width: 100%; object-fit: contain" src="/n3c-dashboard/overview/collaborating_sites/tiles/collaborators.png">
		</div>
	</div>
</div>
