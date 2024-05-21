<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
	(select timeline,
		x__group,
		ROUND(survival_proportion::numeric, 4) as survival,
		Round(ul::numeric, 4) as survival_upper_0_95,
		Round(ll::numeric, 4) as survival_lower_0_95
     from phastr_ucda.survival_plot_liverdisease_km_data) as foo;
</sql:query>

{
    "headers": [
    	{"value":"timeline", "label":"Timeline"},
    	{"value":"x__group", "label":"Group"},
        {"value":"survival", "label":"Survival"},
        {"value":"survival_upper_0_95", "label":"Survival Upper 0.95"},
        {"value":"survival_lower_0_95", "label":"Survival Lower 0.95"}
        
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       