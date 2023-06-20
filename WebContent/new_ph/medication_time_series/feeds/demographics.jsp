<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="drugs" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select drug_name as medication, count, ROW_NUMBER() OVER (ORDER BY drug_name) as medication_seq
		from n3c_dashboard_ph.medtimeser_drug_cnt_smry_csd
		order by drug_name
	) as done;
	
	select jsonb_pretty(jsonb_agg(done))
	from (select medication, age_bracket as age, sex, race, patient_display, patient_count,
				 age_abbrev, age_seq, race_abbrev, race_seq, ethnicity_abbrev, ethnicity_seq, gender_abbrev as sex_abbrev, gender_seq as sex_seq,
				 observation_seq
			from (select
					drug_name as medication,
					coalesce(age_bracket, 'Unknown') as age_bin,
					sex,
					race,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.medtimeser_drug_demo_csd
		  	) as foo
		  	natural join n3c_dashboard.age_map_sec
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.medication_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"medication", "label":"Medication"},
        {"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"race", "label":"Race"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
        {"value":"sex_abbrev", "label":"dummy7"},
        {"value":"sex_seq", "label":"dummy8"},
        {"value":"medication_seq", "label":"dummy9"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}