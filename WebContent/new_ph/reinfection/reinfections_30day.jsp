<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="reinfection3">
	<div class="row">
		<div class="col-12 viz-header-section">
			<h2 class="viz-title">${param.topic_title}</h2>
			<div class="btn-group float-right">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('reinfection3_graph', '${param.topic_title}.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('reinfection3_graph', '${param.topic_title}.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('reinfection3_graph', '${param.topic_title}.svg')">Save as SVG</a>
				</div>
			</div>
		</div>
		<div class="col-12">
			<div id="reinfection3_graph"></div>
		</div>
	</div>
	
	<c:set var="feedPath"><util:applicationRoot/>/new_ph/reinfection/feeds/reinfections_30day.jsp</c:set>
	
	<jsp:include page="../../graph_support/reinfection_bar.jsp">
		<jsp:param name="data_page" value="${feedPath}" />
		<jsp:param name="dom_element" value="#reinfection3_graph" />
		<jsp:param name="namespace" value="reinfection3" />
	</jsp:include>
	
	
</div>


