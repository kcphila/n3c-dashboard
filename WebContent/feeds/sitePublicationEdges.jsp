<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:query var="sites" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(foo)) from (
		select source,target,count	 from n3c_collaboration.publication_edge
	) as foo;
</sql:query>

{
  "edges":
	<c:forEach items="${sites.rows}" var="row" varStatus="rowCounter">
		${row.jsonb_pretty}
	</c:forEach>
}
