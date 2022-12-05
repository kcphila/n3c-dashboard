<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html>
<html>

<style>
.section{
	margin-bottom:100px;
}

.section-description{
	margin-top: 30px;
	margin-bottom: 60px;
}
</style>

<jsp:include page="head.jsp" flush="true" />

<body>
	<jsp:include page="navbar.jsp" flush="true"/>
	
	<div class="container container-large content">
		<div class="row page-title">
			<div class="col-12">
				<h1>Site and User Metrics</h1>
			</div>
		</div>
			
		<div class="section section-viz">
			<div class="row">
				<div class="col-12">
					<p class="section-description heading-text text-max mx-auto">
					The N3C Data Enclave is always open to new users and institutional data partners. Institutions can support the work of 
					N3C by becoming a clinical data partner and executing a <a href="https://covid.cd2h.org/for-institutions">Data Transfer Agreement (DTA)</a> or by facilitating Enclave access 
					for their members by implementing a <a href="https://ncats.nih.gov/n3c/resources/data-access">Data Use Agreement (DUA)</a>.</p>
				</div>
			</div>
			<div class="row">
				<div class="col-12 col-lg-6">
					<c:import url="admin/institutions.jsp"/>
				</div>
				<div class="col-12 col-lg-6">
					<c:import url="admin/users.jsp"/>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp" flush="true" />
	<c:import url="modules/popover_init.jsp"/>
</body>
</html>