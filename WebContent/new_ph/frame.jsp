<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="dashboard" uri="http://icts.uiowa.edu/N3CDashboardTagLib"%>

<script>
<jsp:include page="../feeds/configuration.jsp"/>
</script>

<jsp:include page="../graph_support/graphic_save.jsp"/>

<dashboard:dashboard did="${param.did}">
	<c:choose>
		<c:when test="${tag_dashboard.active}">
			<jsp:include page="${tag_dashboard.jsp}.jsp?did=${param.did}&tertiary_tab=${param.tertiary_tab}"/>
		</c:when>
		<c:otherwise>
			<jsp:include page="unavailable_panel.jsp"/>
		</c:otherwise>
	</c:choose>
</dashboard:dashboard>
