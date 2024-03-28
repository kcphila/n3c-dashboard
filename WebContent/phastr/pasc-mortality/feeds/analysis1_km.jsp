<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
     (select
     	timeline,
     	x__group,
     	to_char(survival, 'FM99.0000')::float as survival,
     	case when survival_upper_0_95 = 'null' then 0.0 else to_char(survival_upper_0_95::float, 'FM99.0000')::float end as survival_upper_0_95,
     	case when survival_lower_0_95 = 'null' then 0.0 else to_char(survival_lower_0_95::float, 'FM99.0000')::float end as survival_lower_0_95
     from phastr_pasc.analysis1_km_plot_data_combined_aggregated) as foo;
</sql:query>

{
    "headers": [
    	{"value":"timeline", "label":"Timeline"},
        {"value":"x__group", "label":"Group"},
        {"value":"survival", "label":"Survival"},
        {"value":"survival_upper_0_95", "label":"Survival Upper 0.95"},
        {"value":"survival_lower_0_95", "label":"survival Lower 0.95"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       