<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<script>

function ${param.block}_constrain_table(filter, constraint) {
	console.log("timeline constraint", filter, constraint);
	var table = $('#${param.target_div}-table').DataTable();
	
	switch (filter) {
	case 'subsequent_infection':
		table.column(1).search(constraint, true, false, true).draw();	
		break;
	}
	
	${param.block}_refreshHistograms();
	${param.block}_age_refresh();
}

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
	
		$('#${param.target_div}-table').DataTable( {
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
	    	      text: 'CSV',
	    	      filename: 'symptom_before_after_covid_csv_export',
	    	      extension: '.csv'
	    	    }, {
	    	      extend: 'copy',
	    	      className: 'btn btn-sm btn-light',
	    	      titleAttr: 'Copy table data.',
	    	      text: 'Copy'
	    	    }]
	    	},
	       	paging: true,
	    	pageLength: 10,
	    	lengthMenu: [ 10, 25, 50, 75, 100 ],
	    	order: [[0, 'asc']],
	     	columns: [
	        	{ data: 'severity', visible: true, orderable: true, className: 'text-center', orderData: [5] },
	        	{ data: 'severity_seq', visible: false, orderable: true, className: 'text-right' },
	        	{ data: 'state', visible: true, orderable: true, className: 'text-center' },
	        	{ data: 'region_id', visible: false, orderable: true, className: 'text-right' },
	        	{ data: 'region_name', visible: true, orderable: true, className: 'text-right' },
	        	{ data: 'division_id', visible: false, orderable: true, className: 'text-right' },
	        	{ data: 'division_name', visible: true, orderable: true, className: 'text-right' },
	        	{ data: 'state_count', visible: true, orderable: true, className: 'text-right' },
	        	{ data: 'region_count', visible: true, orderable: true, className: 'text-right' },
	        	{ data: 'division_count', visible: true, orderable: true, className: 'text-right' }
	    	]
		} );
		
	});
	

	// this is necessary to populate the histograms for the panel's initial D3 rendering
	${param.block}_refreshHistograms();
});
</script>