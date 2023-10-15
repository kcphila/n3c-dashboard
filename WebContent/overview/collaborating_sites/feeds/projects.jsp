<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select uid,title,lead_investigator,accessing_institution,workspace_status,dur_project_id,'pending' as members,'pending' as collaborators
		from n3c_admin.enclave_project
		where uid in (select project_uid
						from n3c_admin.enclave_project_members, n3c_admin.enclave_project, palantir.n3c_user
						where project_uid=uid and enclave_project_members.orcid_id=n3c_user.orcid_id
						and ror_id = ?)
		order by 5,2
	) as done ;
	<sql:param>${param.ror}</sql:param>
</sql:query>
{
    "headers": [
        {"value":"uid", "label":"UID"},
        {"value":"title", "label":"Title"},
        {"value":"lead_investigator", "label":"Lead Investigator"},
        {"value":"accessing_institution", "label":"Accessing Institution"},
        {"value":"workspace_status", "label":"Status"},
        {"value":"dur_project_id", "label":"DUR Project ID"},
        {"value":"members", "label":"Members From This Site"},
        {"value":"collaborators", "label":"Collaborating Organizations (# investigators)"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
