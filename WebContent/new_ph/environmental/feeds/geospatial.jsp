<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select statename,countyname,cityname,postal_code,
		case
			when non_count is null then 0
			when non_count = '<20' then 0
			else non_count::int
		end as non_count,
		case
			when covid_count is null then 0
			when covid_count = '<20' then 0
			else covid_count::int
		end as covid_count,
		patient_count_died,
		patient_count_died_cause_covid,
		latitude,
		longitude,
		param_list
		from (
			(select statename,countyname,cityname,postal_code,patient_count_of_this_city as non_count,patient_count_died,patient_count_died_cause_covid,param_list
				from n3c_dashboard_ph.env_stcntctzipprmlist_cnt_csd where covid_indicator =0) as foo
			natural full outer join
			(select statename,countyname,cityname,postal_code,patient_count_of_this_city as covid_count,patient_count_died,patient_count_died_cause_covid,param_list
				from n3c_dashboard_ph.env_stcntctzipprmlist_cnt_csd where covid_indicator =1) as bar
		) as foo2,
		n3c_maps.zipcode
		where postal_code = zipcode
	)as done;
</sql:query>
{
    "headers": [
        {"value":"statename", "label":"State"},
        {"value":"countname", "label":"County"},
        {"value":"cityname", "label":"City"},
        {"value":"postal_code", "label":"Zip Code"},
        {"value":"non_count", "label":"COVID- Patients"},
        {"value":"covid_count", "label":"COVID+ Patients"},
        {"value":"patient_count_died", "label":"Mortality"},
        {"value":"patient_count_died_cause_covid", "label":"Mortality due to COVID"},
        {"value":"latitude", "label":"Latitude"},
        {"value":"longitude", "label":"Longitude"},
		{"value":"param_list", "label":"Environmental Factors"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
