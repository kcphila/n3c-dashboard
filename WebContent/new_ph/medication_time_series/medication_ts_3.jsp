<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="medication_ts_3" />
	<jsp:param name="block_header" value="Medication Time Series" />
	<jsp:param name="topic_title" value="Count of Patients Who Have Been Prescribed Select Medications" />
	<jsp:param name="topic_description" value="secondary_2" />
	<jsp:param name="folder" value="medication_time_series" />
	<jsp:param name="did" value="${param.did}" />

	<jsp:param name="kpis" value="medication_time_series/kpis.jsp" />
	
	<jsp:param name="age_panel" value="medication_time_series/age.jsp" />
	<jsp:param name="race_panel" value="medication_time_series/race.jsp" />
	<jsp:param name="sex_panel" value="medication_time_series/sex.jsp" />

	<jsp:param name="datatable" value="medication_time_series/overall_table.jsp" />
	<jsp:param name="datatable_div" value="medications-overall-demo" />
	<jsp:param name="datatable_feed" value="medication_time_series/feeds/demographics.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />
</jsp:include>

<script>
	var panels = ["age", "race", "sex", "ethnicity"];
	medication_ts_3_panel(panels);
</script>