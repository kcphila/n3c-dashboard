<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_pretty(jsonb_agg(foo)) as foo
from
     (select term,coef,exp_coef,se_coef,z,p,x____log2p,lower95_,upper95_ from phastr_pasc.analysis1_hazard_ratio_data) as foo;
</sql:query>

{
    "headers": [
    	{"value":"term", "label":"Term"},
        {"value":"coef", "label":"Coef"},
        {"value":"exp_coef", "label":"Exp Coef"},
        {"value":"se_coef", "label":"SE Coef"},
        {"value":"z", "label":"Z"},
        {"value":"p", "label":"P"},
        {"value":"x____log2p", "label":"Log2p"},
        {"value":"lower95_", "label":"Lower 95%"},
        {"value":"upper95_", "label":"Upper 95%"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       