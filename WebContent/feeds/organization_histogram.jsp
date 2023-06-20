<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CPublic">
	SELECT jsonb_pretty(jsonb_agg(p))
	FROM ( SELECT
	         ror_id,
	         ( SELECT json_agg(row_to_json(c))
	           FROM (
	                select bar.org_type as name, count(*) as value
					from n3c_collaboration.organization_organization as foo, n3c_collaboration.organization_edge as foo1,
					n3c_collaboration.organization_organization as bar, n3c_collaboration.organization_edge as bar1
					where foo.ror_id=foo1.ror_id and foo1.project_uid=bar1.project_uid
					and bar.ror_id=bar1.ror_id and foo.ror_id!=bar.ror_id
					and foo.ror_id = organization_organization.ror_id
					group by 1 order by 2 desc, 1
	                ) as c
	         ) AS orgs
	       FROM n3c_collaboration.organization_organization
	) as p
</sql:query>
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>

