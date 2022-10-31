<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
	.selection-section{
		margin-bottom:20px;
	}
	
	.viz_section{
		margin-bottom:20px;
	}
	
	#explore_filters .panel-body{
		text-align:center;
	}
	.panel-options{
    	width: fit-content;
    	margin: auto;
    	text-align: left;
	}
	
	.text-success{
		color:#4E2D59 !important;
	}
	
	.strong{
		font-weight: 600;
	}
	
	#mode-pie, 
	#mode-bar, 
	#mode-table{
		cursor: pointer;
	}
	
	.no_clear{
		display:none;
	}
	
	.viz-mode .fas{
		cursor: pointer;
		color: #bae4ea;
	}

	.viz-mode .fas:hover{
		color: #117a8b;
	}
	.viz-mode .text-success{
		color: #117a8b !important;
	}
	
	.dash-filter-btn2{
		color: #117a8b;
	}
	
	.dash-filter-btn2:hover{
		color: #0b525d;
	}
	
	.col-left{
			text-align: left;
			margin-left: auto
		}
		.col-right{
			text-align: right;
			margin-right: auto
		}

	
	@media (max-width: 992px){
		.col-left, .col-right{
			text-align: center;
			margin: auto
		}
	}
</style>

<div class="row">
	<div class="col-12">
		<div class="row" style="text-align:center;">
			<div class="col-12 col-md-4 col-left">
				<div class="selection-section">
					<div id="mode" class="panel-heading viz-mode">
						<h5>Display:
							<i id="mode-pie" class="fas fa-chart-pie fa-lg" style="display:none;"></i> 
							<i id="mode-bar" class="fas fa-chart-bar fa-lg text-success"></i> 
							<i id="mode-table" class="fas fa-table fa-lg"></i>
						</h5>
					</div>
				</div>
			</div>
			<div class="col-12 col-right col-md-4 filter_button_container" style="text-align:right;">
				<button id="table_clear" class="btn button dash-filter-btn2 mt-0 no_clear" onclick="clear_search();"><i class="fas fa-times-circle"></i> Clear Filters</button>
				<div class="dropdown" style="display: inline-block;">
					<button data-bs-auto-close="false" class="btn btn-primary dropdown-toggle mt-0 show_filt" type="button" id="dropdownMenuButton" data-toggle="" aria-haspopup="true" aria-expanded="false">Chart/Table Filters</button>
					<div id="filter_options_drop" class="dropdown-menu dropdown-menu-right drop_filter" aria-labelledby="dropdownMenuButton">
						<div class="kpi_section" style="text-align:center;">	
							<div class="panel-body">
								<h6>Age</h6>
								<select id="age-select" multiple="multiple">
									<sql:query var="ages" dataSource="jdbc/N3CPublic">
										select age_bin,sum(count::int)
										from n3c_questions_new.all_ages_covid_pos_demo_censored,n3c_dashboard.age_map8
										where age_bin=age and count!='<20' group by 1,age_seq order by age_seq;
									</sql:query>
									<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
										<option value="${row.age_bin}">${row.age_bin}</option>
									</c:forEach>
								</select>
							</div>
							<div class="panel-body">
								<h6>Sex</h6>
								<select id="sex-select" multiple="multiple">
									<sql:query var="sex" dataSource="jdbc/N3CPublic">
										select gender_abbrev as sex,sum(case when (count = '<20' or count is null) then 0 else count::int end)
										from n3c_questions_new.all_ages_covid_pos_demo_censored,n3c_dashboard.gender_map3
										where gender_concept_name=gender group by 1,gender_seq order by gender_seq;
									</sql:query>
									<c:forEach items="${sex.rows}" var="row" varStatus="rowCounter">
										<option value="${row.sex}">${row.sex}</option>
									</c:forEach>
								</select>
							</div>
							<div class="panel-body">
								<h6>Race</h6>
								<select id="race-select" multiple="multiple">
									<sql:query var="race" dataSource="jdbc/N3CPublic">
										select race_abbrev,sum(case when (count = '<20' or count is null) then 0 else count::int end)
										from n3c_questions_new.all_ages_covid_pos_demo_censored natural join n3c_dashboard.race_map
										group by 1,race_seq order by race_seq;
									</sql:query>
									<c:forEach items="${race.rows}" var="row" varStatus="rowCounter">
										<option value="${row.race_abbrev}">${row.race_abbrev}</option>
									</c:forEach>
								</select>
							</div>
							<div class="panel-body">
								<h6>Ethnicity</h6>
								<select id="ethnicity-select" multiple="multiple">
									<sql:query var="ethnicity" dataSource="jdbc/N3CPublic">
										select all_ages_covid_pos_demo_censored.ethnicity,ethnicity_abbrev,sum(case when (count = '<20' or count is null) then 0 else count::int end)
										from n3c_questions_new.all_ages_covid_pos_demo_censored natural join n3c_dashboard.ethnicity_map
										group by 1,2,ethnicity_seq order by ethnicity_seq;
									</sql:query>
									<c:forEach items="${ethnicity.rows}" var="row" varStatus="rowCounter">
										<option value="${row.ethnicity}">${row.ethnicity_abbrev}</option>
									</c:forEach>
								</select>
							</div>
							<div class="panel-body">
								<h6>Severity</h6>
								<select id="severity-select" multiple="multiple">
									<sql:query var="severity" dataSource="jdbc/N3CPublic">
										select severity_abbrev,sum(case when (count = '<20' or count is null) then 0 else count::int end)
										from n3c_questions_new.all_ages_covid_pos_demo_censored,n3c_dashboard.severity_map
										where severity_type = severity
										group by 1,severity_seq order by severity_seq;
									</sql:query>
									<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
										<option value="${row.severity_abbrev}">${row.severity_abbrev}</option>
									</c:forEach>
								</select>
							</div>	
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-12">
		<div id="display-d3" class="mx-auto" style="max-width: 950px;">
		<div class="row">
			<div class="col-12 col-lg-6 viz_section">
				<h5 class="text-center strong">Age</h5>
				<div class="panel-heading">
					<div id="age_histogram"></div>
				</div>
			</div>
			<div class="col-12 col-lg-6 viz_section">
				<h5 class="text-center strong">Sex</h5>
				<div class="panel-body">
					<div id="sex_histogram"></div>
				</div>
			</div>
		</div>
		<div class="row stats">
			<div class="col-12 col-lg-6 viz_section">
				<h5 class="text-center strong">Race</h5>
				<div class="panel-body">
					<div id="race_histogram"></div>
				</div>
			</div>
			<div class="col-12 col-lg-6 viz_section">
				<h5 class="text-center strong">Ethnicity</h5>
				<div class="panel-heading">
					<div id="ethnicity_histogram"></div>
				</div>
			</div>
		</div>
		<div class="row stats">
			<div class="col-12 col-lg-6 viz_section">
				<h5 class="text-center strong">Severity</h5>
				<div class="panel-body">
					<div id="severity_histogram"></div>
				</div>
			</div>
		</div>
		</div>
		<div id="display-table" style="display:none; width:100%; overflow:scroll;" class="panel panel-primary text-max mx-auto">
			<div class="panel-heading">Aggregated Data</div>
			<div class="panel-body">
				<div id="aggregated"></div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../modules/verticalBarChart_local.jsp"/>
