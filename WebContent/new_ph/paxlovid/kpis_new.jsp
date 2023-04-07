<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<c:choose>
	<c:when test="${param.block == 'paxlovid_4' }">
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/enclave_patients.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-4 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive_secondary.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/paxlovid_total.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-5 my-auto">
			<jsp:include page="../kpis/block3_kpis/paxlovid_covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/paxlovid_view.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
	</c:when>
	<c:when test="${param.block == 'paxlovid_5' }">
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/enclave_patients.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-4 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive_secondary.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/paxlovid_total.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-5 my-auto">
			<jsp:include page="../kpis/block3_kpis/paxlovid_covid_positive_vac.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/paxlovid_view_vac.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
	</c:when>
	<c:when test="${param.block == 'paxlovid_6' }">
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/enclave_patients.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-4 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive_secondary.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/paxlovid_total.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-5 my-auto">
			<jsp:include page="../kpis/block3_kpis/paxlovid_covid_positive_visits.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/paxlovid_view_visits.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
	</c:when>
</c:choose>



