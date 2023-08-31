<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (SELECT
		viral_variant,
		case 
			when covid_unknown is null then '<20'
			else covid_unknown
		end as covid_unknown,
		case 
			when covid_unknown is null or covid_unknown = '<20' then 0
			else covid_unknown::int
		end as covid_unknown_int,
		case 
			when covid_positive is null then '<20'
			else covid_positive
		end as covid_positive,
		case 
			when covid_positive is null or covid_positive = '<20' then 0
			else covid_positive::int
		end as covid_positive_int,
		'test' as test,
		case 
			when total = 0 then '<20'
			else total::text
		end as total,
		total as total_int,
		(select max(total) from (
			select sum(case when patient_count = '<20' then 0 else patient_count::int end) as total 
			from n3c_dashboard_ph.viral_cnt_csd
			group by who_lineage) as fa) as max_total
		from (
			select 
				who_lineage as viral_variant, 
				max(case when covid_indicator = 1 then patient_count end) as covid_positive,
				max(case when covid_indicator = 0 then patient_count end) as covid_unknown,
				sum(case
					when (patient_count = '<20' or patient_count is null) then 0
					else patient_count::int end) as total
			from n3c_dashboard_ph.viral_cnt_csd
			group by who_lineage
		) as foo
	) as done;
</sql:query>
{
    "headers": [
        {"value":"viral_variant", "label":"Viral Variant"},
        {"value":"covid_unknown", "label":"<i class='fas fa-square'>&nbsp;</i> COVID Unknown"},
        {"value":"covid_unknown_int", "label":"dummy1"},
        {"value":"covid_positive", "label":"<i class='fas fa-square'>&nbsp;</i> COVID Positive"},
        {"value":"covid_positive_int", "label":"dummy2"},
        {"value":"test", "label":"Total Data"},
        {"value":"total", "label":"Total (#)"},
        {"value":"total_int", "label":"dummy3"},
        {"value":"max_total", "label":"dummy4"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}