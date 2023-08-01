<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select max(total_patient_count) as count, 
		'Long COVID ICD-10 (U09.9) In Record' as label, 
		13 as viz_id
		from n3c_dashboard_ph.longcov_icddemoagemin_csd
		UNION 
		select max(total_patient_count) as count,
		'Long COVID Clinic Visit' as label,
		2 as viz_id
		from n3c_dashboard_ph.longcov_consetdemoagemin_csd
	) as done;
</sql:query>
{"rows": 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
 