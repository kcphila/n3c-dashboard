<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select race, ethnicity, age, sex, severity, status, long, vaccinated, mortality, medocc, patient_display, patient_count,
				age_abbrev, age_seq, race_abbrev, race_seq, ethnicity_abbrev, ethnicity_seq, 
				sex_abbrev, sex_seq, severity_abbrev, severity_seq, status_abbrev, status_seq, long_abbrev, long_seq,
				vaccinated_abbrev, vaccinated_seq, mortality_abbrev, mortality_seq, medocc_abbrev, medocc_seq
			from (select
					race,
					ethnicity,
					COALESCE (age, 'Unknown') as age,
					sex,
					case 
						when (severity = 'N/A') then 'Unavailable'
						else severity
					end as severity,
					case 
						when (covid_indicator = '1') then 'Positive'
						else 'Unknown'
					end as status,
					case 
						when (long_covid_diagnosis_post_covid_indicator = '1') then 'Long COVID'
						else 'Unknown'
					end as long,
					case 
						when (vaccinated = '1') then 'Vaccinated'
						else 'Unknown'
					end as vaccinated,
					case 
						when (patient_death_indicator = '1') then 'Mortality'
						else 'No Mortality'
					end as mortality,
					case 
						when (diabetes_before_after_covid = 'Before') then 'Before COVID'
						when (diabetes_before_after_covid = 'After') then 'After COVID'
						else 'Unknown'
					end as medocc,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.diabetes_demosevvacmorlc_cov_csd
				  where metformin_indicator = 1
		  	) as foo
		  	natural join n3c_dashboard.age_map_min
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.eth_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.covidstatus_map
		  	natural join n3c_dashboard.longstatus_map
		  	natural join n3c_dashboard.mortality_map
		  	natural join n3c_dashboard.vaccinated_map
		  	natural join n3c_dashboard.medocc_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"race", "label":"Race"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"severity", "label":"Severity"},
        {"value":"status", "label":"COVID Status"},
        {"value":"long", "label":"Long COVID Status"},
        {"value":"vaccinated", "label":"Vaccination Status"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"metformin_occurrence", "label":"Diabetes Occurrence"},
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
        {"value":"severity_seq", "label":"dummy10"},
        {"value":"status_abbrev", "label":"dummy11"},
        {"value":"status_seq", "label":"dummy12"},
        {"value":"long_abbrev", "label":"dummy13"},
        {"value":"long_seq", "label":"dummy14"},
        {"value":"vaccinated_abbrev", "label":"dummy14"},
        {"value":"vaccinated_seq", "label":"dummy15"},
        {"value":"mortality_abbrev", "label":"dummy16"},
        {"value":"mortality_seq", "label":"dummy17"},
        {"value":"medocc_abbrev", "label":"dummy18"},
        {"value":"medocc_seq", "label":"dummy19"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}