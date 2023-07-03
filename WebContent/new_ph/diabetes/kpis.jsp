<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<c:choose>
	<c:when test="${param.block == 'diabetes_1' }">
		<jsp:include page="../kpis/block2_kpis/diabetes2.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes2_covid.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes2_before.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes2_after.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes2_thirty.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
	</c:when>
	<c:when test="${param.block == 'diabetes_2' }">
		<jsp:include page="../kpis/block2_kpis/diabetes1.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes1_covid.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes1_before.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes1_after.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes1_thirty.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
	</c:when>
	<c:when test="${param.block == 'diabetes_3' }">
		<jsp:include page="../kpis/block2_kpis/covid_positive.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes1.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes_total_under_18.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes_under_18.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
	</c:when>
	<c:when test="${param.block == 'diabetes_4' }">
		<jsp:include page="../kpis/block2_kpis/covid_positive.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes2.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes_total_under_18.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes_under_18.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
	</c:when>
	<c:when test="${param.block == 'diabetes_5' }">
		<jsp:include page="../kpis/block2_kpis/covid_positive.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes1.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes_total_over_18.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
		<jsp:include page="../kpis/block2_kpis/diabetes_over_18.jsp">
			<jsp:param name="block" value="${param.block}" />
		</jsp:include>
	</c:when>
	<c:when test="${param.block == 'diabetes_6' }">
		<div class="col col-12 col-md-6 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/diabetes2.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/diabetes_over_18.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
	</c:when>
</c:choose>

