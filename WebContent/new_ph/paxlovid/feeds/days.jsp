<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by days_seq))
	from (
		select CONCAT(days::text, ' Day(s) Between COVID+ Diagnosis and Prescription') as days, patient_display::text, patient_count, days as days_abbrev, (days::int + 1) as days_seq
			from (select
				pax_covid_delta as days,
				count as patient_display,
				case
					when (count::text = '<20' or count is null) then 0
					else count::int
					end as patient_count
				from n3c_dashboard_ph.pax_paxadm_csd
			) as foo
	) as done;
</sql:query>
{
    "headers": [
        {"value":"days", "label":"Days"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"days_abbrev", "label":"dummy1"},
        {"value":"days_seq", "label":"dummy2"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
</c:forEach>
}
