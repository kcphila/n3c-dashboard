<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="hlh_11" />
	<jsp:param name="block_header" value="Myocardial Infarction" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="topic_disease" value="Myocardial Infarction" />
	<jsp:param name="topic_title" value="Counts of Patients Who Have Been Diagnosed with" />
	<jsp:param name="folder" value="hlh" />
	<jsp:param name="did" value="52" />
	
	<jsp:param name="kpis" value="hlh/kpis.jsp" />
	<jsp:param name="kpi_filter" value="myocardial_infarction" />
	
	<jsp:param name="age_filter7" value="true" />
	<jsp:param name="sex_filter3" value="true" />
	
	<jsp:param name="simple_panel" value="hlh/counts.jsp" />

	<jsp:param name="datatable" value="hlh/hlh_table.jsp" />
	<jsp:param name="datatable_div" value="hlh_data_11" />
	<jsp:param name="datatable_feed" value="hlh/feeds/hlh.jsp?comorbidity=myocardial_infarction" />
	<jsp:param name="datatable_kpis" value="patient_count" />
	<jsp:param name="datatable_kpis2" value="peds_patient_count" />
	
	
</jsp:include>
