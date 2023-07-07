<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select environmental_factor, status, mortality, patient_display, patient_count, status_abbrev, status_seq, mortality_abbrev, mortality_seq
		from (
			select 
				env_factor as environmental_factor, 
				case
					when (covid_indicator = 1) then 'Positive'
					else 'Unknown'
				end as status,
				'Mortality' as mortality,
				case
					when (patient_count_died = '<20' or patient_count_died is null) then 0
					else patient_count_died::int
				end as patient_count, 
				patient_count_died as patient_display
			from n3c_dashboard_ph.env_mortcnt_cov_csd
			where env_factor is not null 
			and patient_count != '<20'
			
			UNION 
			
			select 
				env_factor as environmental_factor, 
				case
					when (covid_indicator = 1) then 'Positive'
					else 'Unknown'
				end as status,
				'No Mortality' as mortality,
				case
					when (patient_count = '<20' or patient_count is null) then 0
					when (patient_count_died = '<20' or patient_count_died is null) then patient_count::int
					else (patient_count::int - patient_count_died::int)
				end as patient_count, 
				patient_count_died as patient_display
			from n3c_dashboard_ph.env_mortcnt_cov_csd
			where env_factor is not null
			and patient_count != '<20'
			
			order by mortality
			) as foo
		natural join n3c_dashboard.covidstatus_map
		natural join n3c_dashboard.mortality_map
		
		
		
		
	)as done ;
</sql:query>
{
    "headers": [
        {"value":"environmental_factor", "label":"Environmental Factor"},
        {"value":"status", "label":"COVID Status"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"dummy0"},
        {"value":"status_abbrev", "label":"dummy1"},
        {"value":"status_seq", "label":"dummy2"},
        {"value":"mortality_abbrev", "label":"dummy3"},
        {"value":"mortality_seq", "label":"dummy4"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
