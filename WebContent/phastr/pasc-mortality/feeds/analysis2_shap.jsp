<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
     (select variable,to_char(shap_abs::float, 'FM99.0000')::float as shap_abs,cohort from phastr_pasc.analysis2_combined_cohort_shap_values) as foo;
</sql:query>

{
    "headers": [
    	{"value":"variable", "label":"Variable"},
        {"value":"shap_abs", "label":"shap abs"},
        {"value":"cohort", "label":"Cohort"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       