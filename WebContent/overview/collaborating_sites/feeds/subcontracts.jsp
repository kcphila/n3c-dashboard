<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select project_number,title,primary_site
		from n3c_collaboration.subcontracts
		where subaward_ror = ?
		order by 1,2
	) as done ;
	<sql:param>${param.ror}</sql:param>
</sql:query>
{
    "headers": [
        {"value":"project_number", "label":"Project Number"},
        {"value":"title", "label":"Title"},
        {"value":"primary_site", "label":"Primary Site"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
