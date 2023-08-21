<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html>
<html>

<jsp:include page="../head.jsp" flush="true" />
<jsp:include page="../resources/dash_style.css" flush="true" />
<jsp:include page="style.css" flush="true" />

<body>
	
	<jsp:include page="../navbar.jsp" flush="true"/>
	
	<div id="d3viz" class="container-fluid content container container-large">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="<util:applicationRoot/>/#dashboards">Dashboards</a></li>
				<li class="breadcrumb-item"><a href="<util:applicationRoot/>/data-overview">Demographics</a></li>
				<li id="topic_breadcrumb" class="breadcrumb-item active" aria-current="page">COVID+ Multi-dimensional Summary</li>
			</ol>
		</nav>
		
		<jsp:include page="header.jsp" flush="true" />
		
		<div id="cohort">
			<div class="topic_dropdown" style="text-align:center; font-size: 1.3rem;">
				<h4 class="viz_color_header">Select a Topic to Explore:</h4>
				<select id="dimension_select">
					<option></option>
					<option value="demographics">All N3C Patient Demographics & COVID Factors</option>
					<option value="multi-dimensional-summary">COVID+ Patient Multi-dimensional Summary</option>
  					<option value="demographics-comorbidities">Patients w/Comorbidities Demographics & COVID Factors</option>
				</select>
			</div>
			
			<div class="section section-viz" style="margin-top: 30px;">
				<div class="row stats">
					<div class="col-12 col-lg-2 side-col">
						<jsp:include page="../meta/relatedDashboardsByID.jsp">
							<jsp:param name="did" value="56"/>
						</jsp:include>
					</div>
					
					<div class="col-12 col-md-10 mx-auto">
						<div id="display-d3">
							<div class="row stats">
								<div class="col col-12 col-md-6 viz-section">
									<div class="panel-body kpi-section">
										<div class="row kpi-row">
											<div class="col col-5 m-auto">
												<span class="tip">
													<a class="viz_secondary_info" 
														title="<a href='#' class='close' data-dismiss='alert'>&times;</a> Total COVID+ Patients in the N3C Data Enclave" 
														data-html="true" data-toggle="popover" 
														data-placement="top" 
														data-content="<strong>COVID+ Defined As:</strong>
														<ul style='padding-inline-start: 15px;'>
															<li>Laboratory-confirmed positive COVID-19 PCR or Antigen test</li>
															<li>(or) Laboratory-confirmed positive COVID-19 Antibody test</li>
															<li>(or) Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</li>
														</ul>" aria-describedby="tooltip">
				  											<p style="white-space:nowrap;">Total COVID+ Patients <i class="fas fa-info-circle"></i>
					  											<span class="sr-only">in the N3C Data Enclave, or patients who have had, a laboratory-confirmed positive COVID-19 PCR or Antigen test, 
					  												a laboratory-confirmed positive COVID-19 Antibody test, or a Medical visit in which the ICD-10 code for COVID-19 
					  												(U07.1) was recorded
					  											</span>
				  											</p> 
				  									</a>
				  								</span>
				  								<sql:query var="totals" dataSource="jdbc/N3CPublic">
													select to_char(value::int/1000000.0, '999.99')||'M' as count from n3c_admin.enclave_stats where title='covid_positive_patients';
												</sql:query>
												<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
													<div class="kpi_num"><i class="fas fa-user-plus" aria-hidden="true"></i><span id='total_kpi'>    ${row.count}</span></div>
												</c:forEach>
												<sql:query var="totals" dataSource="jdbc/N3CPublic">
													select split_part(substring(value, '-(.+)'), '-', 1) as release,  to_char(TO_DATE(substring(value, '[\w]*-[\w]*-(.*)'), 'YYYY/MM/DD'), 'Mon DD, YYYY') as date from n3c_admin.enclave_stats where title='release_name';
												</sql:query>
												<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
													<p class="data-as-of"><em>Data as of ${row.date} (${row.release})</em></p>
												</c:forEach>
												
											</div>
											<div class="col col-7" style="border-left: 2px solid #d0e3f6;">
												<span class="tip">
													<a class="viz_secondary_info" 
														title="<a href='#' class='close' data-dismiss='alert'>&times;</a> Total Patients in this Dashboard" 
														data-html="true" 
														data-toggle="popover" 
														data-placement="top" 
														data-content="<strong>Sample:</strong> COVID+ Patients in the N3C Data Enclave aggregated by 
															Age, Race, Ethnicity, Sex, and Severity.<br><br>
															<em>Note: This dashboard may not include all patients in this sample, as cohorts with counts <20 are not displayed.</em>" 
														aria-describedby="tooltip">
				  										<p style="white-space:nowrap;">Patients in Dashboard <i class="fas fa-info-circle" aria-hidden="true"></i>
				  											<span class="sr-only">: COVID+ Patients in the N3C Data Enclave aggregated by 
																Age, Race, Ethnicity, Sex, and Severity. Note: This dashboard may not include all patients in this sample, as cohorts with counts <20 are not displayed.
				  											</span>
				  										</p>
				  									</a>
				  								</span>
				  								<sql:query var="totals" dataSource="jdbc/N3CPublic">
													select to_char(value::int/1000000.0, '999.99')||'M' as count 
													from (
														select sum(case when (patient_count = '<20' or patient_count is null) then 0 else patient_count::numeric end) as value 
														from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd
													) y;
												</sql:query>
												<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
													<div class="kpi_num"><i class="fas fa-users" aria-hidden="true"></i> <span id='count_kpi'>${row.count}</span></div>
												</c:forEach>
												
												<span class="tip">
													<a class="viz_secondary_info" 
														title="<a href='#' class='close' data-dismiss='alert'>&times;</a> % of Total COVID+ Patients in this Dashboard" 
														data-html="true" data-toggle="popover" 
														data-placement="top" 
														data-content="<strong>Calculated as:</strong> The number of patients in this dashboard divided by the Total number of COVID+ Patients in the Enclave
														<br><br><em>Note: This dashboard may not include all relevant patients, as cohorts with counts <20 are not displayed.</em>" 
														aria-describedby="tooltip">
				  										<p style="white-space:nowrap;">% of Total COVID+</br> Patients in Dashboard <i class="fas fa-info-circle" aria-hidden="true"></i>
				  											<span class="sr-only">. Calculated as: The number of patients in this dashboard divided by 
				  												the Total number of COVID+ Patients in the Enclave. Note: This dashboard may not include all relevant patients, as cohorts with counts <20 are not displayed.
				  											</span>
				  										</p>
				  									</a>
				  								</span>
				  								<sql:query var="totals" dataSource="jdbc/N3CPublic">
													select round(
														((select sum(case when (patient_count = '<20' or patient_count is null) then 0 else patient_count::numeric end) as patient_count from n3c_dashboard_ph.Demo_demo_ageidl_cov_csd)/
														(select value::numeric from n3c_admin.enclave_stats where title='covid_positive_patients'))*100
													,2) as count;
												</sql:query>
												<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
													<div class="kpi_num"><i class="fas fa-users" aria-hidden="true"></i> <span id='percent_kpi'>${row.count}%</span></div>
												</c:forEach>
												
											</div>
										</div>
									</div>
								</div>
								<div class="col col-12 col-md-6 m-auto">
									<p>Nodes here are values from each demographic dimension, scaled by patient counts. Edges indicate the 
									degree of connection between values in pairs of dimensions, scaled by shared patient counts. 
									Hover over a node or edge to highlight the respective connections.</p>
								</div>
								<div class="col col-12 viz-section">
									<div class="float-right">
										<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<i class="fas fa-download"></i>
										</button>
										<div class="dropdown-menu dropdown-menu-right">
											<a class="dropdown-item" onclick="saveVisualization('hive_viz', 'COVID+ Multi-Dimensional Summary.jpg');">Save as JPG</a>
											<a class="dropdown-item" onclick="saveVisualization('hive_viz', 'COVID+ Multi-Dimensional Summary.png');">Save as PNG</a>
											<a class="dropdown-item" onclick="saveVisualization('hive_viz', 'COVID+ Multi-Dimensional Summary.svg');">Save as SVG</a>
										</div>
									</div>
									<div class="panel-body">
										<div id="hive_viz" style="text-align:center;"></div>
									</div>
								</div>
								
							</div>
							
							<div class="secondary-description">
								<jsp:include page="secondary_text/secondary_3.jsp"/>
							</div>
								
						</div>
						<div id="display-table" class="panel panel-primary">
							<div class="panel-body">
								<div id="aggregated"></div>
							</div>
						</div>
						
						<jsp:include page="limitations.jsp"/>
					</div>
				</div>

			</div>
		</div>
	</div>

	<jsp:include page="../footer.jsp" flush="true" />
	<jsp:include page="../modules/popover_init.jsp"/>
	<jsp:include page="../graph_support/graphic_save.jsp"/>
	<jsp:include page="../graph_support/hive_local.jsp"/>
	
	
