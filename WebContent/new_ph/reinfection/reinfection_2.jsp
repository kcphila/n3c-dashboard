<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="reinfection_2" />
	<jsp:param name="block_header" value="Patient Counts: First Diagnosis Versus Number of Reinfections Per Day" />
	<jsp:param name="topic_description" value="secondary_2" />
	<jsp:param name="folder" value="reinfection" />
	<jsp:param name="topic_title" value="Counts of Daily First-Time COVID+ Patients Vs. Daily Reinfections" />

	<jsp:param name="kpis" value="reinfection/kpis.jsp" />

	<jsp:param name="did" value="${param.did}" />
	
	<jsp:param name="simple_panel" value="reinfection/counts.jsp" />

	<jsp:param name="datatable" value="reinfection/reinfections_by_date.jsp" />
	<jsp:param name="datatable_div" value="reinfections-by-date2" />
	<jsp:param name="datatable_kpis" value="first_diagnosis,subsequent_test" />
</jsp:include>

