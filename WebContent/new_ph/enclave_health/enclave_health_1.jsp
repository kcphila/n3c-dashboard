<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="enclave_health_1" />
	<jsp:param name="block_header" value="Demographics of Enclave Patients w/Maternal Health-Related Conditions" />
	<jsp:param name="folder" value="enclave_health" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="Patients in the Enclave w/Maternal Health-Related Conditions" />

	<jsp:param name="kpis" value="enclave_health/kpis.jsp" />
	
	<jsp:param name="age_filter_min" value="true" />
	<jsp:param name="race_filter" value="true" />
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="covid_filter" value="true" />
	<jsp:param name="mortality_filter" value="true" />
	<jsp:param name="condition_filter" value="true" />
	<jsp:param name="cms_filter" value="true" />
	
	<jsp:param name="toggle" value="true" />
	
	<jsp:param name="viz_properties" value="{'age' : [{
			dimension: 'age',
			domName: '#enclave_health_1_age_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: age_range_ideal,
			legend_label: 'Age',
			legend_data: age_legend_ideal,
			donutRatio: 0.5
		}], 'race' : [{
			dimension: 'race',
			domName: '#enclave_health_1_race_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: race_range,
			legend_label: 'Race',
			legend_data: race_legend,
			donutRatio: 0.5
		}], 'sex' : [{
			dimension: 'sex',
			domName: '#enclave_health_1_sex_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: sex_range,
			legend_label: 'Sex',
			legend_data: sex_legend,
			donutRatio: 0.5
		}], 'cms' : [{
			dimension: 'cms',
			domName: '#enclave_health_1_cms_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: cms_range,
			legend_label: 'Cms',
			legend_data: cms_legend,
			donutRatio: 0.5
		}], 'condition' : [{
			dimension: 'condition',
			domName: '#enclave_health_1_condition_viz',
			barLabelWidth: 230,
			min_height: 300,
			ordered: 0,
			colorscale: categorical2,
			legend_label: 'Condition',
			legend_data: condition_legend,
			donutRatio: 0.5
		}]
	}"/>
	
	<jsp:param name="age_panel" value="enclave_health/age.jsp" />
	<jsp:param name="race_panel" value="enclave_health/race.jsp" />
	<jsp:param name="sex_panel" value="enclave_health/sex.jsp" />
	<jsp:param name="condition_panel" value="enclave_health/condition.jsp" />
	<jsp:param name="cms_panel" value="enclave_health/cms.jsp" />

	<jsp:param name="datatable" value="enclave_health/tables/demo_table.jsp" />
	<jsp:param name="datatable_div" value="enclave_health_table_1" />
	<jsp:param name="datatable_feed" value="enclave_health/feeds/demographics.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count,covid_patient_count" />

	<jsp:param name="AgeArray" value="true" />
	<jsp:param name="RaceArray" value="true" />
	<jsp:param name="SexArray" value="true" />
	<jsp:param name="ConditionArray" value="true" />
	<jsp:param name="CmsArray" value="true" />
</jsp:include>

<script>
	var panels = ["age", "race", "sex", "condition", "cms"];
	enclave_health_1_panel(panels);
</script>
