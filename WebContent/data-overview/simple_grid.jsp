<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
.kpi-section{
    background: #edf6ff;
	font-weight: 600;
	padding: 15px;
}

.kpi_num{
	color: #007bff;
	font-weight: 400;
}

.kpi-row{
	text-align:center;
}

.viz-section{
	margin-bottom: 20px;
}

.viz-demo{
	color: #3f50b0;
	font-weight: 600;
	font-size: 20px;
}

.secondary-description{
	margin-top: 30px;
    background: #edf6ff;
    padding: 20px;
    margin-bottom: 30px;
}

.secondary-description p{
	margin: 0px;
}

.loading{
	text-align:center;
}

.data-as-of{
	margin-top:20px; 
	font-size:14px; 
	font-weight:300;
	margin-bottom: 0px;
}

#display-table{
	margin-bottom: 30px;
}

.viz_secondary_info p{
	margin: 0px;
}

#limitations-section .accordion_text{
	color: black;
}

</style>

<div class="row stats">
	<jsp:include page="filters.jsp"/>

	<div class="col col-12 col-md-10">
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
								<p class="data-as-of"><em>Data as of October 27, 2022 (V.98)</em></p>
							</div>
							<div class="col col-7" style="border-left: 2px solid #d0e3f6;">
								<span class="tip">
									<a class="viz_secondary_info" 
										title="<a href='#' class='close' data-dismiss='alert'>&times;</a> Total Patients in this Dashboard" 
										data-html="true" 
										data-toggle="popover" 
										data-placement="top" 
										data-content="<strong>Sample:</strong> COVID+ Patients in the N3C Data Enclave aggregated by 
											Age, Race, Ethnicity, Sex, and Severity. (Updates on Filter)<br><br>
											<em>Note: This dashboard may not include all patients in this sample, as cohorts with counts <20 are not displayed.</em>" 
										aria-describedby="tooltip">
  										<p style="white-space:nowrap;">Patients in Dashboard <i class="fas fa-info-circle" aria-hidden="true"></i>
  											<span class="sr-only">: COVID+ Patients in the N3C Data Enclave aggregated by 
												Age, Race, Ethnicity, Sex, and Severity. Note: This dashboard may not include all patients in this sample, as cohorts with counts <20 are not displayed.
  											</span>
  										</p>
  									</a>
  								</span>
								<div class="kpi_num"><i class="fas fa-users" aria-hidden="true">&nbsp;</i><span id='count_kpi'></span></div>
								
								<span class="tip">
									<a class="viz_secondary_info" 
										title="<a href='#' class='close' data-dismiss='alert'>&times;</a> % of Total COVID+ Patients in this Dashboard" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="<strong>Calculated as:</strong> The number of patients in this dashboard divided by the Total number of COVID+ Patients in the Enclave (Updates on Filter)
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
										((select sum(case when (count = '<20' or count is null) then 0 else count::numeric end) as patient_count from n3c_questions_new.all_ages_covid_pos_demo_censored)/
										(select value::numeric from n3c_admin.enclave_stats where title='covid_positive_patients'))*100
									,2) as count;
								</sql:query>
								<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
									<div class="kpi_num"><i class="fas fa-users" aria-hidden="true"></i> <span id='percent_kpi'>${row.count} %</span></div>
								</c:forEach>
								
							</div>
						</div>
					</div>
				</div>
				<div class="col col-12 col-md-6 viz-section">
					<h4 class="viz-demo">Severity</h4>
					<div class="panel-body">
						<div class="loading">
							<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
						</div>
						<div id="severity_histogram"></div>
					</div>
				</div>
				<div class="col col-12 col-md-6 viz-section">
					<h4 class="viz-demo">Age</h4>
					<div class="panel-body">
						<div class="loading">
							<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
						</div>
						<div id="age_histogram"></div>
					</div>
				</div>
				<div class="col col-12 col-md-6 viz-section">
					<h4 class="viz-demo">Race</h4>
					<div class="panel-body">
						<div class="loading">
							<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
						</div>
						<div id="race_histogram"></div>
					</div>
				</div>
				<div class="col col-12 col-md-6 viz-section">
					<h4 class="viz-demo">Sex</h4>
					<div class="panel-body">
						<div class="loading">
							<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
						</div>
						<div id="sex_histogram"></div>
					</div>
				</div>
				<div class="col col-12 col-md-6 viz-section">
					<h4 class="viz-demo">Ethnicity</h4>
					<div class="panel-body">
						<div class="loading">
							<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
						</div>
						<div id="ethnicity_histogram"></div>
					</div>
				</div>
			</div>
			<div class="secondary-description">
				<p><strong>Sample:</strong> <span class="tip">
					<a class="viz_secondary_info" title="COVID+ Defined As: <a href='#' class='close' data-dismiss='alert'>&times;</a>" data-html="true" data-toggle="popover" data-placement="top" data-content="<ul style='padding-inline-start: 15px;'><li>Laboratory-confirmed positive COVID-19 PCR or Antigen test</li><li>(or) Laboratory-confirmed positive COVID-19 Antibody test</li><li>(or) Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</li></ul>" aria-describedby="tooltip">
  						<u style="white-space:nowrap;">COVID+ patients <i class="fa fa-info" aria-hidden="true"></i></u> 
  						<span class="sr-only">, or patients who have had, a laboratory-confirmed positive COVID-19 PCR or Antigen test, a laboratory-confirmed positive COVID-19 Antibody test, or a Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</span>
					</a>
					</span>&nbsp;in the N3C Data Enclave. Data aggregated by Age, Race, Ethnicity, Sex, and Severity. 
					For additional information, <a onclick="${param.block}limitlink(); return false;" href="#limitations-section">see limitations below</a>.
				</p>
			</div>
		</div>
		<div id="display-table" class="panel panel-primary">
			<div class="panel-body">
				<div id="aggregated"></div>
			</div>
		</div>
		
		<c:import url="composite/limitations.jsp"/>
	</div>
