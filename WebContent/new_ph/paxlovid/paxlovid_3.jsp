<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="kpis.jsp">
	<jsp:param value="paxlovid_3" name="block"/>
</jsp:include>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="paxlovid_3" />
	<jsp:param name="block_header" value="Paxlovid" />
	<jsp:param name="topic_description" value="secondary_2" />
	<jsp:param name="did" value="55" />
	<jsp:param name="folder" value="paxlovid" />
	<jsp:param name="topic_title" value="Counts of Patients Prescribed Paxlovid Who Had Subsequent Visits Within 27 Days by Visit Type and COVID Test Results" />
	
	<jsp:param name="result_filter" value="true" />

	<jsp:param name="simple_panel" value="paxlovid/visits.jsp" />

	<jsp:param name="datatable" value="paxlovid/visits_table.jsp" />
	<jsp:param name="datatable_div" value="paxlovid_paxlovid_visits" />
	<jsp:param name="datatable_feed" value="paxlovid/feeds/visits.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />
	<jsp:param name="datatable_filtered_kpis" value="patient_count" />
</jsp:include>

<script>
	paxlovid_3_toggle("category");
</script>
