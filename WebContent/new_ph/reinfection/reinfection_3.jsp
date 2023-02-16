<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="reinfection_3" />
	<jsp:param name="block_header" value="COVID+ Reinfection Counts Grouped by 30 Day Increments" />
	<jsp:param name="topic_description" value="secondary_3" />
	<jsp:param name="folder" value="reinfection" />
	<jsp:param name="topic_title" value="Counts of Reinfected COVID+ Patients By 30-Day Reinfection Intervals" />

	<jsp:param name="kpis" value="reinfection/kpis.jsp" />

	<jsp:param name="did" value="59" />
	
	<jsp:param name="simple_panel" value="reinfection/reinfections_30day.jsp" />

	<jsp:param name="datatable" value="reinfection/reinfections_30day_table.jsp" />
	<jsp:param name="datatable_div" value="reinfections_30day" />

</jsp:include>

