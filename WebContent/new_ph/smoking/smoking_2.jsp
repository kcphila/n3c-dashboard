<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="smoking_2" />
	<jsp:param name="block_header" value="Demographics: COVID+ and Smoking Status" />
	<jsp:param name="folder" value="smoking" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="did" value="58" />
	<jsp:param name="topic_title" value="COVID+ Patients" />
	<jsp:param name="floating_legend" value="true" />
	
	<jsp:param name="toggle2" value="true" />

	<jsp:param name="kpis" value="smoking/kpis.jsp" />

	<jsp:param name="severity_filter" value="true" />
	<jsp:param name="smoking_filter" value="true" />
	
	<jsp:param name="simple_panel" value="smoking/severity.jsp" />
	
	<jsp:param name="viz_properties" value="{'severity' : [{
			domName: 'smoking_2_severity_viz',
			block: 'smoking_2',
			primary: 'severity',
			secondary: 'smoking_status',
			count: 'patient_count',
			xaxis_label: 'Count',
			xaxis_label2: 'Percent',
			legend_label: status_legend,
			colorscale: status_range,
			label1: 'Severity',
			label2: 'Smoking Status',
			offset: 90,
			array: 'status',
			legendid: 'smoking_1legend'
		}]
	}"/>
	
	<jsp:param name="datatable" value="smoking/tables/severity_table.jsp" />
	<jsp:param name="datatable_div" value="smoking_severity" />
	<jsp:param name="datatable_feed" value="smoking/feeds/severity.jsp" />
	<jsp:param name="datatable_kpis" value="smoking,smokingnot" />

</jsp:include>

<script>
	var panels = ["severity"];
	smoking_2_panel(panels);
</script>
