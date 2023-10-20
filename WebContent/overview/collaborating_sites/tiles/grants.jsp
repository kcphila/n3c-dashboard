<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<div class="col-3 card">
	<h4 class="nav-card">Grants Mentioning N3C</h4>
	<sql:query var="grants" dataSource="jdbc/N3CPublic">
		select count(*),sum(award_amount)
		from nih_exporter_current.ror_binding natural join nih_exporter_current.n3c
		where ror_id = ?
		<sql:param>${param.ror}</sql:param>
	</sql:query>
	<c:forEach items="${grants.rows}" var="row" varStatus="rowCounter">
		<c:set var="award_count" value="${row.count}"/>
		<c:set var="amount" value="${row.sum}"/>
	</c:forEach>
	<sql:query var="grants" dataSource="jdbc/N3CPublic">
		select count(*) from n3c_collaboration.subcontracts where subaward_ror = ?
		<sql:param>${param.ror}</sql:param>
	</sql:query>
	<c:forEach items="${grants.rows}" var="row" varStatus="rowCounter">
		<c:set var="subcontract_count" value="${row.count}"/>
	</c:forEach>
	<c:choose>
		<c:when test="${award_count == 0 && subcontract_count == 0 }">
			<p>No data</p>
		</c:when>
		<c:otherwise>
			<c:if test="${award_count > 0}">
				<p>${award_count} awards, <fmt:formatNumber value="${amount}" type="currency"/> total amount</p>
			</c:if>
			<c:if test="${subcontract_count > 0}">
				<p>${subcontract_count} subcontracts</p>
			</c:if>
		</c:otherwise>
	</c:choose>
</div>
