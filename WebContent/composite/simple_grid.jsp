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
							Total COVID+ Patients*
							<div class="kpi_num"><i class="fas fa-user-plus" aria-hidden="true"></i>    6.25M</div>
						</div>
						<div class="col col-7" style="border-left: 2px solid #d0e3f6;">
							Patients in View*
							<div class="kpi_num"><i class="fas fa-users" aria-hidden="true"></i>   6.26M</div>
							% of Total COVID+</br> Patients in View*
							<div class="kpi_num"><i class="fas fa-users" aria-hidden="true"></i>   100%</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col col-12 col-md-6 viz-section">
				<h4>Severity</h4>
				<div class="panel-body">
					<div id="severity_histogram"></div>
				</div>
			</div>
			<div class="col col-12 col-md-6 viz-section">
				<h4>Age</h4>
				<div class="panel-heading">
					<div id="age_histogram"></div>
				</div>
			</div>
			<div class="col col-12 col-md-6 viz-section">
				<h4>Race</h4>
				<div class="panel-body">
					<div id="race_histogram"></div>
				</div>
			</div>
			<div class="col col-12 col-md-6 viz-section">
				<h4>Sex</h4>
				<div class="panel-body">
					<div id="sex_histogram"></div>
				</div>
			</div>
			<div class="col col-12 col-md-6 viz-section">
				<h4>Ethnicity</h4>
				<div class="panel-heading">
					<div id="ethnicity_histogram"></div>
				</div>
			</div>
		</div>
		</div>
		<div id="display-table" style="display:none" class="panel panel-primary">
			<div class="panel-heading">Aggregated Data</div>
			<div class="panel-body">
				<div id="aggregated"></div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="horizontalBarChart_local.jsp"/>
<jsp:include page="pieChart_local.jsp"/>
<script>

var age_range_all = {1:"#EADEF7", 2:"#C9A8EB", 3:"#A772DF", 4:"#8642CE", 5:"#762AC6", 6:"#6512BD", 7:"#4C1EA5", 8:"#33298D"};
var race_range = {1:"#09405A", 2:"#AD1181", 3:"#8406D1", 4:"#ffa600", 5:"#ff7155", 6:"#a6a6a6", 7:"#8B8B8B"};
var ethnicity_range = {1:"#332380", 2:"#B6AAF3", 3:"#a6a6a6"};
var severity_range = {1:"#EBC4E0", 2:"#C24DA1", 3:"#AD1181", 4:"#820D61", 5:"#570941", 6:"#a6a6a6"};
var sex_range = {1:"#4833B2", 2:"#ffa600", 3:"#8406D1", 4:"#a6a6a6", 5:"#8B8B8B"};



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
			"dom": '<l<t>ip>',
	    	data: data,
	       	paging: true,
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

function uncheckAll(){
	$('input[type="checkbox"]:checked').prop('checked',false);
	aggregated_datatable.draw();
	refreshHistograms();
}

$('#mode-bar').on('click', function(element) {
	if (!document.getElementById("mode-bar").classList.contains("active-display")) {
		document.getElementById("mode-bar").classList.add("active-display");
	}
	document.getElementById("mode-pie").classList.remove("active-display");
	document.getElementById("mode-table").classList.remove("active-display");
	document.getElementById("display-table").style.display = "none";
	document.getElementById("display-d3").style.display = "block";
	refreshHistograms();
});
$('#mode-pie').on('click', function(element) {
	if (!document.getElementById("mode-pie").classList.contains("active-display")) {
		document.getElementById("mode-pie").classList.add("active-display");
	}
	document.getElementById("mode-bar").classList.remove("active-display");
	document.getElementById("mode-table").classList.remove("active-display");
	document.getElementById("display-table").style.display = "none";
	document.getElementById("display-d3").style.display = "block";
	refreshHistograms();
});
$('#mode-table').on('click', function(element) {
	if (!document.getElementById("mode-table").classList.contains("active-display")) {
		document.getElementById("mode-table").classList.add("active-display");
	}
	document.getElementById("mode-bar").classList.remove("active-display");
	document.getElementById("mode-pie").classList.remove("active-display");
	document.getElementById("display-table").style.display = "block";
	document.getElementById("display-d3").style.display = "none";
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
