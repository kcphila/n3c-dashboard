<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="long_covid_3" />
	<jsp:param name="block_header" value="Long COVID Cumulative Symptoms Summary (Dyspnea, Fatigue, Cognition, POTS, Mental Health)" />
	<jsp:param name="topic_description" value="secondary_3" />
	<jsp:param name="topic_title" value="Counts of Patients Who Have Experinced Long COVID-Related Symptoms by COVID-19/Long COVID Status" />
	<jsp:param name="folder" value="long_covid" />
	<jsp:param name="did" value="${param.did}" />
	
	<jsp:param name="kpis" value="long_covid/kpis.jsp" />

	<jsp:param name="age_filter_min" value="true" />
	<jsp:param name="race_filter" value="true" />
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="ethnicity_filter" value="true" />
	<jsp:param name="covid_filter" value="true" />
	<jsp:param name="long_filter" value="true" />
	
	<jsp:param name="simple_panel" value="long_covid/observation.jsp" />
	<jsp:param name="labelwidth" value="230" />

	<jsp:param name="datatable" value="long_covid/tables/symptom_summary_table.jsp" />
	<jsp:param name="datatable_div" value="long_covid_symptom_summary" />
	<jsp:param name="datatable_feed" value="long_covid/feeds/symptom_summary.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count,covid_patient_count,long_patient_count" />
</jsp:include>

