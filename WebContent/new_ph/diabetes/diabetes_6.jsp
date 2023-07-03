<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="diabetes_6" />
	<jsp:param name="block_header" value="Diabetes Mellitus Type 1" />
	<jsp:param name="topic_description" value="secondary_6" />
	<jsp:param name="topic_title" value="Counts of Adult Patients Who Have Been Diagnosed with Diabetes Mellitus Type 2 by Diagnosis Conditions" />
	<jsp:param name="folder" value="diabetes" />
	<jsp:param name="did" value="51" />
	
	<jsp:param name="kpis" value="diabetes/kpis.jsp" />

	<jsp:param name="simple_panel" value="diabetes/type_2_over.jsp" />

	<jsp:param name="datatable" value="diabetes/diabetes_table2_over.jsp" />
	<jsp:param name="datatable_div" value="diabetes_type2_over" />
	<jsp:param name="datatable_feed" value="diabetes/feeds/t2_over.jsp" />
</jsp:include>
