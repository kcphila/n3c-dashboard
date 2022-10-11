<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script>
<jsp:include page="../feeds/configuration.jsp"/>
</script>

<jsp:include page="../graph_support/pieChart_local.jsp"/>
<jsp:include page="../graph_support/percentage_bar_local.jsp"/>
<jsp:include page="../graph_support/horizontalBarChart_local.jsp"/>
<jsp:include page="../graph_support/horizontalBarChart_local2.jsp"/>
<jsp:include page="../graph_support/horizontalStackedBarChart_local.jsp"/>
<jsp:include page="../graph_support/horizontalStackedBarChart_local_percent.jsp"/>
<jsp:include page="../graph_support/time_line_2_column_local2.jsp"/>
<jsp:include page="../graph_support/hive_local.jsp"/>
<jsp:include page="../graph_support/time_line_n_column_local.jsp"/>

<jsp:include page="../graph_support/grouped_stacked_bar_horizontal_alexis_local.jsp"/>

<jsp:include page="../graph_support/grouped_bar_horizontal_local.jsp"/>
<jsp:include page="../graph_support/grouped_bar_horizontal_percentage_local.jsp"/>

<jsp:include page="../graph_support/region_map_local.jsp"/>

<jsp:include page="../graph_support/verticalBarChart_local.jsp"/>
<jsp:include page="../graph_support/mortalityBarChart_local.jsp"/>
<jsp:include page="../graph_support/graphic_save.jsp"/>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select roster_map.* from n3c_dashboard.roster_map natural join n3c_questions.roster order by seqnum;
</sql:query>
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	<c:choose>
		<c:when test="${param.frame == row.iframe_info && row.mode == 'D3'}">
			<jsp:include page="${row.jsp}.jsp?tertiary_tab=${param.tertiary_tab}"/>
		</c:when>
		<c:when test="${param.frame == row.iframe_info && row.mode == 'Qlik'}">
			<jsp:include page="panel_qlik.jsp">
				<jsp:param name="iframe" value="${row.iframe_info}" />
			</jsp:include>
		</c:when>
		<c:when test="${param.frame == row.iframe_info && row.mode == 'unavailable'}">
			<jsp:include page="unavailable_panel.jsp"/>
		</c:when>
		<c:when test="${param.frame == row.iframe_info}">
			${param.frame}
		</c:when>
	</c:choose>
</c:forEach>
