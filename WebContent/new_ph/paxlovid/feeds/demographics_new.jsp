<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by pax, age, sex, race, ethnicity, severity, patient_display, patient_count, pax_abbrev, pax_seq, age_abbrev, age_seq, sex_abbrev, sex_seq, race_abbrev, race_seq, ethnicity_abbrev, ethnicity_seq, severity_abbrev, severity_seq))
	from (select pax_abbrev as pax, age, sex, race, ethnicity, severity, case when (patient_display = 0 )then '<20' else patient_display::text end as patient_display, patient_count, pax_abbrev, pax_seq, age_abbrev, age_seq, sex_abbrev, sex_seq, race_abbrev, race_seq, ethnicity_abbrev, ethnicity_seq, severity_abbrev, severity_seq
			from (select
					coalesce(age, 'Unknown') as age,
					covid_w_pax as pax,
					race,
					sex,
					severity,
					ethnicity,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
						end as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
						end as patient_count
				  from n3c_dashboard_ph.pax_demoagesec_csd
		  	) as foo
		  	natural join n3c_dashboard.age_map_sec
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.eth_map
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.pax_map
		  ) as done;
</sql:query>
{
    "headers": [
    	{"value":"pax", "label":"Paxlovid Status"},
        {"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"race", "label":"Race"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"severity", "label":"Severity"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"pax_abbrev", "label":"dummy1"},
        {"value":"pax_seq", "label":"dummy2"},
        {"value":"age_abbrev", "label":"dummy3"},
        {"value":"age_seq", "label":"dummy4"},
        {"value":"sex_abbrev", "label":"dummy5"},
        {"value":"sex_seq", "label":"dummy6"},
        {"value":"race_abbrev", "label":"dummy7"},
        {"value":"race_seq", "label":"dummy8"},
        {"value":"ethnicity_abbrev", "label":"dummy9"},
        {"value":"ethnicity_seq", "label":"dummy10"},
        {"value":"severity_abbrev", "label":"dummy11"},
        {"value":"severity_seq", "label":"dummy12"}
        
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}