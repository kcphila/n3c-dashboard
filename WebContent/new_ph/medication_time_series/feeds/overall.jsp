<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="drugs" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select drug_name as medication, patient_count as count, ROW_NUMBER() OVER (ORDER BY drug_name) as medication_seq
		from n3c_dashboard_ph.medtimeser_drug_cnt_smry_csd
		order by drug_name
	) as done;
</sql:query>
{
    "headers": [
        {"value":"medication", "label":"Medication"},
        {"value":"count", "label":"Patient Count"}, 
        {"value":"medication_seq", "label":"Patient Count"} 
    ],
    "rows" : 
<c:forEach items="${drugs.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
	