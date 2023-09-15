<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="medication_ts_1" />
	<jsp:param name="block_header" value="Medication Time Series" />
	<jsp:param name="topic_title" value="Monthly Counts of Patients Who Have Been Prescribed Select Medications" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="folder" value="medication_time_series" />

	<jsp:param name="kpis" value="medication_time_series/kpis.jsp" />

	<jsp:param name="medications_filter" value="true" />

	<jsp:param name="did" value="${param.did}" />
	
	<jsp:param name="simple_panel" value="medication_time_series/medications.jsp" />

	<jsp:param name="datatable" value="medication_time_series/tables/medication_table.jsp" />
	<jsp:param name="datatable_div" value="medications-by-date" />
	<jsp:param name="datatable_feed" value="medication_time_series/feeds/timeline.jsp" />
	<jsp:param name="datatable_kpis" value="actual_count" />
	
	<jsp:param name="MedicationTSArray" value="true" />
</jsp:include>