<script>

//color codes
var age_range_all = ["#EADEF7", "#C9A8EB", "#A772DF", "#8642CE", "#762AC6", "#6512BD", "#4C1EA5", "#33298D", "#251a8a", "#a6a6a6"];
var race_range = ["#09405A", "#AD1181", "#8406D1", "#ffa600", "#ff7155", "#a6a6a6", "#8B8B8B"];
var ethnicity_range = ["#332380", "#B6AAF3", "#a6a6a6"];
var severity_range = ["#EBC4E0", "#C24DA1", "#AD1181", "#820D61", "#570941", "#a6a6a6"];
var sex_range = ["#4833B2", "#ffa600", "#8406D1", "#a6a6a6"];


function hive_refresh() {
	var properties = {
		feed_path: "<util:applicationRoot/>/feeds/hive_data.jsp",
		scaling: 1.75,
		domName: "hive_viz",
		domTarget: "all_summary_1",
		color: [ age_range_all, severity_range, sex_range, race_range, ethnicity_range ]
	};
	
	d3.select("#${param.block}_hive_viz").select("svg").remove();
	localHiveChart(properties);
}



$(document).ready(function() {
    $('#dimension_select').select2({
    	placeholder: "COVID+ Patient Multi-dimensional Summary",
    	minimumResultsForSearch: Infinity
    }).val('multi-dimensional-summary');
    hive_refresh();
});

$('#dimension_select').on('select2:select', function (e) {
    var data = e.params.data;
    window.open(e.params.data.id, "_self")
});


// jump to limitations
function limitlink(){
	$('#limitcollapseOne').collapse('show');
	$('html, body').animate({
        scrollTop: $("#limitations-section").offset().top
    }, 500);
}

// popover stuff
$(function () {
	$('[data-toggle="popover"]').popover()
});
$(document).on("click", ".popover .close" , function(){
    $(this).parents(".popover").popover('hide');
});


</script>

</body>
</html>
