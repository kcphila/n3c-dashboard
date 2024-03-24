<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
     (select term,estimate,se,statistic,p_value,exp_estimate,ll,ul,outcome from phastr_ucda.reg_ipw_inpatient) as foo;
</sql:query>

{
    "headers": [
    	{"value":"term", "label":"Term"},
        {"value":"estimate", "label":"Estimate"},
        {"value":"se", "label":"SE"},
        {"value":"statistic", "label":"Statistic"},
        {"value":"p_value", "label":"p Value"}, 
        {"value":"exp_estimate", "label":"Exp Estimate"}, 
        {"value":"ll", "label":"LL"}, 
        {"value":"ul", "label":"UL"}, 
        {"value":"outcome", "label":"Outcome"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       