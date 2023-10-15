<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html>
<html>

<style>
.section{
	margin-bottom:100px;
}}
</style>

<jsp:include page="head.jsp">
	<jsp:param name="page" value="Enclave Concept Sets"/>
</jsp:include>

<body>
	<jsp:include page="navbar.jsp" flush="true"/>
	
	<div class="container container-large content">
		<jsp:include page="overview/concept_sets/concept_sets.jsp" flush="true" />
	</div>
	
	

	<jsp:include page="footer.jsp" flush="true" />
	
</body>
</html>
