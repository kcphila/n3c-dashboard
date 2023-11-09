<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select condition, race, age, sex, ethnicity, status, mortality, patient_display, patient_count,
				age_abbrev, age_seq, race_abbrev, race_seq,
				sex_abbrev, sex_seq, ethnicity_abbrev, ethnicity_seq, status_abbrev, status_seq, mortality_abbrev, mortality_seq, condition_seq
			from (select
					concept_set_name as condition,
					race,
					COALESCE (age_bin, 'Unknown') as age,
					sex,
					ethnicity,
					case 
						when (covid_indicator = '1') then 'Positive'
						else 'Unknown'
					end as status,
					case 
						when (death_mortality_indicator = '1') then 'Mortality'
						else 'No Mortality'
					end as mortality,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.mh_all_patient_age_ideal_demographics_csd
		  	) as foo
		  	natural join n3c_dashboard.age_map_ideal
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.eth_map
		  	natural join n3c_dashboard.covidstatus_map
		  	natural join n3c_dashboard.mortality_map
		  	natural join (
		  		select distinct(concept_set_name) as condition, DENSE_RANK() OVER (ORDER BY concept_set_name) as condition_seq
				from n3c_dashboard_ph.mh_sexvaccmor_csd
				where concept_set_name is not null
				order by concept_set_name
			) as map
		  ) as done;
</sql:query>
{
    "headers": [
    	{"value":"condition", "label":"Condition"},
        {"value":"race", "label":"Race"},
        {"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"status", "label":"COVID Status"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
        {"value":"sex_abbrev", "label":"dummy5"},
        {"value":"sex_seq", "label":"dummy6"},
        {"value":"ethnicity_abbrev", "label":"dummy7"},
        {"value":"ethnicity_seq", "label":"dummy8"},
        {"value":"status_abbrev", "label":"dummy9"},
        {"value":"status_seq", "label":"dummy10"},
        {"value":"mortality_abbrev", "label":"dummy11"},
        {"value":"mortality_seq", "label":"dummy12"},
        {"value":"condition_seq", "label":"dummy13"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
