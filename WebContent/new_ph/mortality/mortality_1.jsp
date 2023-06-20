<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="mortality_1" />
	<jsp:param name="block_header" value="Mortality: COVID+ and Hospitalization" />
	<jsp:param name="folder" value="mortality" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="topic_title" value="Mortalities" />
	
	<jsp:param name="kpis" value="mortality/kpis.jsp" />

	<jsp:param name="age_filter_min" value="true" />
	<jsp:param name="race_filter" value="true" />
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="ethnicity_filter" value="true" />
	
	<jsp:param name="did" value="61" />
	
	
	<jsp:param name="toggle" value="true" />
	
	<jsp:param name="viz_properties" value="{'age' : [{
			dimension: 'age',
			domName: '#mortality_1_age_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: age_range_min,
			legend_label: 'Age',
			legend_data: age_legend_min,
			donutRatio: 0.5
		}], 'race' : [{
			dimension: 'race',
			domName: '#mortality_1_race_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: race_range,
			legend_label: 'Race',
			legend_data: race_legend,
			donutRatio: 0.5
		}], 'sex' : [{
			dimension: 'sex',
			domName: '#mortality_1_sex_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: sex_range,
			legend_label: 'Sex',
			legend_data: sex_legend,
			donutRatio: 0.5
		}], 'ethnicity' : [{
			dimension: 'ethnicity',
			domName: '#mortality_1_ethnicity_viz',
			barLabelWidth: 100,
			min_height: 300,
			ordered: 0,
			colorscale: ethnicity_range,
			legend_label: 'Ethnicity',
			legend_data: ethnicity_legend,
			donutRatio: 0.5
		}]
	}"/>
	
	<jsp:param name="age_panel" value="mortality/age.jsp" />
	<jsp:param name="race_panel" value="mortality/race.jsp" />
	<jsp:param name="sex_panel" value="mortality/sex.jsp" />
	<jsp:param name="ethnicity_panel" value="mortality/ethnicity.jsp" />

	<jsp:param name="datatable" value="mortality/tables/hospitalization_table.jsp" />
	<jsp:param name="datatable_div" value="mortality_hospitalization" />
	<jsp:param name="datatable_feed" value="mortality/feeds/hospitalization.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />
</jsp:include>

<script>
	var panels = ["age", "race", "sex", "ethnicity"];
	mortality_1_panel(panels);
</script>
