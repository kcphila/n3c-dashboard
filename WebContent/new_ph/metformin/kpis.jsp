<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<c:choose>
	<c:when test="${param.block == 'metformin_1' }">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/enclave_patients.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/metformin_view.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/metformin_covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/metformin_long_covid.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/metformin_vaccination.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/metformin_mortality.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>	
	</c:when>
	<c:when test="${param.block == 'metformin_2' || param.block == 'metformin_3' || param.block == 'metformin_4'}">
		<div class="col col-12 col-md-4 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/enclave_patients.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-4 my-auto">
			<jsp:include page="../kpis/block3_kpis/met_view.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-4 my-auto">
			<jsp:include page="../kpis/block3_kpis/metmet_view.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/metnomet_view.jsp">
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>	
	</c:when>
	<c:when test="${param.block == 'metformin_5' }">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/enclave_patients.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/metformin_view_diab.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/metformin_covid_positive_diab.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/metformin_long_covid_diab.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/metformin_vaccination_diab.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/metformin_mortality_diab.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>	
	</c:when>
	<c:when test="${param.block == 'metformin_6' || param.block == 'metformin_7' || param.block == 'metformin_8'}">
		<div class="col col-12 col-md-4 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/enclave_patients.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-4 my-auto">
			<jsp:include page="../kpis/block3_kpis/metdiabetes_view.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-4 my-auto">
			<jsp:include page="../kpis/block3_kpis/metdiabetesmet_view.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
			<jsp:include page="../kpis/block3_kpis/metdiabetesnomet_view.jsp">
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>	
	</c:when>
</c:choose>



