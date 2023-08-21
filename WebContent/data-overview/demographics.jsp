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
				<li id="topic_breadcrumb" class="breadcrumb-item active" aria-current="page">Demographics of Patients in the N3C Data Enclave</li>
			</ol>
		</nav>
		
		<jsp:include page="header.jsp" flush="true" />
		
		<div id="cohort">
			<div class="topic_dropdown" style="text-align:center; font-size: 1.3rem;">
				<h4 class="viz_color_header">Select a Topic to Explore:</h4>
				<select id="dimension_select">
					<option value="demographics">All N3C Patient Demographics & COVID Factors</option>
					<option value="multi-dimensional-summary">COVID+ Patient Multi-dimensional Summary</option>
  					<option value="demographics-comorbidities">Patients w/Comorbidities Demographics & COVID Factors</option>
				</select>
			</div>
			
			<div class="section section-viz" style="margin-top: 30px;">
				<div class="row stats">
					<jsp:include page="filters.jsp">
						<jsp:param name="age_ideal" value="true" />
						<jsp:param name="ethnicity" value="true" />
						<jsp:param name="race" value="true" />
						<jsp:param name="sex" value="true" />
						<jsp:param name="severity" value="true" />
						<jsp:param name="covid_status" value="true" />
						<jsp:param name="long_covid_status" value="true" />
						<jsp:param name="mortality" value="true" />
						<jsp:param name="vaccinated" value="true" />
					</jsp:include>
				
					<div class="col col-12 col-lg-10">
						<div id="display-d3">
							<div class="row stats">
								<div class="col col-12 col-md-6 viz-section">
									<jsp:include page="kpis.jsp">
										<jsp:param name="page" value="demographics" />
									</jsp:include>
								</div>
								<div class="col col-12 col-md-6 viz-section">
									<div style="display:flex; flex-wrap: nowrap;">
										<h2 class="viz-title">Severity of N3C Patients</h2>
										<div>
  											<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												<i class="fas fa-download"></i>
											</button>
											<div class="dropdown-menu dropdown-menu-right">
												<a class="dropdown-item" onclick="save_viz_pass('severity', '.jpg', 'Severity');">Save as JPG</a>
												<a class="dropdown-item" onclick="save_viz_pass('severity', '.png', 'Severity');">Save as PNG</a>
												<a class="dropdown-item" onclick="save_viz_pass('severity', '.svg', 'Severity');">Save as SVG</a>
											</div>
										</div>
									</div>
									<div class="panel-body">
										<div class="loading">
											<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
										</div>
										<div id="severity_histogram"></div>
									</div>
								</div>
								<div class="col col-12 col-md-6 viz-section">
									<div style="display:flex; flex-wrap: nowrap;">
										<h2 class="viz-title">Age of N3C Patients</h2>
										<div>
  											<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												<i class="fas fa-download"></i>
											</button>
											<div class="dropdown-menu dropdown-menu-right">
												<a class="dropdown-item" onclick="save_viz_pass('age', '.jpg', 'Age');">Save as JPG</a>
												<a class="dropdown-item" onclick="save_viz_pass('age', '.png', 'Age');">Save as PNG</a>
												<a class="dropdown-item" onclick="save_viz_pass('age', '.svg', 'Age');">Save as SVG</a>
											</div>
										</div>
									</div>
									<div class="panel-body">
										<div class="loading">
											<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
										</div>
										<div id="age_histogram"></div>
									</div>
								</div>
								<div class="col col-12 col-md-6 viz-section">
									<div style="display:flex; flex-wrap: nowrap;">
										<h2 class="viz-title">Race of N3C Patients</h2>
										<div>
  											<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												<i class="fas fa-download"></i>
											</button>
											<div class="dropdown-menu dropdown-menu-right">
												<a class="dropdown-item" onclick="save_viz_pass('race', '.jpg', 'Race');">Save as JPG</a>
												<a class="dropdown-item" onclick="save_viz_pass('race', '.png', 'Race');">Save as PNG</a>
												<a class="dropdown-item" onclick="save_viz_pass('race', '.svg', 'Race');">Save as SVG</a>
											</div>
										</div>
									</div>
									<div class="panel-body">
										<div class="loading">
											<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
										</div>
										<div id="race_histogram"></div>
									</div>
								</div>
								<div class="col col-12 col-md-6 viz-section">
									<div style="display:flex; flex-wrap: nowrap;">
										<h2 class="viz-title">Sex of N3C Patients</h2>
										<div>
  											<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												<i class="fas fa-download"></i>
											</button>
											<div class="dropdown-menu dropdown-menu-right">
												<a class="dropdown-item" onclick="save_viz_pass('sex', '.jpg', 'Sex');">Save as JPG</a>
												<a class="dropdown-item" onclick="save_viz_pass('sex', '.png', 'Sex');">Save as PNG</a>
												<a class="dropdown-item" onclick="save_viz_pass('sex', '.svg', 'Sex');">Save as SVG</a>
											</div>
										</div>
									</div>
									<div class="panel-body">
										<div class="loading">
											<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
										</div>
										<div id="sex_histogram"></div>
									</div>
								</div>
								<div class="col col-12 col-md-6 viz-section">
									<div style="display:flex; flex-wrap: nowrap;">
										<h2 class="viz-title">Ethnicity of N3C Patients</h2>
										<div>
  											<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												<i class="fas fa-download"></i>
											</button>
											<div class="dropdown-menu dropdown-menu-right">
												<a class="dropdown-item" onclick="save_viz_pass('ethnicity', '.jpg', 'Ethnicity');">Save as JPG</a>
												<a class="dropdown-item" onclick="save_viz_pass('ethnicity', '.png', 'Ethnicity');">Save as PNG</a>
												<a class="dropdown-item" onclick="save_viz_pass('ethnicity', '.svg', 'Ethnicity');">Save as SVG</a>
											</div>
										</div>
									</div>
									<div class="panel-body">
										<div class="loading">
											<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
										</div>
										<div id="ethnicity_histogram"></div>
									</div>
								</div>
								<div class="col col-12 col-md-6 viz-section">
									<div style="display:flex; flex-wrap: nowrap;">
										<h2 class="viz-title">COVID Status of N3C Patients</h2>
										<div>
  											<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												<i class="fas fa-download"></i>
											</button>
											<div class="dropdown-menu dropdown-menu-right">
												<a class="dropdown-item" onclick="save_viz_pass('covid', '.jpg', 'COVID Status');">Save as JPG</a>
												<a class="dropdown-item" onclick="save_viz_pass('covid', '.png', 'COVID Status');">Save as PNG</a>
												<a class="dropdown-item" onclick="save_viz_pass('covid', '.svg', 'COVID Status');">Save as SVG</a>
											</div>
										</div>
									</div>
									<div class="panel-body">
										<div class="loading">
											<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
										</div>
										<div id="covid_histogram"></div>
									</div>
								</div>
								<div class="col col-12 col-md-6 viz-section">
									<div style="display:flex; flex-wrap: nowrap;">
										<h2 class="viz-title">Long COVID Status of N3C Patients</h2>
										<div>
  											<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												<i class="fas fa-download"></i>
											</button>
											<div class="dropdown-menu dropdown-menu-right">
												<a class="dropdown-item" onclick="save_viz_pass('long', '.jpg', 'Long COVID Status');">Save as JPG</a>
												<a class="dropdown-item" onclick="save_viz_pass('long', '.png', 'Long COVID Status');">Save as PNG</a>
												<a class="dropdown-item" onclick="save_viz_pass('long', '.svg', 'Long COVID Status');">Save as SVG</a>
											</div>
										</div>
									</div>
									<div class="panel-body">
										<div class="loading">
											<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
										</div>
										<div id="long_histogram"></div>
									</div>
								</div>
								<div class="col col-12 col-md-6 viz-section">
									<div style="display:flex; flex-wrap: nowrap;">
										<h2 class="viz-title">Mortality Status of N3C Patients</h2>
										<div>
  											<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												<i class="fas fa-download"></i>
											</button>
											<div class="dropdown-menu dropdown-menu-right">
												<a class="dropdown-item" onclick="save_viz_pass('mortality', '.jpg', 'Mortality Status');">Save as JPG</a>
												<a class="dropdown-item" onclick="save_viz_pass('mortality', '.png', 'Mortality Status');">Save as PNG</a>
												<a class="dropdown-item" onclick="save_viz_pass('mortality', '.svg', 'Mortality Status');">Save as SVG</a>
											</div>
										</div>
									</div>
									<div class="panel-body">
										<div class="loading">
											<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
										</div>
										<div id="mortality_histogram"></div>
									</div>
								</div>
								<div class="col col-12 col-md-6 viz-section">
									<div style="display:flex; flex-wrap: nowrap;">
										<h2 class="viz-title">Vaccination Status of N3C Patients</h2>
										<div>
  											<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												<i class="fas fa-download"></i>
											</button>
											<div class="dropdown-menu dropdown-menu-right">
												<a class="dropdown-item" onclick="save_viz_pass('vaccinated', '.jpg', 'Vaccination Status');">Save as JPG</a>
												<a class="dropdown-item" onclick="save_viz_pass('vaccinated', '.png', 'Vaccination Status');">Save as PNG</a>
												<a class="dropdown-item" onclick="save_viz_pass('vaccinated', '.svg', 'Vaccination Status');">Save as SVG</a>
											</div>
										</div>
									</div>
									<div class="panel-body">
										<div class="loading">
											<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
										</div>
										<div id="vaccinated_histogram"></div>
									</div>
								</div>
							</div>
	
							<div class="secondary-description">
								<jsp:include page="secondary_text/secondary_1.jsp"/>
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
	<jsp:include page="../graph_support/horizontalBarChart_local_new.jsp"/>
	<jsp:include page="../graph_support/pieChart_local_new.jsp"/>
	<jsp:include page="../modules/popover_init.jsp"/>
	<jsp:include page="../graph_support/graphic_save.jsp"/>
	
	
