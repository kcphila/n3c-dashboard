<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(foo)) from (
		select
			code,
			county.state,
			county.name as county,
			CASE
            	WHEN patient_count = '<20'::text THEN 1
            	ELSE patient_count::integer
            END AS patient_count
		from n3c_dashboard_ph.sub_alcagesec_csd, n3c_dashboard.county
		where sub_alcagesec_csd.state = lower(county.state)
		  and sub_alcagesec_csd.county = lower(county.name)
	) as foo
</sql:query>
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
