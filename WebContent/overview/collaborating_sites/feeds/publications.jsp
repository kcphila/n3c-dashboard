<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select
			title,
			external_url,
			id,
			(select doi from scholar_profile.citation natural join scholar_profile.linkage where doi != 'x' and id = foo.id limit 1) as doi,
			(select value from scholar_profile.metadata where field='Journal' and id = foo.id) as journal,
			(select substring(value from '^[0-9]+') from scholar_profile.metadata where field='Publication date' and id = foo.id) as pub_date,
			(select '<ul><li>'||string_agg(last_name||', '||first_name,'<li>')||'<ul>'
				from (select last_name,first_name from scholar_profile.authorship  natural join scholar_profile.authorship_map
						where id=foo.id and ror_id=? order by seqnum) as bar) as authors
		from scholar_profile.citation as foo
		where id in (select id from scholar_profile.authorship natural join scholar_profile.authorship_map as bar where ror_id = ?)
	) as done ;
	<sql:param>${param.ror}</sql:param>
	<sql:param>${param.ror}</sql:param>
</sql:query>
{
    "headers": [
        {"value":"title", "label":"Title"},
        {"value":"external_url", "label":"External URL"},
        {"value":"id", "label":"ID"},
        {"value":"doi", "label":"DOI"},
        {"value":"journal", "label":"Journal"},
        {"value":"pub_date", "label":"Publication Date"},
        {"value":"authors", "label":"Local Authors"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
