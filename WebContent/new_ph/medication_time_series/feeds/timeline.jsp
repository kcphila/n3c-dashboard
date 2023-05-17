<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="drugs" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select month,medication,coalesce(count,'') as count,coalesce(actual_count, 0) as actual_count from
			(select distinct month,drug_name as medication from n3c_dashboard.month, n3c_dashboard_ph.medtimeser_drug_monthcnt_csd) as bar
			natural left outer join
			(select
				drug_name as medication,
				exposure_year||'-'||to_char(exposure_month, 'FM00') as month,
				count_per_month as count,
				case
					when (count_per_month = '<20' or count_per_month is null) then 0
					else count_per_month::int
				end as actual_count
			from n3c_dashboard_ph.medtimeser_drug_monthcnt_csd) as foo
		order by 1,2
	) as done;
</sql:query>
{
    "headers": [
        {"value":"month", "label":"Month"},
        {"value":"medication", "label":"Medication"},
        {"value":"count", "label":"Patient Count"},
        {"value":"actual_count", "label":"Patient Actual"}
    ],
    "rows" : 
<c:forEach items="${drugs.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
	