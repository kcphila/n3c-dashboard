<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by visits))
	from (
		select 
		    number_of_visits_post_covid as visits, 
		    case
		        when (no_paxlovid::text = '<20' or no_paxlovid is null) then 0
		        else no_paxlovid::int
		        end as no_paxlovid, 
		    case
		        when (paxlovid::text = '<20' or paxlovid is null) then 0
		        else paxlovid::int
		        end as paxlovid
		from (
		    select number_of_visits_post_covid,
		        max(count) filter (where covid_w_pax = 0) as no_paxlovid,
		        max(count) filter (where covid_w_pax = 1) as paxlovid
		    from n3c_dashboard_ph.pax_postcovutil_csd
		    group by number_of_visits_post_covid
		    order by number_of_visits_post_covid
		) as foo
		where number_of_visits_post_covid < 101
	) as done;
</sql:query>

<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
</c:forEach>
