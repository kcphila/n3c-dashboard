<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!-- positive_cases_by_day_cumsum_censored (2022-03-31 05:01) -->

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="reinfection_ts_2" />
	<jsp:param name="block_header" value="Reinfection Time Series" />
	<jsp:param name="topic_title" value="Counts of Reinfected COVID+ Patients By 30-Day Reinfection Intervals" />
	<jsp:param name="topic_description" value="secondary_2" />
	<jsp:param name="folder" value="reinfection_time_series" />

	<jsp:param name="kpis" value="reinfection_time_series/kpis.jsp" />
	
	<jsp:param name="reinfectionbin_filter" value="true" />

	<jsp:param name="did" value="${param.did}" />
	
	<jsp:param name="simple_panel" value="reinfection_time_series/interval.jsp" />

	<jsp:param name="datatable" value="reinfection_time_series/tables/interval_table.jsp" />
	<jsp:param name="datatable_div" value="reinfections-by-interval" />
	<jsp:param name="datatable_feed" value="reinfection_time_series/feeds/interval.jsp" />
	<jsp:param name="datatable_kpis" value="actual_count" />
	
	<jsp:param name="IntervalBinArray" value="true" />
</jsp:include>
