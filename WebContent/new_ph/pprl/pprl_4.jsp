<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="pprl_4" />
	<jsp:param name="block_header" value="Demographics of Patients Linked to Medicaid" />
	<jsp:param name="folder" value="pprl" />
	<jsp:param name="topic_description" value="secondary_2" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="Patients in the Enclave linked to Medicaid" />

	<jsp:param name="kpis" value="pprl/kpis.jsp" />
	
	<jsp:param name="age_filter_min" value="true" />
	<jsp:param name="race_filter" value="true" />
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="ethnicity_filter" value="true" />
	<jsp:param name="only_demo" value="true" />
	
	<jsp:param name="toggle" value="true" />
	
	<jsp:param name="viz_properties" value="{'age' : [{
			dimension: 'age',
			domName: '#pprl_4_age_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: age_range_min,
			legend_label: 'Age',
			legend_data: age_legend_min,
			donutRatio: 0.5
		}], 'race' : [{
			dimension: 'race',
			domName: '#pprl_4_race_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: race_range,
			legend_label: 'Race',
			legend_data: race_legend,
			donutRatio: 0.5
		}], 'sex' : [{
			dimension: 'sex',
			domName: '#pprl_4_sex_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: sex_range,
			legend_label: 'Sex',
			legend_data: sex_legend,
			donutRatio: 0.5
		}], 'ethnicity' : [{
			dimension: 'ethnicity',
			domName: '#pprl_4_ethnicity_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: ethnicity_range,
			legend_label: 'Ethnicity',
			legend_data: ethnicity_legend,
			donutRatio: 0.5
		}]
	}"/>
	
	<jsp:param name="age_panel" value="pprl/age.jsp" />
	<jsp:param name="race_panel" value="pprl/race.jsp" />
	<jsp:param name="sex_panel" value="pprl/sex.jsp" />
	<jsp:param name="ethnicity_panel" value="pprl/ethnicity.jsp" />

	<jsp:param name="datatable" value="pprl/tables/medicaid_demo_table.jsp" />
	<jsp:param name="datatable_div" value="pprl_pprl_4" />
	<jsp:param name="datatable_feed" value="pprl/feeds/medicaid_demographics.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />

</jsp:include>

<script>
	var panels = ["age", "race", "sex", "ethnicity"];
	pprl_4_panel(panels);
</script>
