<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select
			code,
			statename,
			countyname,
			param_list,
			sum(non_count) as non_count,
			sum(covid_count) as covid_count,
			sum(patient_count_died) as patient_count_died,
			sum(patient_count_died_cause_covid) as patient_count_died_cause_covid
		from
			(select
				code,
				statename,
				countyname,
				param_list,
				coalesce(non_count, 0) as non_count,
				coalesce(covid_count, 0) as covid_count,
				patient_count_died,
				patient_count_died_cause_covid
				from (
					(select statename,countyname,param_list,
							case
								when patient_count_of_this_city = '<20' then 1
								else patient_count_of_this_city::int
							end as non_count,
							case
								when patient_count_died = '<20' then 1
								else patient_count_died::int
							end as patient_count_died,
							case
								when patient_count_died_cause_covid = '<20' then 1
								else patient_count_died_cause_covid::int
							end as patient_count_died_cause_covid
						from n3c_dashboard_ph.env_stcntctzipprmlist_cnt_csd where covid_indicator = 0) as foo
					natural full outer join
					(select statename,countyname,param_list,
							case
								when patient_count_of_this_city = '<20' then 1
								else patient_count_of_this_city::int
							end as covid_count,
							case
								when patient_count_died = '<20' then 1
								else patient_count_died::int
							end as patient_count_died,
							case
								when patient_count_died_cause_covid = '<20' then 1
								else patient_count_died_cause_covid::int
							end as patient_count_died_cause_covid
						from n3c_dashboard_ph.env_stcntctzipprmlist_cnt_csd where covid_indicator = 1) as bar
				) as foo2,
				n3c_maps.state_code
				where statename = state
			) as bar
		group by 1,2,3,4
	)as done;
</sql:query>
{
    "headers": [
        {"value":"code", "label":"State Code"},
        {"value":"statename", "label":"State"},
        {"value":"countname", "label":"County"},
        {"value":"param_list", "label":"Param List"},
        {"value":"non_count", "label":"COVID- Patients"},
        {"value":"covid_count", "label":"COVID+ Patients"},
        {"value":"patient_count_died", "label":"Mortality"},
        {"value":"patient_count_died_cause_covid", "label":"Mortality due to COVID"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
