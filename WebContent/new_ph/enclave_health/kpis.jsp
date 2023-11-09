<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<c:choose>
	<c:when test="${param.block == 'enclave_health_1' }">
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/enclave_patients.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/enclave_health/preg_all.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/enclave_health/preg_view.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/enclave_health/preg_covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>	
	</c:when>
	<c:when test="${param.block == 'enclave_health_2' }">
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/enclave_patients.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/enclave_health/preg_all.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/enclave_health/preg_view_covid.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
	</c:when>
	<c:when test="${param.block == 'enclave_health_3' }">
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/enclave_patients.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/enclave_health/preg_all.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/enclave_health/preg_view.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
	</c:when>
</c:choose>



