<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block2.jsp">
	<jsp:param name="block" value="diabetes_1" />
	<jsp:param name="block_header" value="Diabetes Mellitus Type 2" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="topic_title" value="Counts of Patients Who Have Been Diagnosed with Diabetes Mellitus Type 2 by Diagnosis Timeframe, Sex, and Age" />

	<jsp:param name="kpis" value="diabetes/kpis.jsp" />

	<jsp:param name="age_filter4" value="true" />
	<jsp:param name="sex_filter" value="true" />

	<jsp:param name="simple_panel" value="diabetes/type_2.jsp" />

	<jsp:param name="datatable" value="diabetes/diabetes_table.jsp" />
	<jsp:param name="datatable_div" value="diabetes_type2" />
	<jsp:param name="datatable_feed" value="diabetes/feeds/t2_summary.jsp" />
	<jsp:param name="datatable_kpis" value="diabetes,diabetes_covid,diabetes_before,diabetes_after,diabetes_thirty" />
</jsp:include>
