<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block2.jsp">
	<jsp:param name="block" value="smoking_2" />
	<jsp:param name="block_header" value="Demographics: COVID+ and Smoking Status" />
	<jsp:param name="topic_description" value="secondary_2" />

	<jsp:param name="kpis" value="smoking/kpis.jsp" />

	<jsp:param name="severity_filter" value="true" />
	<jsp:param name="smoking_filter" value="true" />
	
	<jsp:param name="simple_panel" value="smoking/severity.jsp" />
	
	<jsp:param name="datatable" value="smoking/severity_table.jsp" />
	<jsp:param name="datatable_div" value="smoking_severity" />
	<jsp:param name="datatable_feed" value="smoking/feeds/severity.jsp" />
	<jsp:param name="datatable_kpis" value="smoking,smokingnot" />

</jsp:include>

<script>
	smoking_2_toggle("severity");
</script>
