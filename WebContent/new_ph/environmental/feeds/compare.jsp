<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select label, part, total
		from (
			select
				'All Patient Mortality' as label,
				sum(mortality) + sum(nomortality) as total,
				sum(mortality) as part
				from (
			  		select 
			  			case when death_indicator = 1 then patient_count end as mortality,
			  			case when death_indicator = 0 then patient_count end as nomortality
			  			from n3c_dashboard_ph.demo_mort_all_csd
				) as fa
		
			UNION 
			
			select
				'Environmentally Impacted Patient Mortality' as label,
				sum(total) as total,
				sum(mortality) as part
				from (
			  		select 
				  		case
							when (patient_count = '<20' or patient_count is null) then 0
							else patient_count::int
						end as total,
						case
							when (patient_count_died = '<20' or patient_count_died is null) then 0
							else patient_count_died::int
						end as mortality
				  		from n3c_dashboard_ph.env_mortcnt_all_csd
				) as fa
				
			UNION 
			
			select
				'All COVID+ Patient Mortality' as label,
				sum(mortality) + sum(nomortality) as total,
				sum(mortality) as part
				from (
			  		select 
					  	case when covid_patient_death_indicator = 1 then patient_count end as mortality,
					  	case when covid_patient_death_indicator = 0 then patient_count end as nomortality
					  	from n3c_dashboard_ph.demo_mort_cov_csd
				) as fa
				
			UNION 
			
			select
				'Environmentally Impacted COVID+ Patient Mortality' as label,
				sum(total) as total,
				sum(mortality) as part
				from (
			  		select 
				  		case
							when (patient_count = '<20' or patient_count is null) then 0
							else patient_count::int
						end as total,
						case
							when (patient_count_died = '<20' or patient_count_died is null) then 0
							else patient_count_died::int
						end as mortality
				  		from n3c_dashboard_ph.env_mortcnt_cov_csd
				  		where covid_indicator = 1
				) as fa
				
			UNION 
			
			select
				'All COVID+ Patient Long COVID' as label,
				sum(case when long = '<20' then 0 else long::int end) + sum(case when nolong = '<20' then 0 else nolong::int end) as total,
				sum(case when long = '<20' then 0 else long::int end) as part
				from (
			  		select 
				  		case when long_covid_indicator = 1 then patient_count end as long,
					  	case when long_covid_indicator = 0 then patient_count end as nolong
					  	from n3c_dashboard_ph.demo_demo_mort_sev_vacc_all_covid_csd
					  	where covid_indicator = 1
				) as fa
				
			UNION 
			
			select
				'Environmentally Impacted COVID+ Patient Long COVID' as label,
				sum(case when long = '<20' then 0 else long::int end) + sum(case when nolong = '<20' then 0 else nolong::int end) as total,
				sum(case when long = '<20' then 0 else long::int end) as part
				from (
			  		select 
				  		case when long_covid_diagnosis_post_covid_indicator = 1 then patient_count end as long,
					  	case when long_covid_diagnosis_post_covid_indicator = 0 then patient_count end as nolong
					  	from n3c_dashboard_ph.env_envsxmortvac_all_csd
					  	where covid_indicator = 1
				) as fa
			
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
