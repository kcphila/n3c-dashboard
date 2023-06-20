<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select severity, age, sex, race, 
			case
				when (patient_count = 0) then '<20'
				else patient_count::text
			end as patient_display, 
			patient_count, severity_abbrev, severity_seq, age_abbrev, age_seq, sex_abbrev, sex_seq, race_abbrev, race_seq
			from (select
					severity,
					coalesce(age, 'Unknown') as age,
					sex,
					race,
					sum(case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end) as patient_count
				  from n3c_dashboard_ph.med_snpsht_sotro_vacagercsev_csd
				  group by severity, age, sex, race
		  	) as foo
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.age_map_min
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.race_map
		  ) as done;
</sql:query>
{
    "headers": [
		{"value":"severity", "label":"Severity"},
		{"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"race", "label":"Race"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"severity_abbrev", "label":"dummy1"},
        {"value":"severity_seq", "label":"dummy2"},
        {"value":"age_abbrev", "label":"dummy3"},
        {"value":"age_seq", "label":"dummy4"},
        {"value":"sex_abbrev", "label":"dummy5"},
        {"value":"sex_seq", "label":"dummy6"},
        {"value":"race_abbrev", "label":"dummy7"},
		{"value":"race_seq", "label":"dummy8"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}