<jsp:include page="../modules/pieChart_local.jsp"/>
<script>

$('#dropdownMenuButton').on('click', function() {
	$("#filter_options_drop").toggleClass('show');
	$(this).toggleClass('show_filt hide_filt');
});

$('#age-select').multiselect({
 	onChange: function(option, checked, select) {
		var options = $('#age-select');
		var selected = [];
        $(options).each(function(){
            selected.push($(this).val());
        });

        for (i in selected[0]){
        	selected[0][i] = "^" + selected[0][i] + "$";
        }

       // console.log(selected[0].join("|"));
        var table = $('#aggregated-table').DataTable();
        table.column(2).search(selected[0].join("|"), true, false, true).draw();
        
		aggregated_datatable.draw();
	    refreshHistograms();
     }
});

$('#sex-select').multiselect({
 	onChange: function(option, checked, select) {
		var options = $('#sex-select');
		var selected = [];
        $(options).each(function(){
            selected.push($(this).val());
        });
        
        for (i in selected[0]){
        	selected[0][i] = "^" + selected[0][i] + "$";
        }

        var table = $('#aggregated-table').DataTable();
        table.column(3).search(selected[0].join("|"), true, false, true).draw();
        
		aggregated_datatable.draw();
	    refreshHistograms();
     }
});

$('#race-select').multiselect({
 	onChange: function(option, checked, select) {
		var options = $('#race-select');
		var selected = [];
        $(options).each(function(){
            selected.push($(this).val());
        });

        var table = $('#aggregated-table').DataTable();
        table.column(0).search(selected[0].join("|"), true, false, true).draw();
        
		aggregated_datatable.draw();
	    refreshHistograms();
     }
});

$('#ethnicity-select').multiselect({
 	onChange: function(option, checked, select) {
		var options = $('#ethnicity-select');
		var selected = [];
        $(options).each(function(){
            selected.push($(this).val());
        });

        var table = $('#aggregated-table').DataTable();
        table.column(1).search(selected[0].join("|"), true, false, true).draw();
        
		aggregated_datatable.draw();
	    refreshHistograms();
     }
});

$('#severity-select').multiselect({
 	onChange: function(option, checked, select) {
 		var options = $('#severity-select');
		var selected = [];
        $(options).each(function(){
            selected.push($(this).val());
        });
        
        for (i in selected[0]){
        	selected[0][i] = "^" + selected[0][i] + "$";
        }
        
        var table = $('#aggregated-table').DataTable();
        table.column(14).search(selected[0].join("|"), true, false, true).draw();
        
		aggregated_datatable.draw();
	    refreshHistograms();
     }
});

