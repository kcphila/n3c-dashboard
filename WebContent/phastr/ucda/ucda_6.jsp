<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="balance-proportion" />
	<jsp:param name="block_header" value="Proportions" />

	<jsp:param name="did" value="930" />
	
	<jsp:param name="simple_panel" value="ucda/tables/balance_proportion.jsp" />
</jsp:include>
