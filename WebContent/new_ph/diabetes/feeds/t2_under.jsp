<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
select json_agg(json)
	from (select * from
			(select
				observation,
				sum(count::int) as patient_count,
				n_observation as observation_seq
			from n3c_questions.diabetes_t2_full_censored
			where age_bracket = '<18' and count != '<20' group by 1,3
			) as foo
		union
			select
				covid_event_type as observation,
				count as patient_count,
				0 as observation_seq
			from n3c_questions.pediatric_covid_event_type order by 3,2 desc
		) as json
</sql:query>
{
    "headers": [
        {"value":"observation", "label":"Observation"},
        {"value":"patient_count", "label":"Patient Count"},
        {"value":"observation_seq", "label":"dummy0"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>
}
