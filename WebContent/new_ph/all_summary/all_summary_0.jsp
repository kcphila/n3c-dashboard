<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block2.jsp">
	<jsp:param name="block" value="all_summary_0" />
	<jsp:param name="block_header" value="Demographics: COVID+" />
	<jsp:param name="topic_description" value="secondary_1" />

	<jsp:param name="kpis" value="all_summary/kpis.jsp" />

	<jsp:param name="simple_panel" value="all_summary/hive.jsp" />
</jsp:include>
