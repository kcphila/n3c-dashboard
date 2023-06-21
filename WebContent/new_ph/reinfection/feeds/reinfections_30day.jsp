<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cases" dataSource="jdbc/N3CPublic">
	select json_agg(json order by start)
	from (select
			test_date_diff_range as time_range,
			patient_count as count,
			range_start as start, 
			case 
				when (patient_count = '<20') then 0
				else patient_count::int
			end as actual_count
			from n3c_dashboard_ph.rein_30days_csd
			where test_date_diff_range not in ('0-15','15-30')
		) as json;

</sql:query>


{
    "headers": [
        {"value":"time_range", "label":"Time Range in Days"},
        {"value":"count", "label":"Number of Patients"},
        {"value":"start", "label":"Start"}, 
        {"value":"actual_count", "label":"Actual Count"}
    ],
    "rows" : 
<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

}

