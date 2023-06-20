<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by age_seq))
	from (select age, smoking_status, race, sex, case when (patient_display = 0 )then '<20' else patient_display::text end as patient_display, patient_count, age_abbrev, age_seq, race_abbrev, race_seq, sex_abbrev, sex_seq, smoking_status_abbrev, smoking_status_seq
			from (select
					coalesce(age, 'Unknown') as age,
					smoking_status,
					race,
					sex,
					sum(case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
						end) as patient_display,
					sum(case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
						end) as patient_count
				  from n3c_dashboard_ph.sub_covsmodemoagemin_csd
				  group by age, smoking_status, race, sex
		  	) as foo
		  	natural join n3c_dashboard.age_map_min
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.status_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"age", "label":"Age"},
        {"value":"smoking_status", "label":"Smoking Status"},
        {"value":"race", "label":"Race"},
        {"value":"sex", "label":"Sex"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
        {"value":"sex_abbrev", "label":"dummy5"},
        {"value":"sex_seq", "label":"dummy6"},
        {"value":"smoking_status_abbrev", "label":"dummy7"},
        {"value":"smoking_status_seq", "label":"dummy8"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
