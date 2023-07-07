<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select sex, severity, status, long, vaccinated, mortality, patient_display, patient_count,
				sex_abbrev, sex_seq, severity_abbrev, severity_seq, status_abbrev, status_seq, 
				long_abbrev, long_seq, vaccinated_abbrev, vaccinated_seq, mortality_abbrev, mortality_seq
			from (select
					sex,
					severity,
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
						when (covid_patient_death_indicator = '1') then 'Mortality'
						else 'No Mortality'
					end as mortality,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.env_envsxmortvac_all_csd
		  	) as foo
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
        {"value":"sex", "label":"Sex"},
        {"value":"severity", "label":"Severity"},
        {"value":"status", "label":"COVID Status"},
        {"value":"long", "label":"Long COVID Status"},
        {"value":"vaccinated", "label":"Vaccination Status"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"sex_abbrev", "label":"dummy1"},
        {"value":"sex_seq", "label":"dummy2"},
        {"value":"severity_abbrev", "label":"dummy3"},
        {"value":"severity_seq", "label":"dummy4"},
        {"value":"status_abbrev", "label":"dummy5"},
        {"value":"status_seq", "label":"dummy6"},
        {"value":"long_abbrev", "label":"dummy7"},
        {"value":"long_seq", "label":"dummy8"},
        {"value":"vaccinated_abbrev", "label":"dummy9"},
        {"value":"vaccinated_seq", "label":"dummy10"},
        {"value":"mortality_abbrev", "label":"dummy11"},
        {"value":"mortality_seq", "label":"dummy12"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
