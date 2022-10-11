<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cases" dataSource="jdbc/N3CPublic">
select json_agg(json order by initial)
from (select
		initial_infection,
		subsequent_infection,
		interval,
		((interval / 30) * 30)||' to '||((interval / 30 + 1) * 30) as interval_bin,
		count,
		actual_count,
		initial,
		subsequent,
		interval / 30 as interval_bin_seq
	from (select
	 	to_char(initial_month,'FM00')||'/'||initial_year as initial_infection,
	 	to_char(subsequent_month, 'FM00')||'/'||subsequent_year as subsequent_infection,
	 	(subsequent_month||'/'||'01/'||subsequent_year)::date - (initial_month||'/'||'01/'||initial_year)::date as interval,
	 	count,
	 	case
			when (count = '<20') then 0
			else count::int
		end as actual_count,
	 	initial_year||'-'||to_char(initial_month,'FM00') as initial,
	 	subsequent_year||'-'||to_char(subsequent_month, 'FM00') as subsequent
	 from n3c_questions_new.all_tests_month_cohort_reinfection_time_series
	) as bar
	) as json
;	
</sql:query>


{
    "headers": [
        {"value":"initial_infection", "label":"Initial Infection / First Diagnosis"},
        {"value":"subsequent_infection", "label":"Subsequent Infection"},
        {"value":"interval", "label":"Reinfection Interval"},
        {"value":"interval_bin", "label":"Interval Bin"},
        {"value":"count", "label":"Number of Reinfected Patients"},
        {"value":"actual_count", "label":"Actual Count"},
        {"value":"initial", "label":"Actual initial"},
        {"value":"subsequent", "label":"Actual subsequent"},
        {"value":"interval_bin_seq", "label":"Actual interval bin"}
    ],
    "rows" : 
<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

}

