<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="metformin_3" />
	<jsp:param name="block_header" value="All Patients Prescribed Metformin Long COVID" />
	<jsp:param name="folder" value="metformin" />
	<jsp:param name="topic_description" value="secondary_3" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="All Patients" />

	<jsp:param name="kpis" value="metformin/kpis.jsp" />
	
	<jsp:param name="age_filter_min" value="true" />
	<jsp:param name="race_filter" value="true" />
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="covid_filter" value="true" />
	<jsp:param name="severity_filter" value="true" />
	<jsp:param name="long_filter" value="true" />
	<jsp:param name="mortality_filter" value="true" />
	<jsp:param name="vaccinated_filter" value="true" />
	<jsp:param name="beforeaftermedication_filter" value="true" />
	
	<jsp:param name="toggle3" value="true" />
	
	<jsp:param name="viz_properties" value="{'long1' : [{
			dimension: 'long',
			domName: '#metformin_3_long1_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: longstatus_range,
			legend_label: 'Longstatus',
			feed: 'LongMet',
			legend_data: longstatus_legend,
			donutRatio: 0.5
		}], 'long2' : [{
			dimension: 'long',
			domName: '#metformin_3_long2_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: longstatus_range,
			legend_label: 'Longstatus',
			feed: 'LongNoMet',
			legend_data: longstatus_legend,
			donutRatio: 0.5
		}], 'long3' : [{
			dimension: 'long',
			domName: '#metformin_3_long3_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: longstatus_range,
			legend_label: 'Longstatus',
			feed: 'LongDiabMet',
			legend_data: longstatus_legend,
			donutRatio: 0.5
		}], 'long4' : [{
			dimension: 'long',
			domName: '#metformin_3_long4_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: longstatus_range,
			legend_label: 'Longstatus',
			feed: 'LongDiabNoMet',
			legend_data: longstatus_legend,
			donutRatio: 0.5
		}]
	}"/>
	
	<jsp:param name="simple_panel" value="metformin/long_compare.jsp" />

	<jsp:param name="datatable" value="metformin/tables/compare_table.jsp" />
	<jsp:param name="datatable_div" value="long_covid_met" />
	<jsp:param name="datatable_feed" value="metformin/feeds/compare.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count,met_patient_count,nomet_patient_count,diab_met_patient_count,diab_nomet_patient_count" />

</jsp:include>


