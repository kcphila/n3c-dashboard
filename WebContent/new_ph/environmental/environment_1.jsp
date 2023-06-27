<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="environment_1" />
	<jsp:param name="block_header" value="Demographics of Patients Exposed to Environmental Factors" />
	<jsp:param name="folder" value="environmental" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="Patients Exposed to Environmental Factors " />

	<jsp:param name="kpis" value="environmental/kpis.jsp" />
	
	<jsp:param name="age_filter_min" value="true" />
	<jsp:param name="race_filter" value="true" />
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="covid_filter" value="true" />
	<jsp:param name="severity_filter" value="true" />
	
	<jsp:param name="toggle" value="true" />
	
	<jsp:param name="viz_properties" value="{'age' : [{
			dimension: 'age',
			domName: '#environment_1_age_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: age_range_min,
			legend_label: 'Age',
			legend_data: age_legend_min,
			donutRatio: 0.5
		}], 'race' : [{
			dimension: 'race',
			domName: '#environment_1_race_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: race_range,
			legend_label: 'Race',
			legend_data: race_legend,
			donutRatio: 0.5
		}], 'sex' : [{
			dimension: 'sex',
			domName: '#environment_1_sex_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: sex_range,
			legend_label: 'Sex',
			legend_data: sex_legend,
			donutRatio: 0.5
		}], 'severity' : [{
			dimension: 'severity',
			domName: '#environment_1_severity_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: severity_range,
			legend_label: 'Severity',
			legend_data: severity_legend,
			donutRatio: 0.5
		}]
	}"/>
	
	<jsp:param name="age_panel" value="environmental/age.jsp" />
	<jsp:param name="race_panel" value="environmental/race.jsp" />
	<jsp:param name="sex_panel" value="environmental/sex.jsp" />
	<jsp:param name="severity_panel" value="environmental/severity.jsp" />

	<jsp:param name="datatable" value="environmental/tables/demo_table.jsp" />
	<jsp:param name="datatable_div" value="environmental_environment_1" />
	<jsp:param name="datatable_feed" value="environmental/feeds/demographics.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count,covid_patient_count" />

</jsp:include>

<script>
	var panels = ["age", "race", "sex", "severity"];
	environment_1_panel(panels);
</script>
