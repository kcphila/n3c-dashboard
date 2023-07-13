<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<style>
#tooltip {
    position: absolute;
    background-color: white;
    opacity: 0.9;
    height: auto;
    padding: 1px;
    pointer-events: none;
    max-width: 450px;
    padding-left: 10px;
}
</style>

<jsp:include page="../block3.jsp">
	<jsp:param name="block" value="substance_use_5" />
	<jsp:param name="block_header" value="Substance Use: Alcohol/Smoking Heatmap" />
	<jsp:param name="folder" value="substance_use" />
	<jsp:param name="topic_description" value="secondary_5" />
	<jsp:param name="did" value="${param.did}" />
	<jsp:param name="topic_title" value="Alcohol/Smoking Heatmap" />

	<jsp:param name="heatmap_all_panel" value="substance_use/alcohol_smoking_all_heatmap.jsp" />
	<jsp:param name="heatmap_covid_panel" value="substance_use/alcohol_smoking_covid_heatmap.jsp" />

	<jsp:param name="datatable" value="substance_use/tables/heatmap.jsp" />
	<jsp:param name="datatable_div" value="substance_alc_smo_heatmap" />
	<jsp:param name="datatable_feed" value="substance_use/feeds/heatmap_alc_smo.jsp" />

</jsp:include>

<script>
	var panels = ["alc_smo_all", "alc_smo_covid"];
	substance_use_5_panel(panels);
</script>
