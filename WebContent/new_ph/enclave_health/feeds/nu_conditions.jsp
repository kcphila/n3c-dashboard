<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select list_of_conditions, count_abbrev as count, no_of_conditions, patient_count, count_abbrev, count_seq, list_of_conditions as list_of_conditions_abbrev
			from (select
					list_of_conditions,
					type_of_count as count,
					no_of_conditions,
					patient_count
				  from n3c_dashboard_ph.enclave_ruca_cnt_csd
				  order by no_of_conditions, list_of_conditions, type_of_count
		  	) as foo
			natural join n3c_dashboard.count_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"list_of_conditions", "label":"Conditions"},
        {"value":"count", "label":"Count Type"},
        {"value":"no_of_conditions", "label":"Number of Conditions"},
        {"value":"patient_count", "label":"Patient Count"},
        {"value":"count_abbrev", "label":"dummy1"},
        {"value":"count_seq", "label":"dummy2"},
        {"value":"list_of_conditions_abbrev", "label":"dummy3"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
