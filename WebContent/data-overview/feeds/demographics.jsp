<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select severity_abbrev as severity, race_abbrev as race, ethnicity, foo.age as age, sex, 
				case when (patient_count = 0) then '<20' else patient_count::text end as patient_display, 
				patient_count,
				age_abbrev, age_seq, race_abbrev, race_seq, ethnicity_abbrev, ethnicity_seq, sex_abbrev, sex_seq, severity_abbrev, severity_seq
			from (select
					severity,
					race,
					ethnicity,
					COALESCE (age, 'Unknown') as age,
					sex,
					sum(case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end) as patient_count
				  from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd
				  group by severity, race, ethnicity, age, sex
		  	) as foo
		  	natural join n3c_dashboard.age_map_ideal
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.eth_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.sev_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"race", "label":"Race"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"severity", "label":"Severity"},
        {"value":"patient_count", "label":"Patient Count"},
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
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			