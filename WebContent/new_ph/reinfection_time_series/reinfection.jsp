<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div id="reinfection1">
	<div class="row">
		<div class="col-12">
			<h4 style="font-size:1.2rem;">Select a Reinfection Month or <button class="btn btn-dash" id="play-button" title="Click to play/pause automatic stepping through subsequent infection dates"><i class="fas fa-play-circle"></i></button></h4>
			<small>Select Any Month on the Slider and Click Play to Start at that Date</small>
			<jsp:include page="../../graph_support/time_slider.jsp">
				<jsp:param name="block" value="${param.block}" />		
			</jsp:include>
			<h5></h5>
		</div>
		<div class="col-12 viz-header-section">
			<h2 class="viz-title">1st Infection Counts By Date for Patients Reinfected in <span id="current_date">Month, Year</span></h2>
			<div class="btn-group float-right">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="save_viz_pass('.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="save_viz_pass('.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="save_viz_pass('.svg');">Save as SVG</a>
				</div>
			</div>
		</div>
		<div class="col-12">
			<div id="${param.block}_timeline_viz" class="col-12 dash_viz"></div>
		</div>
	</div>
</div>

<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../reinfection_time_series/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<script>

function save_viz_pass(extension){
	var date = $( "#current_date" ).text();
	var text = "1st Infection Counts By Date for Patients Reinfected in " + date + extension;
	saveVisualization('${param.block}_timeline_viz', text);
};


function ${param.block}_age_refresh() {
	var properties = {
		domName: "${param.block}_timeline_viz"
	}
   	d3.select("#${param.block}_timeline_viz").select("svg").remove();
	TimeLine2ColumnChart2(${param.block}_InitialCountSevenArray, properties);	
}

${param.block}_age_refresh();
</script>
