<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="all_summary_0"></div>

<div id="hive_save_viz">
	<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('all_summary_0', 'hive.svg');">Save as SVG</button>
	<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('all_summary_0', 'hive.png');">Save as PNG</button>
	<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('all_summary_0', 'hive.jpg');">Save as JPEG</button>
</div>
<jsp:include page="../../graph_support/hive.jsp">
	<jsp:param name="dom_element" value="#all_summary_0" />
</jsp:include>

