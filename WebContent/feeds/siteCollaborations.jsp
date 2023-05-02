<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:query var="sites" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(foo)) from (
		select
			ror_name as site,
			ror_id as id,
			org_type as type,
			investigator_count as count,
			membership_count as aggregate_count,
			project_count as target_count,
			latitude,
			longitude,
			(select link from ror.link where id = ror_id) as url
		from n3c_collaboration.collaboration_organization
	) as foo;
</sql:query>

{
    "headers": [
        {"value":"site", "label":"Site"},
        {"value":"type", "label":"Type"},
        {"value":"count", "label":"Investigator Count"},
        {"value":"aggregate_count", "label":"Membership Count"},
        {"value":"target_count", "label":"Project Count"},
        {"value":"id", "label":"ID"},
        {"value":"url", "label":"URL"},
        {"value":"latitude", "label":"Latitude"},
        {"value":"longitude", "label":"Longitude"}
    ],
  "sites":
	<c:forEach items="${sites.rows}" var="row" varStatus="rowCounter">
		${row.jsonb_pretty}
	</c:forEach>
}
