<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="substance_use_9" />
	<jsp:param name="block_header" value="Geospatial" />
	<jsp:param name="folder" value="environmental" />
	<jsp:param name="topic_description" value="secondary_9" />
	<jsp:param name="did" value="${param.did}" />

	<jsp:param name="kpis" value="substance_use/kpis.jsp" />
	
	<jsp:param name="simple_panel" value="substance_use/geospatial.jsp" />

</jsp:include>
