<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from ( select
				alcohol_condition as condition1, opioids as condition2,
				coalesce(all_display, '0') as all_display, all_count,
				coalesce(covid_display, '0') as covid_display, covid_count,
				alcohol_condition_seqnum as condition1_seqnum,
				opioids_seqnum as condition2_seqnum
			from n3c_dashboard_ph.substance_alc_opi_combined
			natural join n3c_dashboard.alcohol_map
			natural join n3c_dashboard.opioid_map
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"condition2", "label":"Alcohol Condition"},
        {"value":"condition2", "label":"Opioids"},
        {"value":"all_display", "label":"All Patient Count"},
        {"value":"all_count", "label":"All Actual"},
        {"value":"covid_display", "label":"COVID Patient Count"},
        {"value":"covid_count", "label":"COVID Actual"},
        {"value":"condition1_seqnum", "label":"dummy1"},
        {"value":"condition2_seqnum", "label":"dummy2"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}