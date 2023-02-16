<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="col col-12 col-md-3 my-auto kpi_border_right">
	<jsp:include page="../kpis/block3_kpis/covid_positive.jsp">
		<jsp:param name="block" value="${param.block}" />
	</jsp:include>
</div>
<div class="col col-12 col-md-3 my-auto ">
	<jsp:include page="../kpis/block3_kpis/regions.jsp">
		<jsp:param name="block" value="${param.block}" />
	</jsp:include>

</div>
<div class="col col-12 col-md-3 my-auto ">
	<jsp:include page="../kpis/block3_kpis/regions2.jsp">
		<jsp:param name="block" value="${param.block}" />
	</jsp:include>
</div>
<div class="col col-12 col-md-3 my-auto ">
	<jsp:include page="../kpis/block3_kpis/regions3.jsp">
		<jsp:param name="block" value="${param.block}" />
	</jsp:include>
</div>
