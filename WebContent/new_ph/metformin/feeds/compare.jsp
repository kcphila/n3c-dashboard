<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select metformin, race, age, sex, severity, status, long, vaccinated, mortality, medocc, diabetes, comorbidity,
				case
					when (patient_count = 0) then '<20'
					else patient_count::text
				end as patient_display,
		 		patient_count,
				age_seq, severity_abbrev, severity_seq, long_abbrev, long_seq, mortality_abbrev, mortality_seq
			from (select
					case when (metformin_indicator = '1') then 'Metformin'
						else 'No Metformin'
					end as metformin,
					race,
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
						when (metformin_before_after_covid = 'Before') then 'Before COVID'
						when (metformin_before_after_covid = 'After') then 'After COVID'
						else 'Unknown or N/A'
					end as medocc,
					case 
						when (diabetes_indicator = '1') then 'Diabetes'
						else 'No Diabetes'
					end as diabetes,
					cci_score_range as comorbidity,
					sum(case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end) as patient_count
				  from n3c_dashboard_ph.metformindiabetes_demosevvacmorlc_cov_csd
				  where patient_count != '<20'
				  group by metformin_indicator, race, age, sex, severity, covid_indicator, long_covid_diagnosis_post_covid_indicator, vaccinated,
				  patient_death_indicator,  metformin_before_after_covid, diabetes_indicator, cci_score_range
				  
		  	) as foo
		  	natural join n3c_dashboard.age_map_min
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.longstatus_map
		  	natural join n3c_dashboard.mortality_map
		  ) as done;
</sql:query>
{
    "headers": [
    	{"value":"metformin", "label":"Metformin Status"},
        {"value":"race", "label":"Race"},
        {"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"severity", "label":"Severity"},
        {"value":"status", "label":"COVID Status"},
        {"value":"long", "label":"Long COVID Status"},
        {"value":"vaccinated", "label":"Vaccination Status"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"medocc", "label":"Medication Occurrence"},
        {"value":"diabetes", "label":"Diabetes Status"},
        {"value":"comorbidity", "label":"CCI Score"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_seq", "label":"dummy1"},
        {"value":"severity_abbrev", "label":"dummy2"},
        {"value":"severity_seq", "label":"dummy3"},
        {"value":"long_abbrev", "label":"dummy4"},
        {"value":"long_seq", "label":"dummy5"},
        {"value":"mortality_abbrev", "label":"dummy6"},
        {"value":"mortality_seq", "label":"dummy7"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}