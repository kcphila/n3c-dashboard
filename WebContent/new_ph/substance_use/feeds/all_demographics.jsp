<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select age, race, sex, ethnicity, alcohol, smoking, opioids, cannabis, covid, patient_display, patient_count,
				age_abbrev, age_seq, race_abbrev, race_seq,
				sex_abbrev, sex_seq, ethnicity_abbrev, ethnicity_seq
			from (select
					COALESCE (age_bin, 'Unknown') as age,
					race,
					sex,
					ethnicity,
					case
						when alcohol_indicator = 1 then 'Positive'
						else 'Unknown'
					end as alcohol,
					case
						when smoking_indicator = 1 then 'Positive'
						else 'Unknown'
					end as smoking,
					case
						when opioid_indicator = 1 then 'Positive'
						else 'Unknown'
					end as opioids,
					case
						when cannabis_indicator = 1 then 'Positive'
						else 'Unknown'
					end as cannabis,
					case
						when covid_indicator = 1 then 'Positive'
						else 'Unknown'
					end as covid,
					num_patients as patient_display,
					case
						when (num_patients = '<20' or num_patients is null) then 0
						else num_patients::int
					end as patient_count
				  from n3c_dashboard_ph.sub_all_demo_age_ideal_csd
		  	) as foo
		  	natural join n3c_dashboard.age_map_ideal
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.ethnicity_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"age", "label":"Age"},
        {"value":"race", "label":"Race"},
        {"value":"sex", "label":"Sex"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"alcohol", "label":"Alcohol"},
        {"value":"smoking", "label":"Smoking"},
        {"value":"opioids", "label":"Opioids"},
        {"value":"cannabis", "label":"Cannabis"},
        {"value":"covid", "label":"COVID"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
        {"value":"sex_abbrev", "label":"dummy5"},
        {"value":"sex_seq", "label":"dummy6"},
        {"value":"ethnicity_abbrev", "label":"dummy7"},
        {"value":"ethnicity_seq", "label":"dummy8"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}