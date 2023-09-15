<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="long_covid_15" />
	<jsp:param name="block_header" value="Long COVID: Clinic Visit" />
	<jsp:param name="topic_description" value="secondary_2" />
	<jsp:param name="topic_title" value="Patients Who Have Visited a Long COVID Clinic" />
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
			domName: '#long_covid_15_severity_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: severity_range,
			legend_label: 'Severity',
			legend_data: severity_legend,
			donutRatio: 0.5
		}], 'race' : [{
			dimension: 'race',
			domName: '#long_covid_15_race_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: race_range,
			legend_label: 'Race',
			legend_data: race_legend,
			donutRatio: 0.5
		}], 'mortality' : [{
			dimension: 'mortality',
			domName: '#long_covid_15_mortality_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'Mortality',
			legend_data: mortality_legend,
			donutRatio: 0.5
		}], 'vaccination' : [{
			dimension: 'vaccination',
			domName: '#long_covid_15_vaccinationstatus_viz',
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

	<jsp:param name="datatable" value="long_covid/tables/clinicvisit_cov_table.jsp" />
	<jsp:param name="datatable_div" value="long_covid_cliniccovid" />
	<jsp:param name="datatable_feed" value="long_covid/feeds/clinicvisit_covid.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />
	
	<jsp:param name="SeverityArray" value="true" />
	<jsp:param name="RaceArray" value="true" />
	<jsp:param name="VaccinationstatusArray" value="true" />
	<jsp:param name="MortalityArray" value="true" />
</jsp:include>


<script>
	var panels = ["race", "severity", "mortality", "vaccinationstatus"];
	long_covid_15_panel(panels);
</script>

