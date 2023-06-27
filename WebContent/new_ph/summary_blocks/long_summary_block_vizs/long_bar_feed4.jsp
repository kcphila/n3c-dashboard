<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select sum(
		case
			when (patient_count = '<20' or patient_count is null) then 0
			else patient_count::int
		end) as count,
		case
			when (covid_indicator = '1') then 'COVID Positive'
			when (covid_indicator = '0') then 'Unknown'
		end as label, 
		case
			when (covid_indicator = '1') then 3
			when (covid_indicator = '0') then 12
		end as viz_id
		from n3c_dashboard_ph.longcov_icd10indsymptomcts_csd
		group by covid_indicator
		order by count
	) as done;
</sql:query>
{"rows": 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}







