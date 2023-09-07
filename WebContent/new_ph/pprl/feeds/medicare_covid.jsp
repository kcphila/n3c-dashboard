<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select race, severity, long, mortality, vaccinated, patient_display, patient_count,
				race_abbrev, race_seq, 
				severity_abbrev, severity_seq, 
				long_abbrev, long_seq,
				mortality_abbrev, mortality_seq, 
				vaccinated_abbrev, vaccinated_seq
			from (select
					race,
					severity,
					case
						when death_indicator = 1 then 'Mortality'
						else 'No Mortality'
					end as mortality,
					
					case
						when vaccinated = 1 then 'Vaccinated'
						else 'Unknown'
					end as vaccinated,
					case
						when long_covid_indicator = 1 then 'Long COVID'
						else 'Unknown'
					end as long,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.cms_rcmorvac_csd
				  where race is not null 
				  and severity is not null
				  and death_indicator is not null
				  and vaccinated is not null
				  and long_covid_indicator is not null
				  and cms_type = 'Medicare'
		  	) as foo
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.longstatus_map
		  	natural join n3c_dashboard.mortality_map
		  	natural join n3c_dashboard.vaccinated_map
		  ) as done;
</sql:query>
{
    "headers": [
    	{"value":"race", "label":"Race"},
        {"value":"severity", "label":"Severity"},
        {"value":"long", "label":"Long COVID"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"vaccinated", "label":"Vaccinated"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"race_abbrev", "label":"dummy1"},
        {"value":"race_seq", "label":"dummy2"},
        {"value":"severity_abbrev", "label":"dummy3"},
        {"value":"severity_seq", "label":"dummy4"},
        {"value":"long_abbrev", "label":"dummy5"},
        {"value":"long_seq", "label":"dummy6"},
        {"value":"mortality_abbrev", "label":"dummy7"},
        {"value":"mortality_seq", "label":"dummy8"},
        {"value":"vaccinated_abbrev", "label":"dummy9"},
        {"value":"vaccinated_seq", "label":"dummy10"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
