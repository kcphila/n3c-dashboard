<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="timeline_1" />
	<jsp:param name="block_header" value="COVID+ Patients: Daily Patient Counts and 7-Day Rolling Averages" />
	<jsp:param name="topic_title" value="Daily Patient Counts and 7-Day Rolling Averages of COVID+ Patients" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="folder" value="timeline" />

	<jsp:param name="kpis" value="timeline/kpis.jsp" />

	<jsp:param name="did" value="57" />
	
	<jsp:param name="simple_panel" value="timeline/daily.jsp" />

	<jsp:param name="datatable" value="timeline/positive_cases_by_date.jsp" />
	<jsp:param name="datatable_div" value="positives-by-date1" />
</jsp:include>