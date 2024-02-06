<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="projects" dataSource="jdbc/N3CPublic">
	select * from n3c_pubs.publication_feed;
</sql:query>
{
    "headers": [
    	{"value":"id", "label":"id"},
        {"value":"title", "label":"Title"},
        {"value":"type", "label":"Type"},
        {"value":"url", "label":"URL"},
        {"value":"outlet", "label":"Outlet"},
        {"value":"date", "label":"Date"},
        {"value":"authors", "label":"Authors"}
    ],
    "rows" : 
<c:forEach items="${projects.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
