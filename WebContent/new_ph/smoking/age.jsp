<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<jsp:include page="../groupedbarpercentToggle.jsp">
	<jsp:param name="block" value="${param.block}" />
	<jsp:param name="dimension" value="age" />
	<jsp:param name="dimension_name" value="Age" />
	<jsp:param name="array" value="statusArray" />
	<jsp:param name="primary" value="age" />
	<jsp:param name="secondary" value="smoking_status" />
	<jsp:param name="count" value="patient_count" />
	<jsp:param name="count_label" value="Count" />
	<jsp:param name="percent_label" value="Percent" />
	<jsp:param name="legend" value="status_legend" />
	<jsp:param name="range" value="status_range" />
	<jsp:param name="label1" value="age" />
	<jsp:param name="label2" value="Smoking Status" />
	<jsp:param name="left" value="60" />
</jsp:include>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 id="age-title" class="viz-title"></h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="save_viz_pass('.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="save_viz_pass('.jpg');">Save as PNG</a>
				<a class="dropdown-item" onclick="save_viz_pass('.jpg');">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12">
		<div id="${param.block}_age_viz" class="col-12 dash_viz"></div>
	</div>
</div>


<c:if test="${not empty param.topic_description}">
	<div id="viz_caption">
		<jsp:include page="../smoking/secondary_text/${param.topic_description}.jsp"/>
	</div>
</c:if>

<script>

//this is to change the title of the download based on which visualization mode is selected
function save_viz_pass(extension){
	var id = $("#${param.block}-age-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode == 'bar'){
		text = "Counts of ${param.topic_title} by Age and Smoking Status" + extension;
	} else {
		text = "% of COVID+ Smokers In Each Age Category Vs. % of COVID+ Non-Smokers In Each Age Category" + extension;
	};
	
	saveVisualization('${param.block}_age_viz', text);
};

// set inital title based on load mode
var title_id = $("#${param.block}-age-mode").find('.text-primary').attr('id');
var title_strings = title_id.split('-');
var title_mode = title_strings[title_strings.length-1];

if (title_mode == 'bar'){
	var title = "Counts of ${param.topic_title} by Age and Smoking Status";
	$("#age-title").text(title);
} else {
	var title = "% of COVID+ Smokers In Each Age Category Vs. % of COVID+ Non-Smokers In Each Age Category";
	$("#age-title").text(title);
};

//this is to change the title of the graphic based on which visualization mode is selected
$('#${param.block}-age-mode-barpercent').on('mouseup', function() {
	var title = "% of COVID+ Smokers In Each Age Category Vs. % of COVID+ Non-Smokers In Each Age Category";
	$("#age-title").text(title);
});
$('#${param.block}-age-mode-bar').on('mouseup', function() {
	var title = "Counts of ${param.topic_title} by Age and Smoking Status";
	$("#age-title").text(title);
});


function ${param.block}_age_refresh() {
	var id = $("#${param.block}-age-mode").find('.text-primary').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	d3.select("#${param.block}_age_viz").select("svg").remove();
	
	if (mode == 'bar'){
		var properties = {
				domName: '${param.block}_age_viz',
				primary: 'age',
				secondary: 'smoking_status',
				count: 'patient_count',
				xaxis_label: 'Count',
				legend_label: status_legend,
				colorscale: status_range,
				label1: 'Age',
				label2: 'Smoking Status',
				offset: 60
		}

		localHorizontalGroupedBarChart(${param.block}_statusArray, properties);	
	} else if (mode == 'barpercent'){
		var properties = {
				domName: '${param.block}_age_viz',
				primary: 'age',
				secondary: 'smoking_status',
				count: 'patient_count',
				xaxis_label: 'Percent',
				legend_label: status_legend,
				colorscale: status_range,
				label1: 'Age',
				label2: 'Smoking Status',
				offset: 60
		}

		localHorizontalGroupedPercentageBarChart(${param.block}_statusArray, properties);	
	};
   	
}

${param.block}_age_refresh();
</script>
