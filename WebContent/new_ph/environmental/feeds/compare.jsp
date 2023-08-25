<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select label, part, total
		from (
			select
				'All Patient Mortality' as label,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Enclave Total Mortalities') as part,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Enclave Total') as total	
			UNION 
			
			select
				'Environmentally Impacted Patient Mortality' as label,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Environmentally Impacted Mortalities') as part,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Enclave Total Environmentally Impacted') as total	
				
			UNION 
			
			select
				'All COVID+ Patient Mortality' as label,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'COVID+ Mortalities') as part,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Enclave Total COVID+') as total	
				
			UNION 
			
			select
				'Environmentally Impacted COVID+ Patient Mortality' as label,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Environmentally Impacted COVID+ Mortalities') as part,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Environmentally Impacted COVID+') as total
				
			UNION 
			
			select
				'All COVID+ Patient Long COVID' as label,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'COVID+ Long COVID') as part,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Enclave Total COVID+') as total
				
			UNION 
			
			select
				'Environmentally Impacted COVID+ Patient Long COVID' as label,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Environmentally Impacted COVID+ Long COVID') as part,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Environmentally Impacted COVID+') as total
				
			UNION
			
			select
				'All COVID+ Patient Hospitalization' as label,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'COVID+ Hospitalizaions') as part,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Enclave Total COVID+') as total
				
			UNION 
			
			select
				'Environmentally Impacted COVID+ Patient Hospitalization' as label,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Environmentally Impacted COVID+ Hospitalization') as part,
				(select patient_count from n3c_dashboard_ph.env_allCnt_all_csd where metric = 'Environmentally Impacted COVID+') as total
			
		)as foo
	)as done;
</sql:query>
{
    "headers": [
        {"value":"label", "label":"Case"},
        {"value":"part", "label":"Patient Count"},
        {"value":"total", "label":"Out of (Total)"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