function clear_search(){
	
	$('#table_clear').removeClass("show_clear");
	$('#table_clear').addClass("no_clear");
	
	$('#age-select').multiselect('clearSelection');
	$('#sex-select').multiselect('clearSelection');
	$('#race-select').multiselect('clearSelection');
	$('#ethnicity-select').multiselect('clearSelection');
	$('#severity-select').multiselect('clearSelection');
	
	var table = $('#aggregated-table').DataTable();
	table.column(2).search("", true, false, true).draw();
	table.column(3).search("", true, false, true).draw();
	table.column(0).search("", true, false, true).draw();
	table.column(1).search("", true, false, true).draw();
	table.column(14).search("", true, false, true).draw();
	
	aggregated_datatable.draw();
    refreshHistograms();
};
	
var aggregated_datatable = null;
var ageArray = new Array();
var raceArray = new Array();
var ethnicityArray = new Array();
var sexArray = new Array();
var severityArray = new Array();

$(document).ready( function () {
	
	$.getJSON("feeds/aggregated.jsp", function(data){
			
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
			"dom": '<l<t>Bip>',
	    	data: data,
	       	paging: true,
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
	    	      filename: 'enclave_overview',
	    	      extension: '.csv'
	    	    }, {
	    	      extend: 'copy',
	    	      className: 'btn btn-sm btn-light',
	    	      exportOptions: {
	                  columns: ':visible'
	              },
	    	      titleAttr: 'Copy table data.',
	    	      text: 'Copy'
	    	    }]
	    	},
	       	snapshot: null,
	       	snapshot2: null,
	       	initComplete: function( settings, json ) {
	       	 	settings.oInit.snapshot = $('#aggregated-table').DataTable().rows({order: 'index'}).data().toArray().toString();
	       	 	settings.oInit.snapshot2 = $('#aggregated-table').DataTable().rows({order: 'index'}).data().toArray().toString();
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
		
		aggregated_datatable.on( 'search.dt', function () {
			// console.log('reached');
			var snapshot = aggregated_datatable
		     .rows({ search: 'applied', order: 'index'})
		     .data()
		     .toArray()
		     .toString();

		  	var currentSnapshot =  aggregated_datatable.settings().init().snapshot;

		  	if (currentSnapshot != snapshot) {
		   		$('#table_clear').removeClass("no_clear");
		   		$('#table_clear').addClass("show_clear");
		  	}
		  	
		  	if (snapshot == aggregated_datatable.settings().init().snapshot2) {
		   		$('#table_clear').removeClass("show_clear");
		   		$('#table_clear').addClass("no_clear");
		  	}
		} );
	
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
    if (document.getElementById("mode-bar").classList.contains("text-success")) {
    	doBar = true;
    }
    d3.select("#age_histogram").select("svg").remove();
    if (doBar)
    	localBarChart(ageArray,"#age_histogram",135);
    else
    	localPieChart(ageArray,"#age_histogram");

    d3.select("#race_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(raceArray,"#race_histogram",135);
    else
    	localPieChart(raceArray,"#race_histogram");

    d3.select("#ethnicity_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(ethnicityArray,"#ethnicity_histogram",135);
    else
    	localPieChart(ethnicityArray,"#ethnicity_histogram");

    d3.select("#sex_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(sexArray,"#sex_histogram",135);
    else
    	localPieChart(sexArray,"#sex_histogram");

    d3.select("#severity_histogram").select("svg").remove();
    if (doBar)
	    localBarChart(severityArray,"#severity_histogram",135);
    else
    	localPieChart(severityArray,"#severity_histogram");
}

function refreshAgeArray(data) {
	var aData = new Object;
	var bData = new Object;
	aggregated_datatable.rows({search:'applied'}).data().each( function ( group, i ) {
    	var group = data[i].age_bin;
    	var seq = data[i].age_seq;
    	var count = data[i].patient_count;
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
       		group = "Mortality";
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
}

function uncheckAll(){
	$('input[type="checkbox"]:checked').prop('checked',false);
	aggregated_datatable.draw();
	refreshHistograms();
}

$('#mode-bar').on('click', function(element) {
	if (!document.getElementById("mode-bar").classList.contains("text-success")) {
		document.getElementById("mode-bar").classList.add("text-success");
	}
	document.getElementById("mode-pie").classList.remove("text-success");
	document.getElementById("mode-table").classList.remove("text-success");
	document.getElementById("display-table").style.display = "none";
	document.getElementById("display-d3").style.display = "block";
	refreshHistograms();
});
$('#mode-pie').on('click', function(element) {
	if (!document.getElementById("mode-pie").classList.contains("text-success")) {
		document.getElementById("mode-pie").classList.add("text-success");
	}
	document.getElementById("mode-bar").classList.remove("text-success");
	document.getElementById("mode-table").classList.remove("text-success");
	document.getElementById("display-table").style.display = "none";
	document.getElementById("display-d3").style.display = "block";
	refreshHistograms();
});
$('#mode-table').on('click', function(element) {
	if (!document.getElementById("mode-table").classList.contains("text-success")) {
		document.getElementById("mode-table").classList.add("text-success");
	}
	document.getElementById("mode-bar").classList.remove("text-success");
	document.getElementById("mode-pie").classList.remove("text-success");
	document.getElementById("display-table").style.display = "block";
	document.getElementById("display-d3").style.display = "none";
});

</script>