<script>

$(document).ready(function() {
    $('#dimension_select').select2({
    	minimumResultsForSearch: Infinity
    });
});

$('#dimension_select').on('select2:select', function (e) {
    var data = e.params.data;
    window.open(e.params.data.id, "_self")
});

function save_viz_pass(category, extension, name){
	var viz = category + "_histogram";
	
	var id = $("#mode").find('.active-display').attr('id');
	var strings = id.split('-');
	var mode = strings[strings.length-1];
	
	var text = '';
	if (mode =='pie'){		
		text = name + " of N3C Patients (%)" + extension;
	} else {
		text = name + " of N3C Patients (#)" + extension;
	};
	
	saveVisualization(viz, text);
};


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

<jsp:include page="../feeds/configuration.jsp"/>


function updateKPI() {

	var table = $('#aggregated-table').DataTable();	
	var sum_string = '';
	var sum = 0;
	
	table.rows({ search:'applied' }).every( function ( rowIdx, tableLoop, rowLoop ) {
		var data = this.data();
		sum += data['patient_count'];
	});	
	
	var snapshotAll = table.settings().init().fulldata;
	
	var total = 0;
	for (i in snapshotAll){
		total += snapshotAll[i]['patient_count'];
	}
	
	if (sum != 0){
		var percent = ((sum/total)*100);
		var width = (Math.round(percent));
		var rount = percent;
		rount = +rount.toFixed(2);
		var widthtext = rount + "% in View"
		var bar = "demographics_patient_count_kpi_progress";
		var div = "demographics_patient_count_kpi_progressdiv";
		document.getElementById(bar).style = "width: " + width + "% !important";
		document.getElementById(div).setAttribute("data-original-title", widthtext);
	} else{
		var bar = "demographics_patient_count_kpi_progress";
		var div = "demographics_patient_count_kpi_progressdiv";
		document.getElementById(bar).style = "width: 0% !important";
		document.getElementById(div).setAttribute("data-original-title", "0% in View");
	}
	
	if (sum < 1000) {
		sumString = sum+'';
	} else if (sum < 1000000) {
		sum = sum / 1000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "k"
	} else {
		sum = sum / 1000000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "M"
		
	}
	document.getElementById('count_kpi').innerHTML = sumString;
	
}



