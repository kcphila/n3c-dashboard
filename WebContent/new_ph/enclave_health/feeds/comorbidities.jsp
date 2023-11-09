<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select comorbidity, sex, vaccinated, status, long as longstatus, mortality, patient_display, patient_count,
				sex_abbrev, sex_seq, vaccinated_abbrev, vaccinated_seq, status_abbrev, status_seq, long_abbrev, long_seq, mortality_abbrev, mortality_seq, comorbidity_seq
			from (select
					case 
						when (concept_set_name is null) then 'Unknown/None'
						else concept_set_name
					end as comorbidity,
					sex,
					case 
						when (vaccinated = '1') then 'Vaccinated'
						else 'Unknown'
					end as vaccinated,
					case 
						when (covid_indicator = '1') then 'Positive'
						else 'Unknown'
					end as status,
					case 
						when (long_covid_indicator = '1') then 'Long COVID'
						else 'Unknown'
					end as long,
					case 
						when (death_mortality_indicator = '1') then 'Mortality'
						else 'No Mortality'
					end as mortality,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.mh_sexvaccmor_other_csd
		  	) as foo
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.vaccinated_map
		  	natural join n3c_dashboard.covidstatus_map
		  	natural join n3c_dashboard.longstatus_map
		  	natural join n3c_dashboard.mortality_map
		  	natural join (
		  		select distinct(case 
					when (concept_set_name is null) then 'Unknown/None'
					else concept_set_name
					end) as comorbidity, DENSE_RANK() OVER (ORDER BY concept_set_name) as comorbidity_seq
				from n3c_dashboard_ph.mh_sexvaccmor_other_csd
				order by case 
					when (concept_set_name is null) then 'Unknown/None'
					else concept_set_name
					end
			) as map
		  ) as done;
</sql:query>
{
    "headers": [
    	{"value":"comorbidity", "label":"Comorbidity"},
        {"value":"sex", "label":"Sex"},
        {"value":"vaccinated", "label":"Vaccinated"},
        {"value":"status", "label":"COVID Status"},
        {"value":"longstatus", "label":"Long COVID Status"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"sex_abbrev", "label":"dummy5"},
        {"value":"sex_seq", "label":"dummy6"},
        {"value":"vaccinated_abbrev", "label":"dummy7"},
        {"value":"vqccinated_seq", "label":"dummy8"},
        {"value":"status_abbrev", "label":"dummy9"},
        {"value":"status_seq", "label":"dummy10"},
        {"value":"long_abbrev", "label":"dummy9"},
        {"value":"long_seq", "label":"dummy10"},
        {"value":"mortality_abbrev", "label":"dummy11"},
        {"value":"mortality_seq", "label":"dummy12"},
        {"value":"comorbidity_seq", "label":"dummy13"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
