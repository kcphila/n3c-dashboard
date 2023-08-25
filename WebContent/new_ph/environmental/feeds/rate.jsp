<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select 
			'All Patients' as label,
			1 as label_seq,
			'Mortality' as variable,
			total, 
			part,
			ROUND((part::decimal / total)*100, 2) as patient_count, 
			ROUND((part::decimal / total)*100, 2) as patient_display 
			from (
				select
					(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Enclave Total') as total,
					(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Enclave Total Mortalities') as part
			) as fa
			
		UNION
			
		select 
			'Envir. Impacted Patients' as label,
			2 as label_seq,
			'Mortality' as variable,
			total, 
			part,
			ROUND((part::decimal / total)*100, 2) as patient_count, 
			ROUND((part::decimal / total)*100, 2) as patient_display 
			from (
				select
					(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Enclave Total Environmentally Impacted') as total,
					(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Environmentally Impacted Mortalities') as part
			) as fa
			
	) as done;
</sql:query>
{
    "headers": [
        {"value":"label", "label":"Label"},
        {"value":"label_seq", "label":"dummy1"},
        {"value":"variable", "label":"dummy2"},
        {"value":"total", "label":"total"},
        {"value":"mortality", "label":"mortality"},
        {"value":"patient_display", "label":"display"},
        {"value":"patient_count", "label":"dummy2"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
