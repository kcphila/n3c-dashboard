<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
     (select
     	term as element,
     	to_char(estimate, 'FM99.0000')::float as estimate,
     	p_value,
     	to_char(conf_low, 'FM99.0000')::float as conf_low,
     	to_char(conf_high, 'FM99.0000')::float as conf_high,
     	pval_signif
     from phastr_pasc.analysis1_or_plot_data) as foo;
</sql:query>

{
    "headers": [
    	{"value":"element", "label":"Term"},
        {"value":"estimate", "label":"Estimate"},
        {"value":"p_value", "label":"p Value"},
        {"value":"conf_low", "label":"Confidence Low"},
        {"value":"conf_high", "label":"Confidence High"},
        {"value":"pval_signif", "label":"p Value Significant"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       