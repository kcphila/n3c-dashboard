<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select title,external_url,id from scholar_profile.citation
		where id in (select id from scholar_profile.authorship natural join scholar_profile.authorship_map as bar where ror_id = ?)
	) as done ;
	<sql:param>${param.ror}</sql:param>
</sql:query>
{
    "headers": [
        {"value":"title", "label":"Title"},
        {"value":"external_url", "label":"External URL"},
        {"value":"id", "label":"ID"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
