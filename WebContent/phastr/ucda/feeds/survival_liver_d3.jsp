<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from (select generate_series as timeline,
		json_object_agg(x__group, Concat(round(survival_proportion::numeric,4), ',', round(ul::numeric, 4), ',', round(ll::numeric, 4)))  as elements
     from (select 
				generate_series,
				'UDCA' as x__group,
				coalesce(survival_proportion, (
					select survival_proportion from phastr_ucda.survival_plot_liverdisease_km_data
					where timeline < generate_series and x__group = 'UDCA'
					order by timeline desc limit 1
				)) as survival_proportion ,
				coalesce(ul, (
					select ul from phastr_ucda.survival_plot_liverdisease_km_data
					where timeline < generate_series and x__group = 'UDCA'
					order by timeline desc limit 1
				)) as ul ,
				coalesce(ll, (
					select ll from phastr_ucda.survival_plot_liverdisease_km_data
					where timeline < generate_series and x__group = 'UDCA'
					order by timeline desc limit 1
				)) as ll 
			from (select generate_series(0,30)) a
			left join (select x__group, survival_proportion, ul, ll, timeline from phastr_ucda.survival_plot_liverdisease_km_data where x__group = 'UDCA') b on a.generate_series = b.timeline 
			UNION
			select 
				generate_series,
				'No UDCA' as x__group,
				coalesce(survival_proportion, (
					select survival_proportion from phastr_ucda.survival_plot_liverdisease_km_data
					where timeline < generate_series and x__group = 'No UDCA'
					order by timeline desc limit 1
				)) as survival_proportion ,
				coalesce(ul, (
					select ul from phastr_ucda.survival_plot_liverdisease_km_data
					where timeline < generate_series and x__group = 'No UDCA'
					order by timeline desc limit 1
				)) as ul ,
				coalesce(ll, (
					select ll from phastr_ucda.survival_plot_liverdisease_km_data
					where timeline < generate_series and x__group = 'No UDCA'
					order by timeline desc limit 1
				)) as ll 
			from (select generate_series(0,30)) a
			left join (select x__group, survival_proportion, ul, ll, timeline from phastr_ucda.survival_plot_liverdisease_km_data where x__group = 'No UDCA') b on a.generate_series = b.timeline)
	group by 1 order by 1
) as foo;
</sql:query>


<c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
    ${row.foo}
</c:forEach>


       