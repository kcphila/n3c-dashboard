<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="smoking_1" />
	<jsp:param name="block_header" value="Demographics: COVID+ and Smoking Status" />
	<jsp:param name="folder" value="smoking" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="did" value="58" />
	<jsp:param name="topic_title" value="COVID+ Patients" />

	<jsp:param name="kpis" value="smoking/kpis_new.jsp" />
	
	<jsp:param name="floating_legend" value="true" />
	
	<jsp:param name="age_filter4" value="true" />
	<jsp:param name="race_filter" value="true" />
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="smoking_filter" value="true" />
	
	<jsp:param name="db_title" value="Mortality" />
	

	
	<jsp:param name="viz_properties" value="{'age' : [{
			domName: 'smoking_1_age_viz',
			block: 'smoking_1',
			primary: 'age',
			secondary: 'smoking_status',
			count: 'patient_count',
			xaxis_label: 'Count',
			xaxis_label2: 'Percent',
			legend_label: status_legend,
			colorscale: status_range,
			label1: 'Age',
			label2: 'Smoking Status',
			offset: 70,
			array: 'status'
		}], 'race' : [{
			domName: 'smoking_1_race_viz',
			block: 'smoking_1',
			primary: 'race',
			secondary: 'smoking_status',
			count: 'patient_count',
			xaxis_label: 'Count',
			xaxis_label2: 'Percent',
			legend_label: status_legend,
			colorscale: status_range,
			label1: 'Race',
			label2: 'Smoking Status',
			offset: 70,
			array: 'status'
		}], 'sex' : [{
			domName: 'smoking_1_sex_viz',
			block: 'smoking_1',
			primary: 'sex',
			secondary: 'smoking_status',
			count: 'patient_count',
			xaxis_label: 'Count',
			xaxis_label2: 'Percent',
			legend_label: status_legend,
			colorscale: status_range,
			label1: 'Sex',
			label2: 'Smoking Status',
			offset: 70,
			array: 'status'
		}]
	}"/>
	
	<jsp:param name="age_panel" value="smoking/age2.jsp" />
	<jsp:param name="race_panel" value="smoking/race2.jsp" />
	<jsp:param name="sex_panel" value="smoking/sex2.jsp" />

	<jsp:param name="datatable" value="smoking/demographics_table.jsp" />
	<jsp:param name="datatable_div" value="smoking_demographics" />
	<jsp:param name="datatable_feed" value="smoking/feeds/demographics.jsp" />
	<jsp:param name="datatable_kpis" value="smoking,smokingnot" />

</jsp:include>

<%-- 	<jsp:param name="toggle2" value="true" /> --%>

<script>
	var panels = ["age", "race", "sex"];
	smoking_1_panel(panels);
</script>
