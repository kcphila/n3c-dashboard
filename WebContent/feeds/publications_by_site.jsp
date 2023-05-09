<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select
		id,
		title,
		(select jsonb_agg(done2) from
			(select
				last_name, first_name, seqnum
			from scholar_profile.authorship as foo natural join scholar_profile.authorship_map
			where foo.id=citation.id and ror_id = ? order by seqnum limit 5
			) as done2) as authors,
		external_url
	from scholar_profile.citation
	where id in (select id from scholar_profile.authorship natural join scholar_profile.authorship_map as bar where ror_id = ?)
	order by id
	) as done;
	<sql:param>${param.ror}</sql:param>
	<sql:param>${param.ror}</sql:param>
</sql:query>
{
    "headers": [
    	{"value":"id", "label":"id"},
        {"value":"title", "label":"Title"},
        {"value":"authors", "label":"Authors"},
        {"value":"external_url", "label":"URL"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
