<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
     (select outcome as element, 
     ROUND(estimate::numeric, 4) as reg_estimate, 
     ROUND(se::numeric, 4) as se, 
     ROUND(statistic::numeric, 4) as statistic,
     p_value,
     ROUND(exp_estimate::numeric, 4) as estimate,
     ROUND(ll::numeric, 4) as conf_low,
     ROUND(ul::numeric, 4) as conf_high
     from phastr_ucda.reg_ipw_inpatient) as foo;
</sql:query>

{
    "headers": [
     	{"value":"element", "label":"Term"},
        {"value":"reg_estimate", "label":"Estimate"},
        {"value":"se", "label":"SE"},
        {"value":"statistic", "label":"Statistic"},
        {"value":"p_value", "label":"p Value"}, 
        {"value":"estimate", "label":"Exp Estimate"}, 
        {"value":"conf_low", "label":"Lower 95%"}, 
        {"value":"conf_high", "label":"Upper 95%"}
       
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       