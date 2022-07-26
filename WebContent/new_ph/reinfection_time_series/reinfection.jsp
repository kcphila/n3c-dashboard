<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="reinfection1">
	<div class="text-center">
		<h4 style="font-size:1.2rem;">Select a Reinfection Month or <button class="btn btn-dash" id="play-button" title="Click to play/pause automatic stepping through subsequent infection dates"><i class="fas fa-play-circle"></i></button></h4>
		<jsp:include page="../../graph_support/time_slider.jsp">
			<jsp:param name="block" value="${param.block}" />		
		</jsp:include>
	</div>
	
	<div id="${param.block}_timeline_viz" class="col-12 dash_viz"></div>

	<div id="reinfection1_graph_save_viz"> 
		<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('reinfection1_graph', 'reinfection1_graph.svg');">Save as SVG</button>
		<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('reinfection1_graph', 'reinfection1_graph.png');">Save as PNG</button>
		<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('reinfection1_graph', 'reinfection1_graph.jpg');">Save as JPEG</button>
	</div>
	
</div>

<script>

function ${param.block}_age_refresh() {
   	d3.select("#${param.block}_timeline_viz").select("svg").remove();
	TimeLine2ColumnChart2(${param.block}_InitialCountSevenArray,"${param.block}_timeline_viz", 120);	
}

${param.block}_age_refresh();
</script>