var aggregated_datatable = null;
var ageArray = new Array();
var raceArray = new Array();
var ethnicityArray = new Array();
var sexArray = new Array();
var severityArray = new Array();
var covidArray = new Array();
var longArray = new Array();
var mortalityArray = new Array();
var vaccinatedArray = new Array();


$(document).ready( function () {
	
	$.fn.dataTable.ext.search.push(
		function( settings, searchData, index, rowData, counter ) {
			var positions = $('input:checkbox[name="race"]:checked').map(function() {
				return this.value;
			}).get();
		   
			if (positions.length === 0) {
				return true;
			}
		      
			if (positions.indexOf(searchData[13]) !== -1) {
				return true;
			}
		      
			return false;
		}
	);
	
	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="ethnicity"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[3]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );

	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="age"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[0]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );

	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="sex"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[4]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );

	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="severity"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[1]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );
	
	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="covid"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[5]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );
	
	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="long"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[6]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );
	
	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="mortality"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[7]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );
	
	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="vaccinated"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[8]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );
	
	$.getJSON("<util:applicationRoot/>/data-overview/feeds/demographics.jsp", function(data){
			
		var json = $.parseJSON(JSON.stringify(data));
		var col = [];
	
		for (i in json['headers']){
			col.push(json['headers'][i]['label']);
		}
	
	
		var table = document.createElement("table");
			table.className = 'table table-hover compact site-wrapper';
			table.style.width = '100%';
			table.id="aggregated-table";
	
		var header= table.createTHead();
		var header_row = header.insertRow(0); 
	
		for (i in col) {
			var th = document.createElement("th");
			th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
			header_row.appendChild(th);
		}
	
		var divContainer = document.getElementById("aggregated");
		divContainer.appendChild(table);
	
		var data = json['rows'];
	
		aggregated_datatable = $('#aggregated-table').DataTable( {
			data: data,
	    	dom: 'lr<"datatable_overflow"t>Bip',
	    	buttons: {
	    	    dom: {
	    	      button: {
	    	        tag: 'button',
	    	        className: ''
	    	      }
	    	    },
	    	    buttons: [{
	    	      extend: 'csv',
	    	      className: 'btn btn-sm btn-light',
	    	      titleAttr: 'CSV export.',
	    	      exportOptions: {
	                  columns: ':visible'
	              },
	    	      text: 'CSV',
	    	      filename: 'n3c_demographics',
	    	      extension: '.csv'
	    	    }, {
	    	      extend: 'copy',
	    	      className: 'btn btn-sm btn-light',
	    	      titleAttr: 'Copy table data.',
	    	      exportOptions: {
	                  columns: ':visible'
	              },
	    	      text: 'Copy'
	    	    }]
	    	},
	       	paging: true,
	       	snapshot: null,
	       	fulldata: null,
	       	covidpositive: null,
	    	initComplete: function( settings, json ) {
	       	 	settings.oInit.snapshot = $('#aggregated-table').DataTable().rows({order: 'index'}).data().toArray();
	       	 	settings.oInit.fulldata = $('#aggregated-table').DataTable().rows({order: 'index'}).data().toArray();
	       	 	jQuery('.loading').fadeOut(100);
	       	 	updateKPI();
	    	},
	    	pageLength: 10,
	    	lengthMenu: [ 10, 25, 50, 75, 100 ],
	    	order: [[0, 'asc']],
	     	columns: [
	        	{ data: 'age', visible: true, orderable: true, orderData: [12] },
	        	{ data: 'severity', visible: true, orderable: true },
	        	{ data: 'race', visible: true, orderable: true },
	        	{ data: 'ethnicity', visible: true, orderable: true },
	        	{ data: 'sex', visible: true, orderable: true },
	        	{ data: 'covid', visible: true, orderable: true },
	        	{ data: 'long', visible: true, orderable: true },
	        	{ data: 'mortality', visible: true, orderable: true },
	        	{ data: 'vaccinated', visible: true, orderable: true },
	        	{ data: 'patient_display', visible: true, orderable: true, orderData: [10] },
	        	{ data: 'patient_count', visible: false},
	        	{ data: 'age_abbrev', visible: false },
	        	{ data: 'age_seq', visible: false },
	        	{ data: 'race_abbrev', visible: false },
	        	{ data: 'race_seq', visible: false },
	        	{ data: 'ethnicity_abbrev', visible: false },
	        	{ data: 'ethnicity_seq', visible: false },
	        	{ data: 'sex_abbrev', visible: false },
	        	{ data: 'sex_seq', visible: false },
	        	{ data: 'severity_abbrev', visible: false },
	        	{ data: 'severity_seq', visible: false },
	        	{ data: 'covid_abbrev', visible: false },
	        	{ data: 'covid_seq', visible: false }
	    	]
		} );
		
//		if datatable is filtered
		aggregated_datatable.on( 'search.dt', function () {
			// snapshot of current state of datatable
			var snapshot = aggregated_datatable
		     .rows({ search: 'applied', order: 'index'})
		     .data()
		     .toArray()
		     .toString();
			// last filtered state of datatable
		  	var currentSnapshot = aggregated_datatable.settings().init().snapshot;

		  	// if last filtered state of datatable not the same as current state (not just a sort)
		  	if (currentSnapshot != snapshot) {
		  		//update datatable snapshot to current filtered state
		  		aggregated_datatable.settings().init().snapshot = snapshot;
		   		updateKPI();
		  	}
		  	
		  	if ($('#filter_checks :checkbox:checked').length > 0){
		  	    // one or more checked
		  		$('#btn_clear').removeClass("d-none");
		   		$('#btn_clear').addClass("d-block");
		  	}else{
		  	    // nothing checked
		  	    $('#btn_clear').removeClass("d-block");
		  	    $('#btn_clear').addClass("d-none");
		  	}
		} );
	
		refreshHistograms();
	});
	
	$('input:checkbox').on('change', function () {
	    aggregated_datatable.draw();
	    refreshHistograms();
	 });
} );

