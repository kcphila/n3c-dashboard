<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="enclave_health_2" />
	<jsp:param name="block_header" value="COVID Factors of Patients w/Maternal Health-Related Conditions" />
	<jsp:param name="folder" value="enclave_health" />
	<jsp:param name="topic_description" value="secondary_2" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="Patients in the Enclave w/Maternal Health-Related Conditions" />

	<jsp:param name="kpis" value="enclave_health/kpis.jsp" />
	
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="severity_filter" value="true" />
	<jsp:param name="covid_filter" value="true" />
	<jsp:param name="long_filter" value="true" />
	<jsp:param name="mortality_filter" value="true" />
	<jsp:param name="vaccinated_filter" value="true" />
	<jsp:param name="condition_filter" value="true" />
	
	<jsp:param name="toggle" value="true" />
	
	<jsp:param name="viz_properties" value="{'sex' : [{
			dimension: 'sex',
			domName: '#enclave_health_2_sex_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: sex_range,
			legend_label: 'Sex',
			legend_data: sex_legend,
			donutRatio: 0.5
		}], 'severity' : [{
			dimension: 'severity',
			domName: '#enclave_health_2_severity_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: severity_range,
			legend_label: 'Severity',
			legend_data: severity_legend,
			donutRatio: 0.5
		}],'mortality' : [{
			dimension: 'mortality',
			domName: '#enclave_health_2_mortality_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'Mortality',
			legend_data: mortality_legend,
			donutRatio: 0.5
		}], 'vaccinationstatus' : [{
			dimension: 'vaccinationstatus',
			domName: '#enclave_health_2_vaccinationstatus_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: vaccinated_range,
			legend_label: 'Vaccinationstatus',
			legend_data: vaccinated_legend,
			donutRatio: 0.5
		}], 'longstatus' : [{
			dimension: 'longstatus',
			domName: '#enclave_health_2_longstatus_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: longstatus_range,
			legend_label: 'Longstatus',
			legend_data: longstatus_legend,
			donutRatio: 0.5
		}], 'covid' : [{
			dimension: 'covidstatus',
			domName: '#enclave_health_2_covidstatus_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: covidstatus_range,
			legend_label: 'Covidstatus',
			legend_data: covidstatus_legend,
			donutRatio: 0.5
		}], 'condition' : [{
			dimension: 'condition',
			domName: '#enclave_health_2_condition_viz',
			barLabelWidth: 230,
			min_height: 300,
			ordered: 0,
			colorscale: categorical2,
			legend_label: 'Condition',
			legend_data: condition_legend,
			donutRatio: 0.5
		}]
	}"/>
	
	<jsp:param name="vaccinationstatus_panel" value="enclave_health/vaccinated.jsp" />
	<jsp:param name="covidstatus_panel" value="enclave_health/covid.jsp" />
	<jsp:param name="mortality_panel" value="enclave_health/mortality.jsp" />
	<jsp:param name="sex_panel" value="enclave_health/sex.jsp" />
	<jsp:param name="severity_panel" value="enclave_health/severity.jsp" />
	<jsp:param name="condition_panel" value="enclave_health/condition.jsp" />
	<jsp:param name="longstatus_panel" value="enclave_health/longstatus.jsp" />

	<jsp:param name="datatable" value="enclave_health/tables/outcomes.jsp" />
	<jsp:param name="datatable_div" value="enclave_health_table_2" />
	<jsp:param name="datatable_feed" value="enclave_health/feeds/outcomes.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />

	<jsp:param name="MortalityArray" value="true" />
	<jsp:param name="VaccinationstatusArray" value="true" />
	<jsp:param name="CovidstatusArray" value="true" />
	<jsp:param name="SexArray" value="true" />
	<jsp:param name="SeverityArray" value="true" />
	<jsp:param name="ConditionArray" value="true" />
	<jsp:param name="LongstatusArray" value="true" />
</jsp:include>

<script>
	var panels = ["sex", "severity", "vaccinationstatus", "mortality", "covidstatus", "longstatus", "condition"];
	enclave_health_2_panel(panels);
</script>
