<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="paxlovid_4" />
	<jsp:param name="block_header" value="Demographics: COVID+ and Paxlovid Status" />
	<jsp:param name="topic_description" value="secondary_4" />
	<jsp:param name="topic_title" value="COVID+ Patients" />
	<jsp:param name="did" value="55" />
	<jsp:param name="folder" value="paxlovid" />
	<jsp:param name="kpis" value="paxlovid/kpis_new.jsp" />
	
	<jsp:param name="floating_legend" value="true" />

	<jsp:param name="paxlovid_filter" value="true" />
	
	<jsp:param name="age_panel" value="paxlovid/age.jsp" />
	<jsp:param name="sex_panel" value="paxlovid/sex.jsp" />
	<jsp:param name="race_panel" value="paxlovid/race.jsp" />

	<jsp:param name="datatable" value="paxlovid/viz_tables/demographics_table.jsp" />
	<jsp:param name="datatable_div" value="paxlovid_paxlovid_demographics" />
	<jsp:param name="datatable_kpis" value="patient_count,paxlovid" />
	<jsp:param name="datatable_feed" value="paxlovid/feeds/demographics.jsp" />
</jsp:include>

<script>
	var panels = ["age", "sex", "race"];
	paxlovid_4_panel(panels);
</script>