function refreshHistograms() {
    var data = aggregated_datatable.rows({search:'applied'}).data().toArray();
    refreshageArray(data, 'age');
    refreshraceArray(data, 'race');
    refreshethnicityArray(data, 'ethnicity');
    refreshsexArray(data, 'sex');
    refreshseverityArray(data, 'severity');
    refreshcovidArray(data, 'covid');
    refreshlongArray(data, 'long');
    refreshmortalityArray(data, 'mortality');
    refreshvaccinatedArray(data, 'vaccinated');
    
    var doBar = false;
    if (document.getElementById("mode-bar").classList.contains("active-display")) {
    	doBar = true;
    };
    
    var ageproperties = {
			domName: '#age_histogram',
			barLabelWidth: 120,
			min_height: 300,
			ordered: 0,
			colorscale: age_range_ideal,
			legend_label: 'age',
			legend_data: age_legend_ideal,
			donutRatio: 0.5
	};
    var raceproperties = {
			domName: '#race_histogram',
			barLabelWidth: 120,
			min_height: 300,
			ordered: 0,
			colorscale: race_range,
			legend_label: 'race',
			legend_data: race_legend,
			donutRatio: 0.5
	};
    var ethnicityproperties = {
			domName: '#ethnicity_histogram',
			barLabelWidth: 120,
			min_height: 300,
			ordered: 0,
			colorscale: ethnicity_range,
			legend_label: 'ethnicity',
			legend_data: ethnicity_legend,
			donutRatio: 0.5
	};
    var sexproperties = {
			domName: '#sex_histogram',
			barLabelWidth: 120,
			min_height: 300,
			ordered: 0,
			colorscale: sex_range,
			legend_label: 'sex',
			legend_data: sex_legend,
			donutRatio: 0.5
	};
    var severityproperties = {
			domName: '#severity_histogram',
			barLabelWidth: 120,
			min_height: 300,
			ordered: 0,
			colorscale: severity_range,
			legend_label: 'severity',
			legend_data: severity_legend,
			donutRatio: 0.5
	};
    var covidproperties = {
			domName: '#covid_histogram',
			barLabelWidth: 120,
			min_height: 300,
			ordered: 0,
			colorscale: covidstatus_range,
			legend_label: 'covid',
			legend_data: covidstatus_legend,
			donutRatio: 0.5
	};
    var longproperties = {
			domName: '#long_histogram',
			barLabelWidth: 120,
			min_height: 300,
			ordered: 0,
			colorscale: longstatus_range,
			legend_label: 'long',
			legend_data: longstatus_legend,
			donutRatio: 0.5
	};
    var mortalityproperties = {
			domName: '#mortality_histogram',
			barLabelWidth: 120,
			min_height: 300,
			ordered: 0,
			colorscale: mortality_range,
			legend_label: 'mortality',
			legend_data: mortality_legend,
			donutRatio: 0.5
	};
    var vaccinatedproperties = {
			domName: '#vaccinated_histogram',
			barLabelWidth: 120,
			min_height: 300,
			ordered: 0,
			colorscale: vaccinated_range,
			legend_label: 'vaccinated',
			legend_data: vaccinated_legend,
			donutRatio: 0.5
	};
    if (doBar){
    	localHorizontalBarChart_new(ageArray, ageproperties);
    	localHorizontalBarChart_new(raceArray,raceproperties);
    	localHorizontalBarChart_new(ethnicityArray,ethnicityproperties);
    	localHorizontalBarChart_new(sexArray,sexproperties);
    	localHorizontalBarChart_new(severityArray,severityproperties);
    	localHorizontalBarChart_new(covidArray,covidproperties);
    	localHorizontalBarChart_new(longArray,longproperties);
    	localHorizontalBarChart_new(mortalityArray,mortalityproperties);
    	localHorizontalBarChart_new(vaccinatedArray,vaccinatedproperties);
    }else{
    	localPieChart_new(ageArray,ageproperties);
    	localPieChart_new(raceArray,raceproperties);
    	localPieChart_new(ethnicityArray,ethnicityproperties);
    	localPieChart_new(sexArray,sexproperties);
    	localPieChart_new(severityArray,severityproperties);
    	localPieChart_new(covidArray,covidproperties);
    	localPieChart_new(longArray,longproperties);
    	localPieChart_new(mortalityArray,mortalityproperties);
    	localPieChart_new(vaccinatedArray,vaccinatedproperties);  
    };
};

