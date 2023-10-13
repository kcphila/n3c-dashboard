<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select drug_domain, drug_name as concept_set_name, age, status,
		case when patient_count = 0 then '<20' else patient_count||'' end as patient_display, 
		patient_count, total_count, 
		age_abbrev, age_seq,
		status_abbrev, status_seq
			from (select
					drug_name,
					drug_domain,
					COALESCE (age, 'Unknown') as age,
					case
						when covid_indicator = 1 then 'Positive'
						else 'Unknown'
					end as status,
					sum(case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end) as patient_count,
					max(total_patient_count) as total_count
				  from n3c_dashboard_ph.meds_covdemoagemin_csd
				  group by drug_name, drug_domain, age, covid_indicator
				  order by drug_domain, drug_name
		  	) as foo
		  	natural join n3c_dashboard.age_map_min
		  	natural join n3c_dashboard.covidstatus_map
		  )as done ;
</sql:query>
{
    "headers": [
        {"value":"drug_domain", "label":"Class"},
        {"value":"concept_set_name", "label":"Medication"},
        {"value":"age", "label":"Age"},
        {"value":"status", "label":"COVID"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"total_count", "label":"Total Count"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"status_abbrev", "label":"dummy3"},
        {"value":"status_seq", "label":"dummy4"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
