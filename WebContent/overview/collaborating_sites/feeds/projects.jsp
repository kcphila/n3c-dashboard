<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select
			uid,
			title,
			lead_investigator,
			accessing_institution,
			workspace_status,
			dur_project_id,
			(select '<ul><li>'||string_agg(last_name||', '||first_name,'<li>')||'<ul>'
			 from (select last_name,first_name
					 from n3c_admin.enclave_project_members,n3c_admin.enclave_project,palantir.n3c_user
					 where project_uid=uid and enclave_project_members.orcid_id=n3c_user.orcid_id
					 and ror_id = ?
					 and uid = bar.uid
					 order by 1,2) as foo
			) as members,
			(select string_agg(ror_name||' ('||count||')',', ')
			 from (select ror_name,count(*)
					 from n3c_admin.enclave_project_members,n3c_admin.enclave_project,palantir.n3c_user
					 where project_uid=uid and enclave_project_members.orcid_id=n3c_user.orcid_id
					 and ror_id != ?
					 and uid = bar.uid
					 group by 1
					 order by 1) as foo
			) as collaborators
		from n3c_admin.enclave_project as bar
		where uid in (select project_uid
						from n3c_admin.enclave_project_members, n3c_admin.enclave_project, palantir.n3c_user
						where project_uid=uid and enclave_project_members.orcid_id=n3c_user.orcid_id
						and ror_id = ?)
		order by 5,2
	) as done ;
	<sql:param>${param.ror}</sql:param>
	<sql:param>${param.ror}</sql:param>
	<sql:param>${param.ror}</sql:param>
</sql:query>
{
    "headers": [
        {"value":"workspace_status", "label":"Status"},
        {"value":"uid", "label":"UID"},
        {"value":"title", "label":"Title"},
        {"value":"lead_investigator", "label":"Lead Investigator"},
        {"value":"accessing_institution", "label":"Accessing Institution"},
        {"value":"dur_project_id", "label":"DUR Project ID"},
        {"value":"members", "label":"Members From This Site"},
        {"value":"collaborators", "label":"Collaborating Organizations (# investigators)"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
