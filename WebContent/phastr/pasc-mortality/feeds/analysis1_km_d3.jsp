<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select json_agg(foo) as bar from (
	select timeline,json_object_agg(x__group, to_char(survival, 'FM99.0000')::float) as elements
	from phastr_pasc.analysis1_km_plot_data_combined_aggregated where timeline<2000 group by 1 order by 1) as foo;
</sql:query>
<c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	${row.bar}
</c:forEach>
