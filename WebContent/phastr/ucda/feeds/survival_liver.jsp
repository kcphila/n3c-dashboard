<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
     (select timeline,survival_proportion,ul,ll,x__group from phastr_ucda.survival_plot_liverdisease_km_data) as foo;
</sql:query>

{
    "headers": [
    	{"value":"timeline", "label":"Timeline"},
        {"value":"survival_proportion", "label":"Survival Proportion"},
        {"value":"ul", "label":"UL"},
        {"value":"ll", "label":"LL"},
        {"value":"x__group", "label":"Group"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       