<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>



<div id="posthosp">
	<div class="row">
		<div class="col-12 viz-header-section">
			<h2 class="viz-title">${param.topic_title}</h2>
			<div class="btn-group float-right">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('posthosp_graph', '${param.topic_title}.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('posthosp_graph', '${param.topic_title}.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('posthosp_graph', '${param.topic_title}.svg')">Save as SVG</a>
				</div>
			</div>
		</div>
		<div class="col-12">
			<div id="posthosp_graph"></div>
		</div>
	</div>
	
	<c:set var="feedPath"><util:applicationRoot/>/new_ph/paxlovid/feeds/post_hosp.jsp</c:set>
	
	<jsp:include page="../../graph_support/time_line_2_column_paxlovid.jsp">
		<jsp:param name="data_page" value="${feedPath}" />
		<jsp:param name="dom_element" value="#posthosp" />
		<jsp:param name="namespace" value="posthosp" />
		<jsp:param name="date_column" value="visits" />
		<jsp:param name="column1" value="paxlovid" />
		<jsp:param name="column1_label" value="COVID+ Patients Prescriped Paxlovid" />
		<jsp:param name="column1_tip" value="Paxlovid" />
		<jsp:param name="column1_tip_offset" value="110" />
		<jsp:param name="column1_color" value="#AD1181" />
		<jsp:param name="column1_opacity" value="1" />
		<jsp:param name="column2" value="no_paxlovid" />
		<jsp:param name="column2_label" value="COVID+ Patients Not Prescriped Paxlovid" />
		<jsp:param name="column2_tip" value="No Pax" />
		<jsp:param name="column2_tip_offset" value="85" />
		<jsp:param name="column2_color" value="#a6a6a6" />
		<jsp:param name="column2_opacity" value="0.7" />
		<jsp:param name="constraintPropagator" value="constraint" />
		<jsp:param name="bottomlabel" value="Number of Dr. Visits After COVID+ Diagnosis" />
		<jsp:param name="tooltipprimary" value="# of Dr. Visits" />
	</jsp:include>
	
</div>