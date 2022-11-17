<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:query var="sites" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(foo)) from (
		select ror_name as 	site,ror_id as id,org_type as type,count,latitude,longitude from n3c_collaboration.organization_map
	) as foo;
</sql:query>

{
  "sites":
	<c:forEach items="${sites.rows}" var="row" varStatus="rowCounter">
		${row.jsonb_pretty}
	</c:forEach>
}
