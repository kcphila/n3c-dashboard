<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select
		'Medicaid' as label, 
		(select patient_count from n3c_dashboard_ph.cms_cnt_csd where cms_type = 'Medicaid') as count,
		'medicaid' as viz_id,
		'#AD1181' as color
		UNION 
		select
		'Medicare' as label, 
		(select patient_count from n3c_dashboard_ph.cms_cnt_csd where cms_type = 'Medicare') as count,
		'medicare' as viz_id,
		'#8406D1' as color
		UNION 
		select
		'Viral Variants' as label, 
		(select total_viral_patient from n3c_dashboard_ph.viral_total_csd where covid_indicator = 1) as count,
		'viral' as viz_id,
		'#4833B2' as color
		UNION 
		select
		'Mortality' as label, 
		(select  total_mort from n3c_dashboard_ph.mor_all_cnt where type = 'All Patient in EHR') as count,
		'mortality' as viz_id,
		'#007bff' as color
		from n3c_dashboard_ph.mort_mort_all_csd

		
		order by count desc
	) as done;
</sql:query>
{"rows": 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
 