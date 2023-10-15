<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select project_num,project_title,ic,contact_pi,fiscal_year,award_amount
		from nih_exporter_current.ror_binding natural join nih_exporter_current.n3c
		where ror_id = ?
		order by contact_pi,fiscal_year
	) as done ;
	<sql:param>${param.ror}</sql:param>
</sql:query>
{
    "headers": [
        {"value":"project_num", "label":"Project Number"},
        {"value":"project_title", "label":"Title"},
        {"value":"ic", "label":"IC"},
        {"value":"contact_pi", "label":"Contact PI"},
        {"value":"fiscal_year", "label":"Fiscal Year"},
        {"value":"award_amount", "label":"Award Amount"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
