<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block2.jsp">
	<jsp:param name="block" value="hlh_3" />
	<jsp:param name="block_header" value="Dementia" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="topic_disease" value="Dementia" />
	
	<jsp:param name="kpis" value="hlh/kpis.jsp" />
	<jsp:param name="kpi_filter" value="dementia" />
	
	<jsp:param name="age_filter7" value="true" />
	<jsp:param name="sex_filter3" value="true" />
	
	<jsp:param name="age_panel" value="hlh/ageSex.jsp" />
	<jsp:param name="sex_panel" value="hlh/sexAge.jsp" />

	<jsp:param name="datatable" value="hlh/hlh_table.jsp" />
	<jsp:param name="datatable_div" value="hlh_data_3" />
	<jsp:param name="datatable_feed" value="hlh/feeds/hlh.jsp?comorbidity=dementia" />
	<jsp:param name="datatable_kpis" value="patient_count" />
	<jsp:param name="datatable_kpis2" value="peds_patient_count" />
	
	
</jsp:include>

<script>
	hlh_3_toggle("age");
</script>
