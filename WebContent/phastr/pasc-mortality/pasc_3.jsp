<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="analysis1-hazard" />
	<jsp:param name="block_header" value="Analysis 1 Hazard" />

	<jsp:param name="did" value="929" />
	
	<jsp:param name="simple_panel" value="pasc-mortality/tables/combined_roc.jsp" />
</jsp:include>