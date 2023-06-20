<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select severity_abbrev as severity, sex_abbrev as sex, age, race_abbrev as race, ethnicity, vaccinated, 
	case when (patient_count = 0) then '<20' else patient_count::text end as patient_display, patient_count, age_abbrev,
	age_seq, race_abbrev, race_seq, ethnicity_abbrev, ethnicity_seq, sex_abbrev, sex_seq, severity_abbrev, severity_seq
			from (select
					severity,
					race,
					ethnicity,
					case
						when (vaccinated = 't') then 'True'
						else 'Unknown'
					end as vaccinated,
					COALESCE (age, 'Unknown') as age,
					sex,
					sum(case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end) as patient_count
				  from n3c_dashboard_ph.demo_demo_mort_vacc_sev_cov_csd
				  group by severity, race, vaccinated, age, sex, ethnicity
		  	) as foo
		  	natural join n3c_dashboard.age_map_ideal
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.eth_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"severity", "label":"Severity"},
        {"value":"sex", "label":"Sex"},
        {"value":"age_bin", "label":"Age"},
        {"value":"race", "label":"Race"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"vaccinated", "label":"Vaccinated"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
         {"value":"ethnicity_abbrev", "label":"dummy5"},
        {"value":"ethnicity_seq", "label":"dummy6"},
        {"value":"sex_abbrev", "label":"dummy7"},
        {"value":"sex_seq", "label":"dummy8"},
        {"value":"severity_abbrev", "label":"dummy9"},
        {"value":"severity_seq", "label":"dummy0"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
