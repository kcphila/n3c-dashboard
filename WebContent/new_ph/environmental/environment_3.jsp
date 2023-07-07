<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="environment_3" />
	<jsp:param name="block_header" value="Number of Impacted Patients By Environmental Factor and Mortality Status" />
	<jsp:param name="folder" value="environmental" />
	<jsp:param name="topic_description" value="secondary_3" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="Number of Impacted Patients By Environmental Factor and Mortality Status" />
	<jsp:param name="topic_title2" value="% of Mortalities for All N3C Patients Vs. Environmentally Impacted Patients" />
	<jsp:param name="topic_title3" value="% of Mortalities for All COVID+ N3C Patients Vs. COVID+ Environmentally Impacted Patients" />

	<jsp:param name="kpis" value="environmental/kpis.jsp" />

	<jsp:param name="covid_filter" value="true" />
	<jsp:param name="environmental_filter2" value="true" />
	<jsp:param name="mortality_filter" value="true" />
	
	<jsp:param name="simple_panel" value="environmental/mortality.jsp" />
	
	<jsp:param name="datatable" value="environmental/tables/mortality_table.jsp" />
	<jsp:param name="datatable_div" value="environmental_environment_3" />
	<jsp:param name="datatable_feed" value="environmental/feeds/mortality.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count,covid_patient_count,mortality_patient_count" />

</jsp:include>
