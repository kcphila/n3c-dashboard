<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cases" dataSource="jdbc/N3CPublic">
select json_agg(json)
from (select 
          n2.division_name as region, 
          COALESCE(severity_abbrev, 'Unavailable') as severity, 
          sum(case when (num_patients = '<20' or num_patients is null) then 0
               else num_patients::int
               end) as patient_count,
          max(site_count) as region_seq
          from n3c_questions.cases_by_severity_by_state_censored
          natural join n3c_dashboard.state_map
          left join n3c_dashboard.severity_map on n3c_questions.cases_by_severity_by_state_censored.severity_type = n3c_dashboard.severity_map.severity
          left join (select count(site) as site_count, n3c_dashboard.state_map.division_name from n3c_maps.sites 
               left join ror.address on n3c_maps.sites.id = ror.address.id
               left join n3c_dashboard.state_map on n3c_dashboard.state_map.state = ror.address.state
               group by n3c_dashboard.state_map.division_name) n2
          on n2.division_name = state_map.division_name
          group by n2.division_name, severity_abbrev
          order by n2.division_name, severity_abbrev)
	as json;	
</sql:query>


{
    "headers": [
        {"value":"region", "label":"Region"},
		{"value":"severity", "label":"Severity"},
        {"value":"patient_count", "label":"Count"},
        {"value":"region_seq", "label":"Providers"}
    ],
    "rows" : 
<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

}

