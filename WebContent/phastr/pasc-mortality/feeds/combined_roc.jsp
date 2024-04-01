<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
     (select
     	to_char(false_positive_rate, 'FM99.0000')::float as false_positive_rate,
     	to_char(true_positive_rate, 'FM99.0000')::float as true_positive_rate,
     	to_char(lowerlimit_trueposrate, 'FM99.0000')::float as lowerlimit_trueposrate,
     	to_char(upperlimit_trueposrate, 'FM99.0000')::float as upperlimit_trueposrate,
     	to_char(auc, 'FM99.0000')::float as auc,
     	to_char(auc_halfwidth, 'FM99.0000')::float as auc_halfwidth,
     	cohort
     from phastr_pasc.combined_cohort_roc) as foo;
</sql:query>

{
    "headers": [
    	{"value":"false_positive_rate", "label":"False Positive Rate"},
        {"value":"true_positive_rate", "label":"True Positive Rate"},
        {"value":"lowerlimit_trueposrate", "label":"Lower Limit True Positive Rate"},
        {"value":"upperlimit_trueposrate", "label":"Upper Limit True Positive Rate"},
        {"value":"auc", "label":"AUC"},
        {"value":"auc_halfwidth", "label":"AUC Halfwidth"},
        {"value":"cohort", "label":"Cohort"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       