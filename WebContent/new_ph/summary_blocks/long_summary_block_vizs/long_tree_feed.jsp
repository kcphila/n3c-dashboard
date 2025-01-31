<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select sum(
		case
		when (patient_count = '<20' or patient_count is null) then 0
		else patient_count::int
		end) as value,
		case
		when (symptom = 'Cognitive impairment') then 'CI'
		else symptom
		end as symptom, 
		case
		when (symptom = 'POTS') then 'Postural Orthostatic Tachycardia Syndrome'
		else symptom
		end as full_symptom,
		case
		when (symptom = 'POTS') then 10
		when (symptom = 'Shortness of breath') then 11
		when (symptom = 'Mental Health Condition') then 9
		when (symptom = 'Fatigue') then 8
		when (symptom = 'Cognitive impairment') then 7
		end as viz_id
		from n3c_dashboard_ph.longcov_icd10symptom_csd
		group by symptom
	) as done;
</sql:query>
{"children": 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}







