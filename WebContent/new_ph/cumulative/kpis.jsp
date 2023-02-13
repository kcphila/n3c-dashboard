<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<c:choose>
	<c:when test="${param.block == 'cumulative_1' }">
		<div class="col col-12 col-md-3 my-auto ">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto ">
			<jsp:include page="../kpis/block2_kpis/cumulative_total.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-2 my-auto ">
			<jsp:include page="../kpis/block2_kpis/cumulative_non.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-2 my-auto ">
			<jsp:include page="../kpis/block2_kpis/cumulative_hisp.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-2 my-auto ">
			<jsp:include page="../kpis/block2_kpis/cumulative_unkn.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
	</c:when>
	<c:when test="${param.block == 'cumulative_2' }">
		<div class="col col-12 col-md-6 my-auto ">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
		<div class="col col-12 col-md-6 my-auto ">
			<jsp:include page="../kpis/block2_kpis/cumulative_total2.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>
	</c:when>
</c:choose>

