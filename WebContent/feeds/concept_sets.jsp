<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select
			'N3C Recommended' as type,
			codeset_id,
			alias as title,
			doi,
			created_by,
			case
				when last_name is null then name
				else first_name||' '||last_name
			end as creator,
			coalesce(limitations, '') as limitations,
			coalesce(issues, '') as issues,
			coalesce(provenance, '') as provenance
		  from enclave_concept.concept_set_display natural join enclave_concept.zenodo_deposit
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"type", "label":"Type"},
        {"value":"title", "label":"Title"},
        {"value":"codeset_id", "label":"Codeset ID"},
        {"value":"doi", "label":"DOI"},
        {"value":"created_by", "label":"Created By"},
        {"value":"creator", "label":"Creator"},
        {"value":"limitations", "label":"Limitations"}
    ],
    "rows" : 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			