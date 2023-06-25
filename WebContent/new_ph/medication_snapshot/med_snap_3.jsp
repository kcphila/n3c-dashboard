<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="med_snap_3" />
	<jsp:param name="block_header" value="Medications Taken Before and After Sotrovimab" />
	<jsp:param name="topic_description" value="secondary_3" />
	<jsp:param name="topic_title" value="Counts of Patients Prescribed Sotrovimab and Other Select Medications" />
	<jsp:param name="folder" value="medication_snapshot" />

	<jsp:param name="kpis" value="medication_snapshot/kpis.jsp" />
	
	<jsp:param name="severity_filter" value="true" />
	<jsp:param name="beforeaftersotrovimab_filter" value="true" />
	<jsp:param name="sotrovimabmeds_filter" value="true" />
	
	<jsp:param name="did" value="${param.did}" />
	
	<jsp:param name="simple_panel" value="medication_snapshot/severity_meds.jsp" />
	
	<jsp:param name="datatable" value="medication_snapshot/tables/meds_table.jsp" />
	<jsp:param name="datatable_div" value="sotrovimab_meds" />
	<jsp:param name="datatable_feed" value="medication_snapshot/feeds/sotrovimab_meds.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />
</jsp:include>






