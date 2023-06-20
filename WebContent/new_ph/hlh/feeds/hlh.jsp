<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select observation, age, sex, patient_display, patient_count, age_abbrev, age_seq, sex_abbrev, sex_seq, observation as observation_abbrev, observation_seq
			from (select
					INITCAP(observation) as observation,
					coalesce(age, 'Unknown') as age,
					sex,
					patient_count as patient_display,
					n_observation as observation_seq,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.ds_${param.comorbidity}
		  	) as foo
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.age_map_min
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"observation", "label":"Observation"},
        {"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy0"},
        {"value":"age_seq", "label":"dummy1"},
        {"value":"sex_abbrev", "label":"dummy2"},
        {"value":"sex_seq", "label":"dummy3"},
        {"value":"observation_abbrev", "label":"dummy4"},
        {"value":"observation_seq", "label":"dummy5"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
