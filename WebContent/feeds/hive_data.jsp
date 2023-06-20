<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

{
"axes": [ "Age", "Severity", "Sex", "Race", "Ethnicity" ],

"nodes": [

<sql:query var="nodes" dataSource="jdbc/N3CPublic">
	select
		'0-'||age_seq as mapping,
		age as label,
		age_abbrev as short_label,
		0 as x,
		(age_seq * 1.0)/(select max(age_seq)-1 from n3c_dashboard.age_map_ideal) as index,
		(select coalesce(sum(case when patient_count='<20' then 0 else patient_count::int end),0)
		 from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd
		 where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.age = age_map_ideal.age) as weight
	from n3c_dashboard.age_map_ideal where age != 'Unknown'
	
	union
	
	select
		'1-'||severity_seq as mapping,
		severity as label,
		severity_abbrev as short_label,
		1 as x,
		(severity_seq * 1.0)/(select max(severity_seq) from n3c_dashboard.sev_map) as index,
		(select coalesce(sum(case when patient_count='<20' then 0 else patient_count::int end),0)
		 from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd
		 where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.severity = sev_map.severity) as weight
	from n3c_dashboard.sev_map
	
	union
	
	select distinct
		'2-'||sex_seq as mapping,
		sex_abbrev as label,
		sex_abbrev as short_label,
		2 as x,
		(sex_seq * 1.0)/(select max(sex_seq) from n3c_dashboard.sex_map) as index,
		(select coalesce(sum(case when patient_count='<20' then 0 else patient_count::int end),0)
		 from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd
		 where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.sex = sex_map.sex) as weight
	from n3c_dashboard.sex_map where sex != 'null'
	
	union
	
	select
		'3-'||race_seq as mapping,
		race as label,
		race_abbrev as short_label,
		3 as x,
		(race_seq * 1.0)/(select max(race_seq) from n3c_dashboard.race_map) as index,
		(select coalesce(sum(case when patient_count='<20' then 0 else patient_count::int end),0)
		 from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd
		 where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.race = race_map.race) as weight
	from n3c_dashboard.race_map
	
	union
	
	select
		'4-'||ethnicity_seq as mapping,
		ethnicity as label,
		ethnicity_abbrev as short_label,
		4 as x,
		(ethnicity_seq * 1.0)/(select max(ethnicity_seq) from n3c_dashboard.eth_map) as index,
		(select coalesce(sum(case when patient_count='<20' then 0 else patient_count::int end),0)
		 from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd
		 where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.ethnicity = eth_map.ethnicity) as weight
	from n3c_dashboard.eth_map
	
	order by 4,5
</sql:query>
<c:forEach items="${nodes.rows}" var="row" varStatus="rowCounter">
	{ "mapping":"${row.mapping}", "label":"${row.label}", "short_label":"${row.short_label}", "x":${row.x}, "y":${row.index}, "weight":${row.weight} }<c:if test="${!rowCounter.last}">,</c:if>
</c:forEach>

],

"edges": [

<sql:query var="edges" dataSource="jdbc/N3CPublic">
	select '0-'||age_seq as source, '1-'||severity_seq as target, sum(case when patient_count='<20' then 0 else patient_count::int end) as weight
	from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd, n3c_dashboard.age_map_ideal, n3c_dashboard.sev_map
	where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.age = age_map_ideal.age
	  and n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.severity = sev_map.severity
	group by 1,2
	
	union
	
	select '0-'||age_seq as source, '2-'||sex_seq as target, sum(case when patient_count='<20' then 0 else patient_count::int end) as weight
	from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd, n3c_dashboard.age_map_ideal, n3c_dashboard.sex_map
	where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.age = age_map_ideal.age
	  and n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.sex = sex_map.sex
	group by 1,2
	
	union
	
	select '0-'||age_seq as source, '3-'||race_seq as target, sum(case when patient_count='<20' then 0 else patient_count::int end) as weight
	from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd, n3c_dashboard.age_map_ideal, n3c_dashboard.race_map
	where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.age = age_map_ideal.age
	  and n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.race = race_map.race
	group by 1,2
	
	union
	
	select '0-'||age_seq as source, '4-'||ethnicity_seq as target, sum(case when patient_count='<20' then 0 else patient_count::int end) as weight
	from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd, n3c_dashboard.age_map_ideal, n3c_dashboard.eth_map
	where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.age = age_map_ideal.age
	  and n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.ethnicity = eth_map.ethnicity
	group by 1,2
	
	union
	
	select '1-'||severity_seq as source, '2-'||sex_seq as target, sum(case when patient_count='<20' then 0 else patient_count::int end) as weight
	from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd, n3c_dashboard.sev_map, n3c_dashboard.sex_map
	where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.severity = sev_map.severity
	  and n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.sex = sex_map.sex
	group by 1,2
	
	union
	
	select '1-'||severity_seq as source, '3-'||race_seq as target, sum(case when patient_count='<20' then 0 else patient_count::int end) as weight
	from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd, n3c_dashboard.sev_map, n3c_dashboard.race_map
	where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.severity = sev_map.severity
	  and n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.race = race_map.race
	group by 1,2
	
	union
	
	select '1-'||severity_seq as source, '4-'||ethnicity_seq as target, sum(case when patient_count='<20' then 0 else patient_count::int end) as weight
	from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd, n3c_dashboard.sev_map, n3c_dashboard.eth_map
	where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.severity = sev_map.severity
	  and n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.ethnicity = eth_map.ethnicity
	group by 1,2
	
	union
	
	select '2-'||sex_seq as source, '3-'||race_seq as target, sum(case when patient_count='<20' then 0 else patient_count::int end) as weight
	from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd, n3c_dashboard.sex_map, n3c_dashboard.race_map
	where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.sex = sex_map.sex
	  and n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.race = race_map.race
	group by 1,2
	
	union
	
	select '2-'||sex_seq as source, '4-'||ethnicity_seq as target, sum(case when patient_count='<20' then 0 else patient_count::int end) as weight
	from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd, n3c_dashboard.sex_map, n3c_dashboard.eth_map
	where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.sex = sex_map.sex
	  and n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.ethnicity = eth_map.ethnicity
	group by 1,2
	
	union
	
	select '3-'||race_seq as source, '4-'||ethnicity_seq as target, sum(case when patient_count='<20' then 0 else patient_count::int end) as weight
	from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd, n3c_dashboard.race_map, n3c_dashboard.eth_map
	where n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.race = race_map.race
	  and n3c_dashboard_ph.Demo_demo_ageidl_cov_csd.ethnicity = eth_map.ethnicity
	group by 1,2
	
	order by 3 desc;
</sql:query>
<c:forEach items="${edges.rows}" var="row" varStatus="rowCounter">
	{ "source":"${row.source}", "target":"${row.target}", "weight":${row.weight} }<c:if test="${!rowCounter.last}">,</c:if>
</c:forEach>

]
}
