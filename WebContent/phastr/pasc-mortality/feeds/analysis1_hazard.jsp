<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_pretty(jsonb_agg(foo)) as foo
from
     (select
     	term as element,
     	to_char(coef, 'FM99.0000')::float as estimate,
     	to_char(exp_coef, 'FM99.0000')::float as exp_coef,
     	to_char(se_coef, 'FM99.0000')::float as se_coef,
     	to_char(z, 'FM999.0000')::float as z,
     	p,
     	case when x____log2p = 'Infinity' then 'Infinity' else to_char(x____log2p::float, 'FM999.0000') end as x____log2p,
     	to_char(lower95_, 'FM99.0000')::float as conf_low,
     	to_char(upper95_, 'FM99.0000')::float as conf_high
     from phastr_pasc.analysis1_hazard_ratio_data) as foo;
</sql:query>

{
    "headers": [
    	{"value":"element", "label":"Term"},
        {"value":"estimante", "label":"Coef"},
        {"value":"exp_coef", "label":"Exp Coef"},
        {"value":"se_coef", "label":"SE Coef"},
        {"value":"z", "label":"Z"},
        {"value":"p", "label":"P"},
        {"value":"x____log2p", "label":"Log2p"},
        {"value":"conf_low", "label":"Lower 95%"},
        {"value":"conf_high", "label":"Upper 95%"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       