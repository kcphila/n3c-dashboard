<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select severity_abbrev as severity, comorbidity, patient_display, patient_count,
				severity_abbrev, severity_seq, comorbidity_abbrev, comorbidity_seq
			from (select
					severity,
					cci_score as comorbidity,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.med_snpsht_sotro_cci_sev_csd
		  	) as foo
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.cci_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"severity", "label":"Severity"},
        {"value":"comorbidity", "label":"CCI Score"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"severity_abbrev", "label":"dummy1"},
        {"value":"severity_seq", "label":"dummy2"},
        {"value":"comorbidity_abbrev", "label":"dummy3"},
        {"value":"comorbidity_seq", "label":"dummy4"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}