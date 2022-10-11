<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cases" dataSource="jdbc/N3CPublic">
select json_agg(json)
from (select severity_abbrev as severity, severity_seq, state, region_id, region_name, division_id, division_name, state_count, region_count, division_count from
	 (select
	 	case
	 	when state='Washington, D.C.' then
	 		'District of Columbia'
	 	else
	 		state
	 	end as state,
	 	severity_type as severity,
	 	num_patients as state_count
	 from n3c_questions_new.cases_by_severity_by_state_censored_regional_distribution
	 ) as foo
	 natural join
	n3c_dashboard.severity_map
	natural join
	n3c_dashboard.state_map
	natural join
	(select
		region_id,
		sum(case
				when (num_patients = '<20' or num_patients is null) then 0
				else num_patients::int
			end) as region_count
	 from n3c_questions_new.cases_by_severity_by_state_censored_regional_distribution
	 natural join n3c_dashboard.state_map
	 group by region_id) as foo2
	natural join
	(select
		division_id,
		sum(case
				when (num_patients = '<20' or num_patients is null) then 0
				else num_patients::int
			end) as division_count
	 from n3c_questions_new.cases_by_severity_by_state_censored_regional_distribution
	 natural join n3c_dashboard.state_map
	 group by division_id
	) as bar
	) as json
;	
</sql:query>


{
    "headers": [
        {"value":"severity", "label":"Severity"},
       {"value":"severity_seq", "label":"severity seq"},
        {"value":"state", "label":"State"},
        {"value":"region_id", "label":"Region Id"},
        {"value":"region_name", "label":"Region Name"},
        {"value":"division_id", "label":"Division Id"},
        {"value":"division_name", "label":"Division Name"},
        {"value":"state_count", "label":"State Patient Count"},
        {"value":"region_count", "label":"Region Patient Count"},
        {"value":"division_count", "label":"Division Patient Count"}
    ],
    "rows" : 
<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

}

