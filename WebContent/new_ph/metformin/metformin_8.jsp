<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="metformin_8" />
	<jsp:param name="block_header" value="All Diabetic Patients Prescribed Metformin Long COVID" />
	<jsp:param name="folder" value="metformin" />
	<jsp:param name="topic_description" value="secondary_8" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="All Diabetic Patients" />

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
	<jsp:param name="beforeaftercondition_filter" value="true" />
	
	<jsp:param name="toggle3" value="true" />
	
	<jsp:param name="viz_properties" value="{'severity1' : [{
			dimension: 'mortality',
			domName: '#metformin_8_mortality1_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'Mortality',
			feed: 'MortalityMet',
			legend_data: mortality_legend,
			donutRatio: 0.5
		}], 'severity2' : [{
			dimension: 'mortality',
			domName: '#metformin_8_mortality2_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'Mortality',
			feed: 'MortalityNoMet',
			legend_data: mortality_legend,
			donutRatio: 0.5
		}]
	}"/>
	
	<jsp:param name="simple_panel" value="metformin/mortality_compare.jsp" />

	<jsp:param name="datatable" value="metformin/tables/diabetes_table.jsp" />
	<jsp:param name="datatable_div" value="mortality_diab" />
	<jsp:param name="datatable_feed" value="metformin/feeds/diabetes.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count,met_patient_count,nomet_patient_count" />

</jsp:include>


