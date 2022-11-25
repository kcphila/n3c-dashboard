<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:query var="sites" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(foo)) from (
		select org_type,count(*) from n3c_collaboration.collaboration_organization group by 1 order by 2 desc
	) as foo;
</sql:query>

{
  "sites":
	<c:forEach items="${sites.rows}" var="row" varStatus="rowCounter">
		${row.jsonb_pretty}
	</c:forEach>
}
