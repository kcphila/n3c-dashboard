<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select drug_domain, medication as concept_set_name, age_bin as age, case when patient_count = 0 then '<20' else patient_count||'' end as patient_display, patient_count, total_count, age_abbrev, age_seq
			from (select drug_domain,medication,age_bin,max(patient_count) as patient_count,total_count from (
				select
					drug_domain,
					concept_set_name,
					medication,
					age_bin,
					case
						when (num_patients = '<20' or num_patients is null) then 0
						else num_patients::int
					end as patient_count,
					total_patients as total_count
				  from n3c_questions_new.covid_patients_demographics_censored_medications natural join n3c_dashboard.medication_map
				  where concept_set_name != 'Available, in progress'
				  order by drug_domain, medication) as bar group by 1,2,3,5 order by 1,2,3
		  	) as foo
		  	natural join n3c_dashboard.age_map4
		  )as done ;
</sql:query>
{
    "headers": [
        {"value":"drug_domain", "label":"Class"},
        {"value":"concept_set_name", "label":"Medication"},
        {"value":"age", "label":"Age"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"total_count", "label":"Total Count"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
