<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select
			coalesce (age, 'Unknown') as age,
			coalesce (severity, 'Unavailable') as severity,
			race,
			sex,
			status as covid,
			vaccinated,
			comorbidities,
			patient_count as patient_display,
			patient_count::int,
			age_abbrev, age_seq,
			race_abbrev, race_seq,
			sex_abbrev, sex_seq,
			severity_abbrev, severity_seq,
			status_abbrev as covid_abbrev, status_seq as covid_seq,
			vaccinated_abbrev, vaccinated_seq
			from (
				select
					coalesce (age, 'Unknown') as age,
					coalesce (severity_type, 'Unavailable') as severity,
					race,
					sex,
					case
						when covid_indicator = 1 then 'Positive'
						else 'Unknown'
					end as status,
					case
						when vaccinated = 1 then 'Vaccinated'
						else 'Unknown'
					end as vaccinated,
					comorbidity_list AS comorbidities,
					patient_count
				from n3c_dashboard_ph.demo_vac_status_gcci_all_covid_csd
				where patient_count != '<20' and comorbidity_list is not null) as foo
		  	natural join n3c_dashboard.age_map_ideal
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.covidstatus_map
		  	natural join n3c_dashboard.vaccinated_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"age", "label":"Age"},
        {"value":"severity", "label":"Severity"},
        {"value":"race", "label":"Race"},
        {"value":"sex", "label":"Sex"},
        {"value":"covid", "label":"COVID"},
        {"value":"vaccinated", "label":"Vaccinated"},
        {"value":"comorbidities", "label":"Comorbidities"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"dummy0"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
        {"value":"sex_abbrev", "label":"dummy5"},
        {"value":"sex_seq", "label":"dummy6"},
        {"value":"severity_abbrev", "label":"dummy7"},
        {"value":"severity_seq", "label":"dummy8"},
        {"value":"covid_abbrev", "label":"dummy9"},
        {"value":"covid_seq", "label":"dummy10"}
    ],
    "rows" : 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			