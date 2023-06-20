<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select vaccinated, severity_abbrev as severity, patient_display, patient_count,
				severity_abbrev, severity_seq, vaccinated_abbrev, vaccinated_seq
			from (select
					severity,
					Case
						when (vaccinated) then 'Vaccinated'
						else 'Unknown'
						end as vaccinated,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.med_snpsht_sotro_vaccsev_csd
		  	) as foo
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.vaccinated_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"vaccinated", "label":"Vaccination Status"},
        {"value":"severity", "label":"Severity"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"severity_abbrev", "label":"dummy1"},
        {"value":"severity_seq", "label":"dummy2"},
        {"value":"vaccinated_abbrev", "label":"dummy3"},
        {"value":"vaccinated_seq", "label":"dummy4"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}