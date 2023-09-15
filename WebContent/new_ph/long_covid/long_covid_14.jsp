<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="long_covid_14" />
	<jsp:param name="block_header" value="Long COVID: U09.9 ICD-10 Code" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="topic_title" value="Patients With Diagnosed Long COVID (U09.9)" />
	<jsp:param name="folder" value="long_covid" />
	<jsp:param name="did" value="${param.did}" />
	
	<jsp:param name="kpis" value="long_covid/kpis.jsp" />

	<jsp:param name="race_filter" value="true" />
	<jsp:param name="mortality_filter" value="true" />
	<jsp:param name="vaccinated_filter" value="true" />
	<jsp:param name="severity_filter" value="true" />
	
	<jsp:param name="toggle" value="true" />
	<jsp:param name="viz_properties" value="{'severity' : [{
			dimension: 'severity',
			domName: '#long_covid_14_severity_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: severity_range,
			legend_label: 'Severity',
			legend_data: severity_legend,
			donutRatio: 0.5
		}], 'race' : [{
			dimension: 'race',
			domName: '#long_covid_14_race_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: race_range,
			legend_label: 'Race',
			legend_data: race_legend,
			donutRatio: 0.5
		}], 'mortality' : [{
			dimension: 'mortality',
			domName: '#long_covid_14_mortality_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'Mortality',
			legend_data: mortality_legend,
			donutRatio: 0.5
		}], 'vaccination' : [{
			dimension: 'vaccination',
			domName: '#long_covid_14_vaccinationstatus_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: vaccinated_range,
			legend_label: 'Vaccinationstatus',
			legend_data: vaccinated_legend,
			donutRatio: 0.5
		}]
	}"/>
	
	<jsp:param name="severity_panel" value="long_covid/severity.jsp" />
	<jsp:param name="race_panel" value="long_covid/race.jsp" />
	<jsp:param name="vaccinationstatus_panel" value="long_covid/vaccinated.jsp" />
	<jsp:param name="mortality_panel" value="long_covid/mortality.jsp" />

	<jsp:param name="datatable" value="long_covid/tables/u09_cov_table.jsp" />
	<jsp:param name="datatable_div" value="long_covid_u09covid" />
	<jsp:param name="datatable_feed" value="long_covid/feeds/u09covid.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />
	
	<jsp:param name="SeverityArray" value="true" />
	<jsp:param name="RaceArray" value="true" />
	<jsp:param name="VaccinationstatusArray" value="true" />
	<jsp:param name="MortalityArray" value="true" />
</jsp:include>


<script>
	var panels = ["race", "severity", "mortality", "vaccinationstatus"];
	long_covid_14_panel(panels);
</script>

