<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="users" />
	<jsp:param name="block_header" value="Site and User Metrics" />

	<jsp:param name="did" value="68" />
	
	<jsp:param name="simple_panel" value="users/graph_includes.jsp" />
</jsp:include>
