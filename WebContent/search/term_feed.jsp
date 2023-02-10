<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select string_agg('"'||tag||'"', ', ') as tags from n3c_dashboard.tag_definition ;
</sql:query>
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	var keywords = [${row.tags}];
</c:forEach>
			