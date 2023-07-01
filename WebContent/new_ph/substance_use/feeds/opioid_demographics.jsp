<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select condition,race, age, sex, severity, mortality, patient_display, patient_count,
				age_abbrev, age_seq, race_abbrev, race_seq,
				sex_abbrev, sex_seq, severity_abbrev, severity_seq,
				mortality_abbrev, mortality_seq
			from (select
					opioids as condition,
					race,
					COALESCE (age, 'Unknown') as age,
					sex,
					severity,
					case
						when covid_patient_death_indicator = 1 then 'Mortality'
						else 'No Mortality'
					end as mortality,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.sub_covopidemoageideal_csd
		  	) as foo
		  	natural join n3c_dashboard.age_map_ideal
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.mortality_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"condition", "label":"Condition"},
        {"value":"race", "label":"Race"},
        {"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"severity", "label":"Severity"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
        {"value":"sex_abbrev", "label":"dummy7"},
        {"value":"sex_seq", "label":"dummy8"},
        {"value":"severity_abbrev", "label":"dummy9"},
        {"value":"severity_seq", "label":"dummy10"},
        {"value":"mortality_abbrev", "label":"dummy9"},
        {"value":"mortality_seq", "label":"dummy10"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}