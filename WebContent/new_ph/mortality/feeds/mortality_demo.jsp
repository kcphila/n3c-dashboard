<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select race, ethnicity, age, sex, status, vaccinated, patient_display, patient_count,
				age_abbrev, age_seq, 
				race_abbrev, race_seq, 
				ethnicity_abbrev, ethnicity_seq, 
				sex_abbrev, sex_seq,
				status_abbrev, status_seq,
				vaccinated_abbrev, vaccinated_seq
			from (select
					race,
					ethnicity,
					COALESCE (age, 'Unknown') as age,
					sex,
					patient_count as patient_display,
					case
						when covid_indicator = 1 then 'Positive'
						else 'Unknown'
					end as status,
					case 
						when (vaccinated = 't') then 'Vaccinated'
						else 'Unknown'
					end as vaccinated,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.mor_alldemomor_csd
		  	) as foo
		  	natural join n3c_dashboard.age_map_min
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.eth_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.covidstatus_map
		  	natural join n3c_dashboard.vaccinated_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"race", "label":"Race"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"status", "label":"COVID"},
        {"value":"vaccinated", "label":"Vaccination Status"},
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
        {"value":"status_abbrev", "label":"dummy9"},
        {"value":"status_seq", "label":"dummy10"},
        {"value":"vaccinated_abbrev", "label":"dummy11"},
        {"value":"vaccinated_seq", "label":"dummy12"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}