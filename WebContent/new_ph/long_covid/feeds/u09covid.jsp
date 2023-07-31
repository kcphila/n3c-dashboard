<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select race, vaccinated, mortality, severity, patient_display, patient_count,
				race_abbrev, race_seq, vaccinated_abbrev, vaccinated_seq, mortality_abbrev, mortality_seq, severity_abbrev, severity_seq
			from (select
					race,
					case 
						when (vaccinated = 't') then 'Vaccinated'
						else 'Unknown'
					end as vaccinated,
					case 
						when (covid_patient_death_indicator = '1') then 'Mortality'
						else 'No Mortality'
					end as mortality,
					severity,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.longcov_icdvaccmorrac_csd
		  	) as foo
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.vaccinated_map
		  	natural join n3c_dashboard.mortality_map
		  	natural join n3c_dashboard.sev_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"race", "label":"Race"},
        {"value":"vaccinated", "label":"Vaccination Status"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"severity", "label":"Severity"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"race_abbrev", "label":"dummy1"},
        {"value":"race_seq", "label":"dummy2"},
        {"value":"vaccinated_abbrev", "label":"dummy3"},
        {"value":"vaccinated_seq", "label":"dummy4"},
		{"value":"mortality_abbrev", "label":"dummy5"},
        {"value":"mortality_seq", "label":"dummy6"},
        {"value":"severity_abbrev", "label":"dummy7"},
        {"value":"severity_seq", "label":"dummy8"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}