<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	
	
	<jsp:param name="block" value="cumulative_2" />
	<jsp:param name="block_header" value="Enclave Cumulative Participat Demographics" />
	<jsp:param name="topic_title" value="Count of Patients" />
	<jsp:param name="topic_description" value="secondary_2" />
	<jsp:param name="folder" value="cumulative" />

	<jsp:param name="kpis" value="cumulative/kpis.jsp" />

	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="race_filter" value="true" />
	<jsp:param name="ethnicity_filter" value="true" />
	
	<jsp:param name="did" value="${param.did}" />
	
	<jsp:param name="raceethncity_panel" value="cumulative/raceEthnicity.jsp" />
	<jsp:param name="racesex_panel" value="cumulative/raceSex.jsp" />

	<jsp:param name="datatable" value="cumulative/tables/demographics_table.jsp" />
	<jsp:param name="datatable_div" value="cumulative_demographics" />
	<jsp:param name="datatable_feed" value="cumulative/feeds/demographics.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />	
	
	<jsp:param name="raceEthnicityArray" value="true" />
	<jsp:param name="raceSexArray" value="true" />
	
	
</jsp:include>

<script>
	cumulative_2_load("raceethnicity");
	cumulative_2_load("racesex");
</script>