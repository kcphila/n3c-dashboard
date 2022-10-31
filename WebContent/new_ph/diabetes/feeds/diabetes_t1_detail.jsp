<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cases" dataSource="jdbc/N3CPublic">
	select json_agg(json order by 5,4,2,1)
	from (select
			age_bracket,
			gender_concept_name as sex_concept_name,
			case
				when (count = '<20' or count is null) then 0
				else count::int
			end as count,
			observation,
			n_observation
		  from n3c_questions_new.diabetes_t1_full_censored_diabetes_mellitus where gender_concept_name != 'OTHER'  and age_bracket is not null
		  order by sex_concept_name,
		  (CASE WHEN (age_bracket = '<18') THEN 1 WHEN (age_bracket = '18-64') THEN 0 ELSE -99 END) asc
		  ) as json;
</sql:query>

<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

