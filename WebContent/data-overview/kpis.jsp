<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body kpi-section">
	<div class="row kpi-row">
		<div class="col col-5 m-auto">
			<jsp:include page="kpis/enclave_patients.jsp"/>
		</div>
		
		<div class="col col-7" style="border-left: 2px solid #d0e3f6;">
			<c:choose>
				<c:when test="${param.page == 'demographics' }">
					<jsp:include page="kpis/demographics.jsp"/>
				</c:when>
			</c:choose>	
			<c:choose>
				<c:when test="${param.page == 'demographics-comorbidities' }">
					<jsp:include page="kpis/demographics-comorbidities.jsp"/>
				</c:when>
			</c:choose>	
		</div>
	</div>
</div>