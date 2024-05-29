<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
     (select variable, treatment, 
     case when before_after_weighting = 'Before Weighting' Then 'Before'
     Else 'After' End as before_after_weighting, proportion from phastr_ucda.balance_proportion_plot order by 3 desc) as foo;
	</sql:query>

{
    "headers": [
    	{"value":"variable", "label":"Variable"},
        {"value":"treatment", "label":"Treatment"},
        {"value":"before_after_weighting", "label":"Before/After Weighting"},
        {"value":"proportion", "label":"Proportion"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       