var functions = ["age","ethnicity","race","sex","severity", "mortality", "long", "covid", "vaccinated"];

for (var i = 0; i < functions.length; i++) {    
	
	window[functions[i]+"_histogramviz_constrain"] = function(element, elementParent){
    	console.log(elementParent);
    	$('input:checkbox[value="' + element.secondary_name + '"][name="'+elementParent + '"]').click();
    };
	
    window["refresh"+functions[i]+"Array"] = function(data, varname){

    	var aData = new Object;
    	var bData = new Object;
    	var cData = new Object;
    	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, j ) {
        	var group = data[j][`\${varname}`];
        	var count = data[j].patient_count;
        	var abbrev = data[j][`\${varname}_abbrev`];
        	var seq = data[j][`\${varname}_seq`];
        	
            if (typeof aData[group] == 'undefined') {
                aData[group] = count;
                bData[group] = seq;
                cData[group] = abbrev;
             } else
            	 aData[group] += count;
    	});

    	window[varname+"Array"] = new Array();
        for(var x in aData) {
        	var obj = new Object();
        	Object.defineProperty(obj, 'element', {
        		  value: x
        	});
        	Object.defineProperty(obj, 'count', {
      		  value: aData[x]
      		});
        	Object.defineProperty(obj, 'seq', {
      		  value: bData[x]
      		});
        	Object.defineProperty(obj, 'abbrev', {
        		  value: cData[x]
        	});
        	eval(`\${varname}Array`).push(obj);
        }
        eval(`\${varname}Array`).sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
    };
}


