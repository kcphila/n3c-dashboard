<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="enclave_health_5" />
	<jsp:param name="block_header" value="Patients w/Condition(s)" />
	<jsp:param name="folder" value="enclave_health" />
	<jsp:param name="topic_description" value="secondary_5" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="Patients w/Condition(s)" />
	<jsp:param name="floating_legend" value="true" />

	<jsp:param name="kpis" value="enclave_health/kpis.jsp" />
	
	<jsp:param name="count_filter" value="true" />
	<jsp:param name="nu_conditions_filter" value="true" />
	<jsp:param name="conditions_filter" value="true" />
	
	<jsp:param name="simple_panel" value="enclave_health/nu_conditions.jsp" />

	<jsp:param name="datatable" value="enclave_health/tables/nu_conditions_table.jsp" />
	<jsp:param name="datatable_div" value="enclave_health_table_5" />
	<jsp:param name="datatable_feed" value="enclave_health/feeds/nu_conditions.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />

	<jsp:param name="countArray" value="true" />
</jsp:include>

<script>
	var panels = ["conditioncount"];
	enclave_health_5_panel(panels);
</script>

