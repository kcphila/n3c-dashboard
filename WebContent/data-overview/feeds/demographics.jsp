<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select
			coalesce (age, 'Unknown') as age,
			coalesce (severity, 'Unavailable') as severity,
			race,
			ethnicity,
			sex,
			status,
			long,
			mortality,
			vaccinated,
			patient_count as patient_display,
			case
				when patient_count = '<20' then 0
				else patient_count::int
			end as patient_count,
			age_abbrev, age_seq,
			race_abbrev, race_seq,
			ethnicity_abbrev, ethnicity_seq,
			sex_abbrev, sex_seq,
			severity_abbrev, severity_seq,
			status_abbrev, status_seq,
			long_abbrev, long_seq,
			mortality_abbrev, mortality_seq,
			vaccinated_abbrev, vaccinated_seq
			from (
				select
					coalesce (age, 'Unknown') as age,
					coalesce (severity, 'Unavailable') as severity,
					race,
					ethnicity,
					sex,
					case
						when covid_indicator = 1 then 'Positive'
						else 'Unknown'
					end as status,
					case
						when long_covid_indicator = 1 then 'Long COVID'
						else 'Unknown'
					end as long,
					case
						when death_indicator = 1 then 'Mortality'
						else 'No Mortality'
					end  as mortality,
					case
						when vaccinated = 1 then 'Vaccinated'
						else 'Unknown'
					end as vaccinated,
					patient_count
				from n3c_dashboard_ph.demo_demo_mort_sev_vacc_all_covid_csd) as foo
		  	natural join n3c_dashboard.age_map_ideal
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.eth_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.covidstatus_map
		  	natural join n3c_dashboard.longstatus_map
		  	natural join n3c_dashboard.mortality_map
		  	natural join n3c_dashboard.vaccinated_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"age", "label":"Age"},
        {"value":"severity", "label":"Severity"},
        {"value":"race", "label":"Race"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"sex", "label":"Sex"},
        {"value":"status", "label":"COVID"},
        {"value":"long", "label":"Long COVID"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"vaccinated", "label":"Vaccinated"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"dummy0"},
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
			