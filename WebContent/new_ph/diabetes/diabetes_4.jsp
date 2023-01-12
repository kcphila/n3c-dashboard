<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block2.jsp">
	<jsp:param name="block" value="diabetes_4" />
	<jsp:param name="block_header" value="Diabetes Mellitus Type 2" />
	<jsp:param name="topic_description" value="secondary_4" />
	<jsp:param name="topic_title" value="Counts of Pediatric Patients Who Have Been Diagnosed with Diabetes Mellitus Type 2 by Diagnosis Conditions" />

	<jsp:param name="kpis" value="diabetes/kpis.jsp" />

	<jsp:param name="simple_panel" value="diabetes/type_2_under.jsp" />

	<jsp:param name="datatable" value="diabetes/diabetes_table2_under.jsp" />
	<jsp:param name="datatable_div" value="diabetes_type2_under" />
	<jsp:param name="datatable_feed" value="diabetes/feeds/t2_under.jsp" />
</jsp:include>
