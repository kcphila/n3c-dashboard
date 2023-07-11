<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 col-lg-6">
		<div class="viz-header-section">
			<div style="display:flex; flex-wrap: nowrap;">
				<h2 class="viz-title">${param.topic_title2}</h2>
				<div>
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="saveVisualization('${param.block}rate', '${param.topic_title2}.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}rate', '${param.topic_title2}.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}rate', '${param.topic_title2}.svg')">Save as SVG</a>
					</div>
				</div>
			</div>
		</div>
		<div id="${param.block}rate">
			<jsp:include page="../environmental/vizs/mortality_rate.jsp">
				<jsp:param name="block" value="${param.block}rate" />
				<jsp:param name="feed" value="rate" />
			</jsp:include>
		</div>
		<div class="mt-2">
			<small style="color:gray;">The percentage of mortalities ((Mortalities/Total)*100) for all patients in the N3C Data Enclave compared to the percentage of mortalities for patients known to be impacted by environmental factors.</small>
			<br><small class="dash-highlight"><i class="fas fa-filter"></i> Filters do not impact this chart.</small>
		</div>
	</div>
	<div class="col-12 col-lg-6">
		<div class="viz-header-section">
			<div style="display:flex; flex-wrap: nowrap;">
				<h2 class="viz-title">${param.topic_title3}</h2>
				<div>
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '${param.topic_title3}.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '${param.topic_title3}.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '${param.topic_title3}.svg')">Save as SVG</a>
					</div>
				</div>
			</div>
		</div>
		<div id="${param.block}ratecovid">
			<jsp:include page="../environmental/vizs/mortality_rate.jsp">
				<jsp:param name="block" value="${param.block}ratecovid" />
				<jsp:param name="feed" value="ratecovid" />
			</jsp:include>
		</div>
		<div class="mt-2">
			<small style="color:gray;">The percentage of mortalities ((Mortalities/Total)*100) for all COVID+ patients in the N3C Data Enclave compared to the percentage of mortalities for COVID+ patients known to be impacted by environmental factors.</small>
			<br><small class="dash-highlight"><i class="fas fa-filter"></i> Filters do not impact this chart.</small>
		</div>
	</div>
</div>
<div class="row mt-4">
	<div class="col-12 viz-header-section">
		<h2 class="viz-title">${param.topic_title}</h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_environment_viz', '${param.topic_title}.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_environment_viz', '${param.topic_title}.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="saveVisualization('${param.block}_environment_viz', '${param.topic_title}.svg')">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12"> 
		<div id="${param.block}legend"></div>
	</div>
	<div class="col-12">
		<div id="${param.block}_environment_viz" class="dash_viz clip"></div>
	</div>
</div>


<script>

function ${param.block}_environment_refresh() {
	var properties = {
			domName: '${param.block}_environment_viz',
			primary: 'environmental_factor',
			secondary: 'mortality',
			count: 'patient_count',
			stack_group: 'status',
			xaxis_label: 'Covid Status',
			legend_label: covid_status_legend,
			colorscale: covid_status_range,
			label1: 'Environmental Factor',
			label2: 'Mortality',
			offset: 550,
			sortmax: true,
			legendid: '${param.block}legend'
		}

   	d3.select("#${param.block}_environment_viz").select("svg").remove(); 
	
 	localHorizontalGroupedStackedBarChart_new(${param.block}_EnvMortArray, properties);	
}

</script>
