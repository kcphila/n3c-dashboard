<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<c:choose>
	<c:when test="${param.block == 'med_snap_1'}">
		<div class="col col-12 col-md-6 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/sotrovimab_demo.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'med_snap_2'}">
		<div class="col col-12 col-md-6 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/sotrovimab_diagnosis.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'med_snap_3'}">
		<div class="col col-12 col-md-6 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/sotrovimab_meds.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'med_snap_4'}">
		<div class="col col-12 col-md-6 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/sotrovimab_comor.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'med_snap_5'}">
		<div class="col col-12 col-md-6 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/sotrovimab_vac.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>		
	</c:when>
</c:choose>
