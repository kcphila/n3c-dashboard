<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="elements" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select * from ${param.schema}.${param.table}
	) as done
</sql:query>
<c:forEach items="${elements.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
			