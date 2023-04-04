<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="hlh_4" />
	<jsp:param name="block_header" value="Diabetes Mellitus" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="topic_disease" value="Diabetes Mellitus" />
	<jsp:param name="topic_title" value="Counts of Patients Who Have Been Diagnosed with" />
	<jsp:param name="folder" value="hlh" />
	<jsp:param name="did" value="52" />
	
	<jsp:param name="kpis" value="hlh/kpis.jsp" />
	<jsp:param name="kpi_filter" value="diabetes_mellitus" />
	
	<jsp:param name="age_filter7" value="true" />
	<jsp:param name="sex_filter3" value="true" />
	
	<jsp:param name="age_panel" value="hlh/age.jsp" />
	<jsp:param name="sex_panel" value="hlh/sex.jsp" />

	<jsp:param name="datatable" value="hlh/hlh_table.jsp" />
	<jsp:param name="datatable_div" value="hlh_data_4" />
	<jsp:param name="datatable_feed" value="hlh/feeds/hlh.jsp?comorbidity=diabetes_mellitus" />
	<jsp:param name="datatable_kpis" value="patient_count" />
	<jsp:param name="datatable_kpis2" value="peds_patient_count" />
	
	
</jsp:include>

<script>
	var panels = ["age", "sex"];
	hlh_4_panel(panels);
</script>

