<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:query var="sites" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(foo)) from (
		select
			ror_name as site,
			ror_id as id,
			(select link from ror.link where id = ror_id) as url,
			org_type as type,
			author_count as count,
			authorship_count as aggregate_count,
			publication_count as target_count,
			latitude,
			longitude
			from n3c_collaboration.publication_organization
	) as foo;
</sql:query>

{
    "headers": [
        {"value":"site", "label":"Site"},
        {"value":"type", "label":"Type"},
        {"value":"count", "label":"Author Count"},
        {"value":"aggregate_count", "label":"Authorship Count"},
        {"value":"target_count", "label":"Publication Count"},
        {"value":"id", "label":"Details"},
        {"value":"url", "label":"URL"},
        {"value":"latitude", "label":"Latitude"},
        {"value":"longitude", "label":"Longitude"}
    ],
  "sites":
	<c:forEach items="${sites.rows}" var="row" varStatus="rowCounter">
		${row.jsonb_pretty}
	</c:forEach>
}