</div>
<jsp:include page="horizontalBarChart_local.jsp"/>
<jsp:include page="pieChart_local.jsp"/>
<script>

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

//color codes
var age_range_all = {1:"#EADEF7", 2:"#C9A8EB", 3:"#A772DF", 4:"#8642CE", 5:"#762AC6", 6:"#6512BD", 7:"#4C1EA5", 8:"#33298D"};
var race_range = {1:"#09405A", 2:"#AD1181", 3:"#8406D1", 4:"#ffa600", 5:"#ff7155", 6:"#a6a6a6", 7:"#8B8B8B"};
var ethnicity_range = {1:"#332380", 2:"#B6AAF3", 3:"#a6a6a6"};
var severity_range = {1:"#EBC4E0", 2:"#C24DA1", 3:"#AD1181", 4:"#820D61", 5:"#570941", 6:"#a6a6a6"};
var sex_range = {1:"#4833B2", 2:"#ffa600", 3:"#8406D1", 4:"#a6a6a6", 5:"#8B8B8B"};

function updateKPI() {
	var table = $('#aggregated-table').DataTable();	
	var sum_string = '';
	var data_total = table.rows({search:'applied'}).data();
	
	var sum = data_total.reduce((sum,a)=>{
		  return sum + a.patient_count;
	},0);

	var covidstring = table.settings().init().covidpositive;
	if (covidstring){
		var totalcovid = parseFloat(covidstring.replace(/\,/g, ''));
		document.getElementById('percent_kpi').innerHTML = ((sum/totalcovid)*100).toFixed(2) + '%';
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

$(document).ready( function () {
	$.fn.dataTable.ext.search.push(
		    function( settings, searchData, index, rowData, counter ) {
		      var positions = $('input:checkbox[name="race"]:checked').map(function() {
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
		      var positions = $('input:checkbox[name="ethnicity"]:checked').map(function() {
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
		      var positions = $('input:checkbox[name="age_bin"]:checked').map(function() {
		        return this.value;
		      }).get();
		   
		      if (positions.length === 0) {
		        return true;
		      }
		      
		      if (positions.indexOf(searchData[2]) !== -1) {
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
		      
		      if (positions.indexOf(searchData[3]) !== -1) {
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
		      
		      if (positions.indexOf(searchData[4]) !== -1) {
		        return true;
		      }
		      
		      return false;
		    }
		  );
	
	$.getJSON("<util:applicationRoot/>/feeds/aggregated.jsp", function(data){
			
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
	    	      filename: 'covid_positive_demographics',
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
	       	 	settings.oInit.snapshot = $('#${param.target_div}-table').DataTable().rows({order: 'index'}).data().toArray().toString();
	       	 	settings.oInit.fulldata = $('#${param.target_div}-table').DataTable().rows({order: 'index'}).data().toArray().toString();
	       	 	$.getJSON("<util:applicationRoot/>/feeds/embedded_fact_sheet.jsp", function(json){
	       			var data = $.parseJSON(JSON.stringify(json));
	       			settings.oInit.covidpositive = data['covid_positive_patients']; 	
	       		});
	       	 	jQuery('.loading').fadeOut(100);
	       		updateKPI();
	    	},
	    	pageLength: 10,
	    	lengthMenu: [ 10, 25, 50, 75, 100 ],
	    	order: [[0, 'asc']],
	     	columns: [
	        	{ data: 'race', visible: true, orderable: true },
	        	{ data: 'ethnicity', visible: true, orderable: true },
	        	{ data: 'age_bin', visible: true, orderable: true },
	        	{ data: 'sex', visible: true, orderable: true },
	        	{ data: 'severity', visible: true, orderable: true },
	        	{ data: 'patient_count', visible: true, orderable: true },
	        	{ data: 'age_abbrev', visible: false },
	        	{ data: 'age_seq', visible: false },
	        	{ data: 'race_abbrev', visible: false },
	        	{ data: 'race_seq', visible: false },
	        	{ data: 'ethnicity_abbrev', visible: false },
	        	{ data: 'ethnicity_seq', visible: false },
	        	{ data: 'sex_abbrev', visible: false },
	        	{ data: 'sex_seq', visible: false },
	        	{ data: 'severity_abbrev', visible: false },
	        	{ data: 'severity_seq', visible: false }
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
    refreshAgeArray(data);
    refreshRaceArray(data);
    refreshEthnicityArray(data);
    refreshSexArray(data);
    refreshSeverityArray(data);
    
    var doBar = false;
    if (document.getElementById("mode-bar").classList.contains("active-display")) {
    	doBar = true;
    }
    d3.select("#age_histogram").select("svg").remove();
    if (doBar)
    	localBarChart(ageArray,"#age_histogram",120, age_range_all);
    else
    	localPieChart(ageArray,"#age_histogram", age_range_all);

    d3.select("#race_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(raceArray,"#race_histogram",120, race_range);
    else
    	localPieChart(raceArray,"#race_histogram", race_range);

    d3.select("#ethnicity_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(ethnicityArray,"#ethnicity_histogram",120, ethnicity_range);
    else
    	localPieChart(ethnicityArray,"#ethnicity_histogram", ethnicity_range);

    d3.select("#sex_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(sexArray,"#sex_histogram",120, sex_range);
    else
    	localPieChart(sexArray,"#sex_histogram", sex_range);

    d3.select("#severity_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(severityArray,"#severity_histogram",120, severity_range);
    else
    	localPieChart(severityArray,"#severity_histogram", severity_range);
}

function refreshAgeArray(data) {
	var aData = new Object;
	var bData = new Object;
	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
    	var group = data[i].age_bin;
    	var count = data[i].patient_count;
    	var seq = data[i].age_seq;
        if (typeof aData[group] == 'undefined') {
            aData[group] = count;
            bData[group] = seq;
         } else
        	 aData[group] += count;
	});

	ageArray = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	Object.defineProperty(obj, 'seq', {
  		  value: bData[i]
  		});
    	ageArray.push(obj);
    }
    ageArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
//     console.log(ageArray);
}

function refreshRaceArray(data) {
	var aData = new Object;
	var bData = new Object;
	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
   	var group = data[i].race;
   	switch (data[i].race) {
   	case "White":
   		group = "White";
   		break;
	case "Black or African American":
		group = "Black";
		break;
	case "Asian":
		group = "Asian";
		break;
   	case "Native Hawaiian or Other Pacific Islander":
   		group = "NHPI";
   		break;
   	case "Other":
   		group = "Other";
   		break;
   	case "Missing/Unknown":
   		group = "Missing";
   		break;
   	};
	var count = data[i].patient_count;
	var seq = data[i].race_seq;
        if (typeof aData[group] == 'undefined') {
            aData[group] = count;
            bData[group] = seq;
         } else
        	 aData[group] += count;
	});

    raceArray = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	Object.defineProperty(obj, 'seq', {
    		  value: bData[i]
    		});
    	raceArray.push(obj);
    }
    raceArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
//     console.log(raceArray);
}

function refreshEthnicityArray(data) {
	var aData = new Object;
	var bData = new Object;
	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
    	var group = data[i].ethnicity_abbrev;
    	var count = data[i].patient_count;
    	var seq = data[i].ethnicity_seq;
        if (typeof aData[group] == 'undefined') {
            aData[group] = count;
            bData[group] = seq;
         } else
        	 aData[group] += count;
	});

	ethnicityArray = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	Object.defineProperty(obj, 'seq', {
  		  value: bData[i]
  		});
    	ethnicityArray.push(obj);
    }
    ethnicityArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
//     console.log(ethnicityArray);
}

function refreshSexArray(data) {
	var aData = new Object;
	var bData = new Object;
	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
    	var group = data[i].sex;
       	switch (data[i].sex) {
       	case "MALE":
       		group = "Male";
       		break;
    	case "FEMALE":
    		group = "Female";
    		break;
    	case "OTHER":
    		group = "Other";
    		break;
       	case "Other":
       		group = "Other";
       		break;
       	case "Unkown":
       		group = "Unkown";
       		break;
       	case "Sex unkown":
       		group = "Unkown";
       		break;
       	};
    	var count = data[i].patient_count;
    	var seq = data[i].sex_seq;
      if (typeof aData[group] == 'undefined') {
            aData[group] = count;
            bData[group] = seq;
        } else
        	 aData[group] += count;
	});

	sexArray = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	Object.defineProperty(obj, 'seq', {
    		  value: bData[i]
    		});
    	sexArray.push(obj);
    }
    sexArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
//     console.log(sexArray);
}

function refreshSeverityArray(data) {
	var aData = new Object;
	var bData = new Object;
	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
    	var group = data[i].severity;
       	switch (data[i].severity) {
       	case "Mild":
       		group = "Mild";
       		break;
    	case "Mild_ED":
    		group = "Mild in ED ";
    		break;
    	case "Moderate":
    		group = "Moderate";
    		break;
       	case "Severe":
       		group = "Severe";
       		break;
       	case "Dead_w_COVID":
       		group = "Dead w/ COVID";
       		break;
       	};
    	var count = data[i].patient_count;
    	var seq = data[i].severity_seq;
        if (typeof aData[group] == 'undefined') {
            aData[group] = count;
            bData[group] = seq;
         } else
        	 aData[group] += count;
	});

	severityArray = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	Object.defineProperty(obj, 'seq', {
  		  value: bData[i]
  		});
    	severityArray.push(obj);
    }
    severityArray.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
//     console.log(severityArray);
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

	$('input[type="checkbox"][value="18-29"]').prop('checked',false);
	$('input[type="checkbox"][value="30-49"]').prop('checked',false);
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

	$('input[type="checkbox"][value="18-29"]').prop('checked',true);
	$('input[type="checkbox"][value="30-49"]').prop('checked',true);
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


$('#age').on('click', function() {
	var panel = document.getElementById("age_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Age";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Age";
		panel.style.display = "none";
	}
});
$('#race').on('click', function() {
	var panel = document.getElementById("race_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Race";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Race";
		panel.style.display = "none";
	}
});
$('#ethnicity').on('click', function() {
	var panel = document.getElementById("ethnicity_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Ethnicity";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Ethnicity";
		panel.style.display = "none";
	}
});
$('#sex').on('click', function() {
	var panel = document.getElementById("sex_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Sex";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Sex";
		panel.style.display = "none";
	}
});
$('#severity').on('click', function() {
	var panel = document.getElementById("severity_panel");
	if (panel.style.display === "none") {
		this.innerHTML = "<i class='fas fa-chevron-down'></i> Severity";
		panel.style.display = "block";
	} else {
		this.innerHTML = "<i class='fas fa-chevron-right'></i> Severity";
		panel.style.display = "none";
	}
});
</script>