function uncheckAll() {
	$('input[type="checkbox"]:checked').prop('checked',false);
	aggregated_datatable.draw();
	refreshHistograms();
}

function checkPeds() {
	$('input[type="checkbox"][value="0-4"]').prop('checked',true);
	$('input[type="checkbox"][value="5-11"]').prop('checked',true);
	$('input[type="checkbox"][value="12-15"]').prop('checked',true);
	$('input[type="checkbox"][value="16-<18"]').prop('checked',true);

	$('input[type="checkbox"][value="18-24"]').prop('checked',false);
	$('input[type="checkbox"][value="25-34"]').prop('checked',false);
	$('input[type="checkbox"][value="35-49"]').prop('checked',false);
	$('input[type="checkbox"][value="50-64"]').prop('checked',false);
	$('input[type="checkbox"][value="65+"]').prop('checked',false);
	
	aggregated_datatable.draw();
	refreshHistograms();
}

function checkAdult() {
	$('input[type="checkbox"][value="0-4"]').prop('checked',false);
	$('input[type="checkbox"][value="5-11"]').prop('checked',false);
	$('input[type="checkbox"][value="12-15"]').prop('checked',false);
	$('input[type="checkbox"][value="16-<18"]').prop('checked',false);

	$('input[type="checkbox"][value="18-24"]').prop('checked',true);
	$('input[type="checkbox"][value="25-34"]').prop('checked',true);
	$('input[type="checkbox"][value="35-49"]').prop('checked',true);
	$('input[type="checkbox"][value="50-64"]').prop('checked',true);
	$('input[type="checkbox"][value="65+"]').prop('checked',true);
	
	aggregated_datatable.draw();
	refreshHistograms();
}

$('#mode-bar').on('click', function(element) {
	if (!document.getElementById("mode-bar").classList.contains("active-display")) {
		document.getElementById("mode-bar").classList.add("active-display");
	}
	document.getElementById("mode-pie").classList.remove("active-display");
	document.getElementById("display-d3").style.display = "block";
	refreshHistograms();
});
$('#mode-pie').on('click', function(element) {
	if (!document.getElementById("mode-pie").classList.contains("active-display")) {
		document.getElementById("mode-pie").classList.add("active-display");
	}
	document.getElementById("mode-bar").classList.remove("active-display");
	document.getElementById("display-d3").style.display = "block";
	refreshHistograms();
});

</script>

</body>
</html>
