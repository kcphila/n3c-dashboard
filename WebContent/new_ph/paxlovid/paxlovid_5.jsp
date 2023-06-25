<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="paxlovid_5" />
	<jsp:param name="block_header" value="Vaccinations Before COVID+" />
	<jsp:param name="topic_description" value="secondary_5" />
	<jsp:param name="topic_title" value="COVID+ Patients" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="folder" value="paxlovid" />
	<jsp:param name="kpis" value="paxlovid/kpis_new.jsp" />
	
	<jsp:param name="paxlovid_filter" value="true" />

	<jsp:param name="simple_panel" value="paxlovid/vaccination.jsp" />

	<jsp:param name="datatable" value="paxlovid/viz_tables/vaccination_table.jsp" />
	<jsp:param name="datatable_div" value="paxlovid_paxlovid_vaccination" />
	<jsp:param name="datatable_feed" value="paxlovid/feeds/vaccination.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count,paxlovid" />
</jsp:include>
