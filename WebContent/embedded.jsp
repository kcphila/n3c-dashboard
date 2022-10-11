<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>


<html>
<jsp:include page="head.jsp" flush="true" />
<body>
<script type="text/javascript">
	<jsp:include page="feeds/configuration.jsp"/>
	var embedded_mode = true;
</script>

<jsp:include page="graph_support/pieChart_local.jsp"/>
<jsp:include page="graph_support/percentage_bar_local.jsp"/>
<jsp:include page="graph_support/horizontalBarChart_local.jsp"/>
<jsp:include page="graph_support/horizontalBarChart_local2.jsp"/>
<jsp:include page="graph_support/horizontalStackedBarChart_local.jsp"/>
<jsp:include page="graph_support/horizontalStackedBarChart_local_percent.jsp"/>
<jsp:include page="graph_support/time_line_2_column_local2.jsp"/>
<jsp:include page="graph_support/hive_local.jsp"/>
<jsp:include page="graph_support/time_line_n_column_local.jsp"/>

<jsp:include page="graph_support/grouped_stacked_bar_horizontal_alexis_local.jsp"/>

<jsp:include page="graph_support/grouped_bar_horizontal_local.jsp"/>
<jsp:include page="graph_support/grouped_bar_horizontal_percentage_local.jsp"/>

<jsp:include page="graph_support/region_map_local.jsp"/>

<jsp:include page="graph_support/verticalBarChart_local.jsp"/>
<jsp:include page="graph_support/mortalityBarChart_local.jsp"/>
<jsp:include page="graph_support/graphic_save.jsp"/>

<jsp:include page="new_ph/${param.panel}/panel.jsp"/>
</body>
</html>
