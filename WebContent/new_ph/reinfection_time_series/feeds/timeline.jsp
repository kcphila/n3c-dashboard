<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cases" dataSource="jdbc/N3CPublic">
select json_agg(json order by initial)
from (select initial_infection, subsequent_infection, count, seven_day_rolling_avg, actual_count, initial, subsequent from
	 (select
	 	to_char(initial_month,'FM00')||'/'||initial_year as initial_infection,
	 	to_char(subsequent_month, 'FM00')||'/'||subsequent_year as subsequent_infection,
	 	count,
	 	case
			when (count = '<20') then 0
			else count::int
		end as actual_count,
	 	initial_year||'-'||to_char(initial_month,'FM00') as initial,
	 	subsequent_year||'-'||to_char(subsequent_month, 'FM00') as subsequent
	 from n3c_questions.all_tests_month_cohort
	 ) as foo
	 natural join
	(select
		to_char(first_diagnosis_date::date, 'yyyy-mm') as initial,
		max(seven_day_rolling_avg) as seven_day_rolling_avg
	from n3c_questions.positive_cases_by_day_cumsum_censored
	group by 1
	) as bar
	) as json
;	
</sql:query>


{
    "headers": [
        {"value":"initial_infection", "label":"Initial Infection / First Diagnosis"},
        {"value":"subsequent_infection", "label":"Subsequent Infection"},
        {"value":"count", "label":"Number of Reinfected Patients"},
        {"value":"seven_day_rolling_avg", "label":"Monthly Max of Seven Day Rolling Average"}, 
        {"value":"actual_count", "label":"Actual Count"},
        {"value":"initial", "label":"Actual initial"},
        {"value":"subsequent", "label":"Actual subsequent"}
    ],
    "rows" : 
<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

}

