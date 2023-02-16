<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="reinfection_1" />
	<jsp:param name="block_header" value="Patient Counts: First Diagnosis Versus Reinfected Patients Per COVID+ Cohort" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="folder" value="reinfection" />
	<jsp:param name="topic_title" value="Daily Counts of First-Time COVID+ Patients Vs. # of Those Patients who Experienced Reinfections" />

	<jsp:param name="kpis" value="reinfection/kpis.jsp" />

	<jsp:param name="did" value="59" />
	
	<jsp:param name="simple_panel" value="reinfection/reinfections.jsp" />

	<jsp:param name="datatable" value="reinfection/reinfections_by_date.jsp" />
	<jsp:param name="datatable_div" value="reinfections-by-date1" />
	<jsp:param name="datatable_kpis" value="first_diagnosis,reinfected" />
</jsp:include>