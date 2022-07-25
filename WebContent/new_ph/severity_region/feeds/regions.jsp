<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cases" dataSource="jdbc/N3CPublic">
select json_agg(json)
from (select 
		division_name as region, 
		COALESCE(severity_abbrev, 'Unavailable') as severity, 
		sum(case when (num_patients = '<20' or num_patients is null) then 0
			else num_patients::int
			end) as patient_count 
		from n3c_questions.cases_by_severity_by_state_censored
		natural join n3c_dashboard.state_map
		left join n3c_dashboard.severity_map on n3c_questions.cases_by_severity_by_state_censored.severity_type = n3c_dashboard.severity_map.severity
		group by division_name, severity_abbrev
		order by division_name, severity_abbrev)
	as json;	
</sql:query>


{
    "headers": [
        {"value":"region", "label":"Region"},
		{"value":"severity", "label":"Severity"},
        {"value":"patient_count", "label":"Count"}
    ],
    "rows" : 
<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

}

