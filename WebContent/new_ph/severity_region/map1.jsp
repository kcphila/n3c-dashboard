<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<jsp:include page="../block2.jsp">
	<jsp:param name="block" value="severity_region_1" />
	<jsp:param name="block_header" value="Regional Distribution of COVID+ Patients" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="topic_title" value="Regional Distribution of COVID+ Patients" />

	<jsp:param name="kpis" value="severity_region/kpis.jsp" />
	
	<jsp:param name="severity_filter" value="true" />
	<jsp:param name="region_filter" value="true" />
	
	<jsp:param name="simple_panel" value="severity_region/map.jsp" />

	<jsp:param name="datatable" value="severity_region/region_table.jsp" />
	<jsp:param name="datatable_div" value="severityregion" />
	<jsp:param name="datatable_feed" value="severity_region/feeds/regions.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count,region_seq" />
</jsp:include>