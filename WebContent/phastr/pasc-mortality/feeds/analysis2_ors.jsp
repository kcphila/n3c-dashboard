<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
     (select term,estimate,std_error,statistic,p_value,conf_low,conf_high,cohort from phastr_pasc.analysis2_combined_cohorts_logreg_ors) as foo;
</sql:query>

{
    "headers": [
    	{"value":"term", "label":"Term"},
        {"value":"estimate", "label":"Estimate"},
        {"value":"std_error", "label":"Std Error"},
        {"value":"statistic", "label":"Statistic"},
        {"value":"p_value", "label":"p Value"},
        {"value":"conf_low", "label":"Confidence Low"},
        {"value":"conf_high", "label":"Confidence High"},
        {"value":"cohort", "label":"Cohort"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       