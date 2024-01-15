<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../../graph_support/graphic_save.jsp"/>

<jsp:include page="../block.jsp">
	<jsp:param name="block" value="contributing-sites" />
	<jsp:param name="block_header" value="Site Collaboration Profiles" />

	<jsp:param name="did" value="680" />
	
	<jsp:param name="simple_panel" value="collaborating_sites/map.jsp" />
</jsp:include>
