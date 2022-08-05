<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="drugs" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select drug_name as medication, count 
		from n3c_questions.drug_count_summary
		order by 1
	) as done;
</sql:query>
{
    "headers": [
        {"value":"medication", "label":"Medication"},
        {"value":"count", "label":"Patient Count"}
    ],
    "rows" : 
<c:forEach items="${drugs.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
	