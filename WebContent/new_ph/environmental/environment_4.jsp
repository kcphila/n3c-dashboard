<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="environment_4" />
	<jsp:param name="block_header" value="Demographics of Patients Exposed to Environmental Factors" />
	<jsp:param name="folder" value="environmental" />
	<jsp:param name="topic_description" value="secondary_4" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="Patients in the Enclave who were Exposed to Environmental Factors " />

	<jsp:param name="kpis" value="environmental/kpis.jsp" />
	
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="covid_filter" value="true" />
	<jsp:param name="severity_filter" value="true" />
	<jsp:param name="long_filter" value="true" />
	<jsp:param name="mortality_filter" value="true" />
	<jsp:param name="vaccinated_filter" value="true" />
	
	<jsp:param name="toggle" value="true" />
	
	<jsp:param name="viz_properties" value="{'sex' : [{
			dimension: 'sex',
			domName: '#environment_4_sex_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: sex_range,
			legend_label: 'Sex',
			legend_data: sex_legend,
			donutRatio: 0.5
		}], 'severity' : [{
			dimension: 'severity',
			domName: '#environment_4_severity_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: severity_range,
			legend_label: 'Severity',
			legend_data: severity_legend,
			donutRatio: 0.5
		}], 'mortality' : [{
			dimension: 'mortality',
			domName: '#environment_4_mortality_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'Mortality',
			legend_data: mortality_legend,
			donutRatio: 0.5
		}], 'vaccinationstatus' : [{
			dimension: 'vaccinationstatus',
			domName: '#environment_4_vaccinationstatus_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: vaccinated_range,
			legend_label: 'Vaccinationstatus',
			legend_data: vaccinated_legend,
			donutRatio: 0.5
		}], 'longstatus' : [{
			dimension: 'longstatus',
			domName: '#environment_4_longstatus_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: longstatus_range,
			legend_label: 'Longstatus',
			legend_data: longstatus_legend,
			donutRatio: 0.5
		}], 'covid' : [{
			dimension: 'covidstatus',
			domName: '#environment_4_covidstatus_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: covidstatus_range,
			legend_label: 'Covidstatus',
			legend_data: covidstatus_legend,
			donutRatio: 0.5
		}]
	}"/>
	
	<jsp:param name="vaccinationstatus_panel" value="environmental/vaccinated.jsp" />
	<jsp:param name="covidstatus_panel" value="environmental/covid.jsp" />
	<jsp:param name="longstatus_panel" value="environmental/longstatus.jsp" />
	<jsp:param name="mortality_panel" value="environmental/mortality2.jsp" />
	<jsp:param name="sex_panel" value="environmental/sex.jsp" />
	<jsp:param name="severity_panel" value="environmental/severity.jsp" />


	<jsp:param name="datatable" value="environmental/tables/covidimpact_table.jsp" />
	<jsp:param name="datatable_div" value="environmental_environment_4" />
	<jsp:param name="datatable_feed" value="environmental/feeds/covidimpact.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count,covid_patient_count,long_covid_patient_count,vaccinated_patient_count,mortality_patient_count" />

	
	<jsp:param name="SexArray" value="true" />
	<jsp:param name="SeverityArray" value="true" />
	<jsp:param name="MortalityArray" value="true" />
	<jsp:param name="VaccinationstatusArray" value="true" />
	<jsp:param name="LongstatusArray" value="true" />
	<jsp:param name="CovidstatusArray" value="true" />
	
</jsp:include>

<script>
	var panels = ["sex", "severity", "vaccinationstatus", "mortality", "longstatus", "covidstatus"];
	environment_4_panel(panels);
</script>
