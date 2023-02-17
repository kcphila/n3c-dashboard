<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="col-12 viz-header-section">
	<h2 class="viz-title">${param.topic_title}</h2>
	<div class="btn-group float-right">
		<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			<i class="fas fa-download"></i>
		</button>
		<div class="dropdown-menu dropdown-menu-right">
			<a class="dropdown-item" onclick="saveVisualization('pos_cumulative_graph', '${param.topic_title}.jpg');">Save as JPG</a>
			<a class="dropdown-item" onclick="saveVisualization('pos_cumulative_graph', '${param.topic_title}.png');">Save as PNG</a>
			<a class="dropdown-item" onclick="saveVisualization('pos_cumulative_graph', '${param.topic_title}.svg');">Save as SVG</a>
		</div>
	</div>
</div>
<div id="pos_cumulative">
	<div id="pos_cumulative_graph" class="col-12 dash_viz"></div>	
</div>
	
<c:set var="feedPath"><util:applicationRoot />/new_ph/timeline/feeds/positive_cases_by_date.jsp</c:set>

<jsp:include page="../../graph_support/time_line_2_column.jsp">
	<jsp:param name="data_page" value="${feedPath}" />
	<jsp:param name="dom_element" value="#pos_cumulative" />
	<jsp:param name="namespace" value="pos_cumulative" />
	<jsp:param name="date_column" value="first_diagnosis_date" />
	<jsp:param name="column1" value="cumsum_positivecases" />
	<jsp:param name="column1_label" value="Cumulative COVID+ Patient Count" />
	<jsp:param name="column1_tip" value="Cumulative" />
	<jsp:param name="column1_tip_offset" value="90" />
	<jsp:param name="column1_color" value="#09405A" />
	<jsp:param name="column2" value="seven_day_rolling_avg" />
	<jsp:param name="column2_label" value="Rolling 7-Day Average Patient Count" />
	<jsp:param name="column2_tip" value="7-Day Ave" />
	<jsp:param name="column2_tip_offset" value="80" />
	<jsp:param name="column2_color" value="#8406D1" />
	<jsp:param name="column1_opacity" value="0.7" />
	<jsp:param name="constraintPropagator" value="constraint" />
</jsp:include>

