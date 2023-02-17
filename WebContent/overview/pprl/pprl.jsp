<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="pprl" />
	<jsp:param name="block_header" value="Privacy-Preserving Record Linkage" />

	<jsp:param name="did" value="142" />
	
	<jsp:param name="simple_panel" value="pprl/pprl_includes.jsp" />
</jsp:include>
