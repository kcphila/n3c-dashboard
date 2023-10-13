<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!-- covid_patients_demographics_censored (2022-03-31 05:01) -->

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="medications_3" />
	<jsp:param name="block_header" value="COVID+ Patients Distribution by Medication" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="topic_title" value="Counts of COVID+ Patients Prescribed Select Medications by Medications and Age (Grouped by Class)" />
	<jsp:param name="folder" value="medications" />

	<jsp:param name="kpis" value="medications/kpis.jsp" />

	<jsp:param name="age_filter_min" value="true" />
	<jsp:param name="medication_filter" value="true" />
	<jsp:param name="medication_class_filter" value="true" />
	<jsp:param name="covid_filter" value="true" />

	<jsp:param name="did" value="${param.did}" />
	
	<jsp:param name="simple_panel" value="medications/medications.jsp" />

	<jsp:param name="datatable" value="medications/tables/medications_table3.jsp" />
	<jsp:param name="datatable_div" value="medications_medications_3" />
	<jsp:param name="datatable_feed" value="medications/feeds/medications.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count,medication_count,medication_class_count" />
	
	<jsp:param name="MedicationArray" value="true" />
</jsp:include>
