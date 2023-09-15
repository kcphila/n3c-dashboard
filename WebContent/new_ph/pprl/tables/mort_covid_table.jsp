<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<script>


// kpi updates ///////////////////////////////
function ${param.block}_constrain_table(filter, constraint) {
	var table = $('#${param.target_div}-table').DataTable();

	
	switch (filter) {
	case 'race':
		table.column(0).search(constraint, true, false, true).draw();	
		break;
	case 'severity':
		table.column(1).search(constraint, true, false, true).draw();	
		break;
	case 'longstatus':
		table.column(2).search(constraint, true, false, true).draw();	
		break;
	case 'vaccinated':
		table.column(3).search(constraint, true, false, true).draw();	
		break;
	}
	
	
	var kpis = '${param.target_kpis}'.split(',');
	for (var a in kpis) {
		${param.block}_updateKPI(table, kpis[a])
	}
}

function ${param.block}_updateKPI(table, column) {
	var sum_string = '';
	var sum = 0;
	
	table.rows({ search:'applied' }).every( function ( rowIdx, tableLoop, rowLoop ) {
		var data = this.data();
		if (column == 'patient_count'){
			sum += data['patient_count'];
		};
		
		if (column == 'covid_patient_count'){
			if (data['status'] == 'Positive'){
				sum += data['patient_count'];
			};
		};
	});	
	
	var snapshotAll = table.settings().init().snapshotAll;
	
	var total = 0;
	for (i in snapshotAll){
		if (column == 'patient_count'){
			total += snapshotAll[i]['patient_count'];
		};
	}
	if (column == 'patient_count'){
		if (sum != 0){
			var percent = ((sum/total)*100);
			var width = (Math.round(percent));
			var rount = percent;
			rount = +rount.toFixed(2);
			var widthtext = rount + "% in View"
			var bar = "${param.block}_"+ column +"_kpi_progress";
			var div = "${param.block}_"+ column +"_kpi_progressdiv";
			document.getElementById(bar).style = "width: " + width + "% !important";
			document.getElementById(div).setAttribute("data-original-title", widthtext);
		} else{
			var bar = "${param.block}_"+ column +"_kpi_progress";
			var div = "${param.block}_"+ column +"_kpi_progressdiv";
			document.getElementById(bar).style = "width: 0% !important";
			document.getElementById(div).setAttribute("data-original-title", "0% in View");
		}
	};
	
	

	if (sum < 1000) {
		sumString = sum+'';
	} else if (sum < 1000000) {
		sum = sum / 1000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "k";
	} else {
		sum = sum / 1000000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "M";
		
	}
	document.getElementById('${param.block}'+'_'+column+'_kpi').innerHTML = sumString;
}

jQuery.fn.dataTable.Api.register( 'sum()', function ( ) {
	return this.flatten().reduce( function ( a, b ) {
		if ( typeof a === 'string' ) {
			a = a.replace(/[^\d.-]/g, '') * 1;
		}
		if ( typeof b === 'string' ) {
			b = b.replace(/[^\d.-]/g, '') * 1;
		}

		return a + b;
	}, 0 );
} );

var ${param.block}_datatable = null;


// datatable setup ////////////////////////
$.getJSON("<util:applicationRoot/>/new_ph/${param.feed}", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover compact site-wrapper';
	table.style.width = '100%';
	table.id="${param.target_div}-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("${param.target_div}");
	divContainer.appendChild(table);

	var data = json['rows'];

	var ${param.block}_datatable = $('#${param.target_div}-table').DataTable( {
	    data: data,
    	dom: 'lfr<"datatable_overflow"t>Bip',
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
    	      filename: 'pprl_mortality_covid_factors',
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
       	paging: true,
       	snapshot: null,
       	initComplete: function( settings, json ) {
       	 	settings.oInit.snapshot = $('#${param.target_div}-table').DataTable().rows({order: 'index'}).data().toArray();
       	 	settings.oInit.snapshotAll = $('#${param.target_div}-table').DataTable().rows({order: 'index'}).data().toArray();
       	 	setTimeout(function() {jQuery('.loading').fadeOut(100); ${param.block}_refreshHistograms();}, 500);
       	},
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
     		{ data: 'race', visible: true, orderable: true},
        	{ data: 'severity', visible: true, orderable: true, orderData: [9]  },
        	{ data: 'long', visible: true, orderable: true},
        	{ data: 'vaccinated', visible: true, orderable: true },
        	{ data: 'patient_display', visible: true, orderable: true, orderData: [5] },
        	{ data: 'patient_count', visible: false },
        	{ data: 'race_abbrev', visible: false },
        	{ data: 'race_seq', visible: false },
        	{ data: 'severity_abbrev', visible: false },
        	{ data: 'severity_seq', visible: false },
        	{ data: 'long_abbrev', visible: false },
        	{ data: 'long_seq', visible: false },
        	{ data: 'vaccinated_abbrev', visible: false },
        	{ data: 'vaccinated_seq', visible: false }
    	]
	} );
	
	//table search logic that distinguishes sort/filter 
	$('#${param.target_div}-table').DataTable().on( 'search.dt', function () {

		var snapshot = ${param.block}_datatable
	     .rows({ search: 'applied', order: 'index'})
	     .data()
	     .toArray().toString();

	  	var currentSnapshot = ${param.block}_datatable.settings().init().snapshot;
	  	var snapshotAll = ${param.block}_datatable.settings().init().snapshotAll;
	  	

	  	if (currentSnapshot != snapshot && snapshot != snapshotAll) {
	  		${param.block}_datatable.settings().init().snapshot = snapshot;
	  		${param.block}_refreshHistograms();
			${param.block}_constrain_table();
	   		$('#${param.block}_btn_clear').removeClass("no_clear");
	   		$('#${param.block}_btn_clear').addClass("show_clear");
	  	}
	  	
	  	if (snapshot == snapshotAll && currentSnapshot != snapshot) {
	  		${param.block}_datatable.settings().init().snapshot = snapshot;
	  		${param.block}_refreshHistograms();
			${param.block}_constrain_table();
	   		$('#${param.block}_btn_clear').removeClass("show_clear");
	   		$('#${param.block}_btn_clear').addClass("no_clear");
	  	}
	} );
});





</script>
