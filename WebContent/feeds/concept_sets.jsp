<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select * from enclave_concept.zenodo_feed;
</sql:query>
{
    "headers": [
        {"value":"type", "label":"Type"},
        {"value":"title", "label":"Title"},
        {"value":"codeset_id", "label":"Codeset ID"},
        {"value":"doi", "label":"DOI"},
        {"value":"created_by", "label":"Created By"},
        {"value":"creator", "label":"Creator"},
        {"value":"limitations", "label":"Limitations"},
        {"value":"published", "label":"published"}
    ],
    "rows" : 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			