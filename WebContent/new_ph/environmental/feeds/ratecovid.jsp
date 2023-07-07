<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select 
				'All COVID+ Patient Mortality %' as label,
				1 as label_seq,
				total, 
				mortality,
				ROUND((mortality::decimal / total)*100, 2) as patient_count, 
				ROUND((mortality::decimal / total)*100, 2) as patient_display 
				from (select
						sum(mortality) + sum(nomortality) as total,
						sum(mortality) as mortality
					  from (
					  	select 
					  		case when covid_patient_death_indicator = 1 then patient_count end as mortality,
					  		case when covid_patient_death_indicator = 0 then patient_count end as nomortality
					  		from n3c_dashboard_ph.demo_mort_cov_csd
					  ) as fa
			  	) as foo
			
			UNION
			
			select 
				'Environmental COVID+ Mortality %' as label,
				2 as label_seq,
				total, 
				mortality,
				ROUND((mortality::decimal / total)*100, 2) as patient_count, 
				ROUND((mortality::decimal / total)*100, 2) as patient_display 
				from (select
						sum(total) as total,
						sum(mortality) as mortality
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
			  	) as foo
			
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"label", "label":"Label"},
        {"value":"label_seq", "label":"dummy1"},
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
