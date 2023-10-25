<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="substance_use_8" />
	<jsp:param name="block_header" value="Substance Use: Anti-Opioids" />
	<jsp:param name="folder" value="substance_use" />
	<jsp:param name="topic_description" value="secondary_8" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="Anti-Opioid Interventions" />

	<jsp:param name="kpis" value="substance_use/kpis.jsp" />
	
	<jsp:param name="simple_panel" value="substance_use/anti_opioids_frequency.jsp" />

	<jsp:param name="datatable" value="substance_use/tables/anti_opioids.jsp" />
	<jsp:param name="datatable_div" value="substance_anti_opioids" />
	<jsp:param name="datatable_feed" value="substance_use/feeds/anti_opioids.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />
	
	<jsp:param name="AntiOpioidsArray" value="true" />
</jsp:include>
