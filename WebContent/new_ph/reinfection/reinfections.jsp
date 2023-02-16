<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>



<div id="reinfection1">
	<div class="row">
		<div class="col-12 viz-header-section">
			<h2 class="viz-title">${param.topic_title}</h2>
			<div class="btn-group float-right">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('reinfection1_graph', '${param.topic_title}.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('reinfection1_graph', '${param.topic_title}.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('reinfection1_graph', '${param.topic_title}.svg')">Save as SVG</a>
				</div>
			</div>
		</div>
		<div class="col-12">
			<div id="reinfection1_graph"></div>
		</div>
	</div>
	
	<c:set var="feedPath"><util:applicationRoot/>/new_ph/reinfection/feeds/reinfections_by_date.jsp</c:set>
	
	<jsp:include page="../../graph_support/time_line_2_column.jsp">
		<jsp:param name="data_page" value="${feedPath}" />
		<jsp:param name="dom_element" value="#reinfection1" />
		<jsp:param name="namespace" value="reinfection1" />
		<jsp:param name="date_column" value="c_date" />
		<jsp:param name="column1" value="first_diagnosis" />
		<jsp:param name="column1_label" value="First Diagnosis Countt" />
		<jsp:param name="column1_tip" value="First Diagnosis" />
		<jsp:param name="column1_tip_offset" value="110" />
		<jsp:param name="column1_color" value="#4833B2" />
		<jsp:param name="column1_opacity" value="1" />
		<jsp:param name="column2" value="reinfected" />
		<jsp:param name="column2_label" value="Reinfection Count" />
		<jsp:param name="column2_tip" value="Reinfection" />
		<jsp:param name="column2_tip_offset" value="85" />
		<jsp:param name="column2_color" value="#A772DF" />
		<jsp:param name="column2_opacity" value="0.7" />
		<jsp:param name="constraintPropagator" value="constraint" />
	</jsp:include>
	
</div>