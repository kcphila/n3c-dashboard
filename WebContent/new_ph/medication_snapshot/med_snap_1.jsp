<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="med_snap_1" />
	<jsp:param name="block_header" value="Sotrovimab Treated Patients: Demographics" />
	<jsp:param name="topic_description" value="secondary_1" />
	<jsp:param name="topic_title" value="Patients Prescribed Sotrovimab" />
	<jsp:param name="folder" value="medication_snapshot" />

	<jsp:param name="kpis" value="medication_snapshot/kpis.jsp" />
	
	<jsp:param name="severity_filter" value="true" />
	<jsp:param name="age_filter_min" value="true" />
	<jsp:param name="sex_filter" value="true" />
	<jsp:param name="race_filter" value="true" />
	
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="toggle" value="true" />
	
	<jsp:param name="viz_properties" value="{'severity' : [{
			dimension: 'severity',
			domName: '#med_snap_1_severity_viz',
			barLabelWidth: 120,
			min_height: 300,
			ordered: 0,
			colorscale: severity_range,
			legend_label: 'Severity',
			legend_data: severity_legend,
			donutRatio: 0.5
		}], 'age' : [{
			dimension: 'age',
			domName: '#med_snap_1_age_viz',
			barLabelWidth: 120,
			min_height: 300,
			ordered: 0,
			colorscale: age_range_min,
			legend_label: 'Age',
			legend_data: age_legend_min,
			donutRatio: 0.5
		}], 'sex' : [{
			dimension: 'sex',
			domName: '#med_snap_1_sex_viz',
			barLabelWidth: 140,
			min_height: 300,
			ordered: 0,
			colorscale: sex_range,
			legend_label: 'Sex',
			legend_data: sex_legend,
			donutRatio: 0.5
		}], 'race' : [{
			dimension: 'race',
			domName: '#med_snap_1_race_viz',
			barLabelWidth: 140,
			min_height: 300,
			ordered: 0,
			colorscale: race_range,
			legend_label: 'Race',
			legend_data: race_legend,
			donutRatio: 0.5
		}]
	}"/>

	<jsp:param name="severity_panel" value="medication_snapshot/severity.jsp" />
	<jsp:param name="age_panel" value="medication_snapshot/age.jsp" />
	<jsp:param name="sex_panel" value="medication_snapshot/sex.jsp" />
	<jsp:param name="race_panel" value="medication_snapshot/race.jsp" />

	<jsp:param name="datatable" value="medication_snapshot/tables/aggregated_table.jsp" />
	<jsp:param name="datatable_div" value="sotrovimab_demo" />
	<jsp:param name="datatable_feed" value="medication_snapshot/feeds/sotrovimab_demo.jsp" />
	<jsp:param name="datatable_kpis" value="patient_count" />
</jsp:include>

<script>
	var panels = ["severity", "age", "sex", "race"];
	med_snap_1_panel(panels);
</script>


