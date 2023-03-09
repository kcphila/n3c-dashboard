<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="long_covid_4" />
	<jsp:param name="block_header" value="Long COVID: Individual ICD-10 Symptom Grouped Counts" />
	<jsp:param name="topic_description" value="secondary_4" />
	<jsp:param name="topic_title" value="Counts of Patients Who Have Experienced Long COVID-Related Symptoms By Symptom Cluster" />
	<jsp:param name="folder" value="long_covid" />
	<jsp:param name="did" value="49" />
	
	<jsp:param name="kpis" value="long_covid/kpis.jsp" />

	<jsp:param name="age_filter4" value="true" />
	<jsp:param name="race_filter" value="true" />
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="ethnicity_filter" value="true" />
	<jsp:param name="symptom_filter" value="true" />
	
	<jsp:param name="simple_panel" value="long_covid/symptom.jsp" />
	<jsp:param name="labelwidth" value="210" />
	<jsp:param name="viz_height" value="900" />

	<jsp:param name="datatable" value="long_covid/tables/symptom_grouped_table.jsp" />
	<jsp:param name="datatable_div" value="long_covid_symptom_grouped" />
	<jsp:param name="datatable_feed" value="long_covid/feeds/symptom_grouped.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />
	<jsp:param name="datatable_filtered_kpis" value="observation|Tested positive|tested_positive|patient_count,observation|Has U09.9 in Record|in_record|patient_count" />
</jsp:include>

