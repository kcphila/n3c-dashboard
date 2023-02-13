<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="teams" />
	<jsp:param name="block_header" value="N3C Teams and Their Results" />

	<jsp:param name="did" value="66" />
	
	<jsp:param name="simple_panel" value="teams/table_includes.jsp" />
</jsp:include>
