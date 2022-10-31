<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by observation_seq,sex_seq))
	from (select age_bin as age, gender_abbrev as sex, observation, patient_display, patient_count, age_abbrev, age_seq, gender_abbrev as sex_abbrev, gender_seq as sex_seq, observation_seq
			from (select
					age_bracket as age_bin,
					gender_concept_name as gender,
					INITCAP(observation) as observation,
					n_observation as observation_seq,
					count as patient_display,
					case
						when (count = '<20' or count is null) then 0
						else count::int
					end as patient_count
				  from n3c_questions_new.diabetes_t2_full_censored_diabetes_mellitus
		  	) as foo
		  	natural join n3c_dashboard.age_map4
		  	natural join n3c_dashboard.gender_map2
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"observation", "label":"Observation"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"sex_abbrev", "label":"dummy7"},
        {"value":"sex_seq", "label":"dummy8"},
        {"value":"observation_seq", "label":"dummy0"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
