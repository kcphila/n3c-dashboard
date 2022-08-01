<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<script>

function ${param.block}_constrain_table(filter, constraint) {
	// console.log("timeline constraint", filter, constraint);
	var table = $('#${param.target_div}-table').DataTable();
	
	switch (filter) {
	case 'intervalbin':
		table.column(3).search(constraint, true, false, true).draw();	
		break;
	}
	
	var kpis = '${param.target_kpis}'.split(',');
	for (var a in kpis) {
		${param.block}_updateKPI(table, kpis[a])
	}
	
	${param.block}_refreshHistograms();
	${param.block}_interval_refresh();
}

function ${param.block}_updateKPI(table, column) {
	var sum_string = '';
	var sum = table.rows({search:'applied'}).data().pluck(column).sum();
	// console.log(sum);
	if (sum < 1000) {
		sumString = sum+'';
	} else if (sum < 1000000) {
		sum = sum / 1000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "k"
	} else {
		sum = sum / 1000000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "M"
		
	}
	// console.log('${param.block}', column, sumString)
	document.getElementById('${param.block}'+'_'+column+'_kpi').innerHTML = sumString
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

$(document).ready( function () {

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
	    	      exportOptions: {
	                  columns: ':visible'
	              },
	    	      titleAttr: 'CSV export.',
	    	      text: 'CSV',
	    	      filename: 'reinfection_intervals_csv_export',
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
	       	 	settings.oInit.snapshot = $('#${param.target_div}-table').DataTable().rows({order: 'index'}).data().toArray().toString();
	       	  },
	    	pageLength: 10,
	    	lengthMenu: [ 10, 25, 50, 75, 100 ],
	    	order: [[0, 'asc']],
	     	columns: [
	        	{ data: 'initial_infection', visible: true, orderable: true, className: 'text-center', orderData: [6] },
	        	{ data: 'subsequent_infection', visible: true, orderable: true, className: 'text-center', orderData: [7] },
	        	{ data: 'interval', visible: true, orderable: true, className: 'text-right' },
	        	{ data: 'interval_bin', visible: true, orderable: true, className: 'text-center', orderData: [8] },
	        	{ data: 'count', visible: true, orderable: true, className: 'text-right', orderData: [5] },
	        	{ data: 'actual_count', visible: false, orderable: true, className: 'text-right' },
	        	{ data: 'initial', visible: false, orderable: true, className: 'text-right' },
	        	{ data: 'subsequent', visible: false, orderable: true, className: 'text-right' },
	        	{ data: 'interval_bin_seq', visible: false, orderable: true, className: 'text-right' }
	    	],
	    	columnDefs: [
	    		{ targets: 2, render: $.fn.dataTable.render.number(',', '.', 0, '') },    		
	    		{ targets: 4, render: $.fn.dataTable.render.number(',', '.', 0, '') }
	    	]
		} );
		
		// table search logic that distinguishes sort/filter 
		${param.block}_datatable.on( 'search.dt', function () {
			var snapshot = ${param.block}_datatable
		     .rows({ search: 'applied', order: 'index'})
		     .data()
		     .toArray()
		     .toString();

		  	var currentSnapshot = ${param.block}_datatable.settings().init().snapshot;

		  	if (currentSnapshot != snapshot) {
		  		${param.block}_datatable.settings().init().snapshot = snapshot;
		  		${param.block}_refreshHistograms();
				${param.block}_constrain_table();
		   		$('#${param.block}_btn_clear').removeClass("no_clear");
		   		$('#${param.block}_btn_clear').addClass("show_clear");
		  	}
		} );
		
		
		
		${param.block}_refreshHistograms();
		${param.block}_interval_refresh();
	});
});
</script>
