<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select environmental_factor, patient_count, patient_display, status, status_abbrev, status_seq
		from (
			select 
				env_factor as environmental_factor, 
				case
					when (patient_count = '<20' or patient_count is null) then 0
					else patient_count::int
				end as patient_count, 
				patient_count as patient_display,
				case
					when (covid_indicator = 1) then 'Positive'
					else 'Unknown'
				end as status
			from n3c_dashboard_ph.env_allcnt_cov_csd) as foo
		natural join n3c_dashboard.covidstatus_map
	)as done ;
</sql:query>
{
    "headers": [
        {"value":"environmental_factor", "label":"Environmental Factor"},
        {"value":"status", "label":"COVID Status"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"dummy0"},
        {"value":"status_abbrev", "label":"dummy1"},
        {"value":"status_seq", "label":"dummy2"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
