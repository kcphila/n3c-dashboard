<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="metformin_5" />
	<jsp:param name="block_header" value="Demographics of Diabetic Patients Prescribed Metformin" />
	<jsp:param name="folder" value="metformin" />
	<jsp:param name="topic_description" value="secondary_5" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="Diabetic Patients" />

	<jsp:param name="kpis" value="metformin/kpis.jsp" />
	
	<jsp:param name="age_filter_min" value="true" />
	<jsp:param name="race_filter" value="true" />
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="ethnicity_filter" value="true" />
	<jsp:param name="covid_filter" value="true" />
	<jsp:param name="severity_filter" value="true" />
	<jsp:param name="long_filter" value="true" />
	<jsp:param name="mortality_filter" value="true" />
	<jsp:param name="vaccinated_filter" value="true" />
	<jsp:param name="beforeaftermedication_filter" value="true" />
	<jsp:param name="metformin_filter" value="true" />
	
	<jsp:param name="toggle" value="true" />
	
	<jsp:param name="viz_properties" value="{'age' : [{
			dimension: 'age',
			domName: '#metformin_5_age_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: age_range_min,
			legend_label: 'Age',
			legend_data: age_legend_min,
			donutRatio: 0.5
		}], 'race' : [{
			dimension: 'race',
			domName: '#metformin_5_race_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: race_range,
			legend_label: 'Race',
			legend_data: race_legend,
			donutRatio: 0.5
		}], 'sex' : [{
			dimension: 'sex',
			domName: '#metformin_5_sex_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: sex_range,
			legend_label: 'Sex',
			legend_data: sex_legend,
			donutRatio: 0.5
		}], 'ethnicity' : [{
			dimension: 'ethnicity',
			domName: '#metformin_5_ethnicity_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: ethnicity_range,
			legend_label: 'Ethnicity',
			legend_data: ethnicity_legend,
			donutRatio: 0.5
		}], 'severity' : [{
			dimension: 'severity',
			domName: '#metformin_5_severity_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: severity_range,
			legend_label: 'Severity',
			legend_data: severity_legend,
			donutRatio: 0.5
		}], 'medicationoccurrence' : [{
			dimension: 'medicationoccurrence',
			domName: '#metformin_5_medicationoccurrence_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: medicationoccurrence_range,
			legend_label: 'Conditionoccurrence',
			legend_data: medicationoccurrence_legend,
			donutRatio: 0.5
		}], 'mortality' : [{
			dimension: 'mortality',
			domName: '#metformin_5_mortality_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'Mortality',
			legend_data: mortality_legend,
			donutRatio: 0.5
		}], 'vaccinationstatus' : [{
			dimension: 'vaccinationstatus',
			domName: '#metformin_5_vaccinationstatus_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: vaccinated_range,
			legend_label: 'Vaccinationstatus',
			legend_data: vaccinated_legend,
			donutRatio: 0.5
		}], 'longstatus' : [{
			dimension: 'longstatus',
			domName: '#metformin_5_longstatus_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: longstatus_range,
			legend_label: 'Longstatus',
			legend_data: longstatus_legend,
			donutRatio: 0.5
		}], 'covid' : [{
			dimension: 'covidstatus',
			domName: '#metformin_5_covidstatus_viz',
			barLabelWidth: 125,
			min_height: 300,
			ordered: 0,
			colorscale: covidstatus_range,
			legend_label: 'Covidstatus',
			legend_data: covidstatus_legend,
			donutRatio: 0.5
		}]
	}"/>
	
	<jsp:param name="age_panel" value="metformin/age.jsp" />
	<jsp:param name="race_panel" value="metformin/race.jsp" />
	<jsp:param name="sex_panel" value="metformin/sex.jsp" />
	<jsp:param name="ethnicity_panel" value="metformin/ethnicity.jsp" />
	<jsp:param name="severity_panel" value="metformin/severity.jsp" />
	<jsp:param name="medicationoccurrence_panel" value="metformin/beforeafter.jsp" />
	<jsp:param name="vaccinationstatus_panel" value="metformin/vaccinated.jsp" />
	<jsp:param name="mortality_panel" value="metformin/mortality.jsp" />
	<jsp:param name="longstatus_panel" value="metformin/longstatus.jsp" />
	<jsp:param name="covidstatus_panel" value="metformin/covid.jsp" />

	<jsp:param name="datatable" value="metformin/tables/diabdemo_table.jsp" />
	<jsp:param name="datatable_div" value="metdemo_diab" />
	<jsp:param name="datatable_feed" value="metformin/feeds/diabmetdemo.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count,covid_patient_count,long_covid_patient_count,vaccinated_patient_count,mortality_patient_count" />

	<jsp:param name="AgeArray" value="true" />
	<jsp:param name="RaceArray" value="true" />
	<jsp:param name="SexArray" value="true" />
	<jsp:param name="EthnicityArray" value="true" />
	<jsp:param name="SeverityArray" value="true" />
	<jsp:param name="MedicationoccurrenceArray" value="true" />
	<jsp:param name="VaccinationstatusArray" value="true" />
	<jsp:param name="MortalityArray" value="true" />
	<jsp:param name="LongstatusArray" value="true" />
	<jsp:param name="CovidstatusArray" value="true" />
</jsp:include>

<script>
	var panels = ["age", "race", "sex", "ethnicity", "severity", "medicationoccurrence", "vaccinationstatus", "mortality", "longstatus", "covidstatus"];
	metformin_5_panel(panels);
</script>
