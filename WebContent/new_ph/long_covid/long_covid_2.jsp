<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="long_covid_2" />
	<jsp:param name="block_header" value="Long COVID: Clinic Visit" />
	<jsp:param name="topic_description" value="secondary_2" />
	<jsp:param name="topic_title" value="Counts of Patients Who Have Visited a Long COVID Clinic" />
	<jsp:param name="folder" value="long_covid" />
	<jsp:param name="did" value="49" />

	<jsp:param name="kpis" value="long_covid/kpis.jsp" />

	<jsp:param name="severity_filter" value="true" />
	<jsp:param name="sex_filter" value="true" />
	
	<jsp:param name="simple_panel" value="long_covid/diagnosis.jsp" />

	<jsp:param name="datatable" value="long_covid/tables/clinic_severity_table.jsp" />
	<jsp:param name="datatable_div" value="long_covid_clinic_severity" />
	<jsp:param name="datatable_feed" value="long_covid/feeds/clinic_severity.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />
</jsp:include>

