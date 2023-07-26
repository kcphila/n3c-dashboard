<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select feature from zipcode.zip3 where zipcode in (select postal_code from n3c_dashboard_ph.env_stcntctzipprmlist_cnt_csd)
	union
	select feature from zipcode.zip5 where zipcode in (select postal_code from n3c_dashboard_ph.env_stcntctzipprmlist_cnt_csd)
</sql:query>
{"type":"FeatureCollection","features": [
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.feature}<c:if test="${!rowCounter.last}">,</c:if>
</c:forEach>
]}
