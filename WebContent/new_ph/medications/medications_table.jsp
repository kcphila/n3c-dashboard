<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<script>

function ${param.block}_constrain_table(filter, constraint) {
	var table = $('#${param.target_div}-table').DataTable();
	
	console.log("${param.block}", filter, constraint)
	switch (filter) {
	case 'drug_domain':
	    $("#${param.datatable_div}-table").DataTable().column(0).search(constraint, true, false, true).draw();	
		break;
	case 'concept_set_name':
	    $("#${param.datatable_div}-table").DataTable().column(1).search(constraint, true, false, true).draw();	
		break;
	case 'age':
	    $("#${param.datatable_div}-table").DataTable().column(2).search(constraint, true, false, true).draw();	
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
	if (column == 'patient_count'){
		sum = table.rows({search:'applied'}).data().pluck(column).sum();
	};
	if (column === 'medication_count'){
		var sum = table.column(1, { search:'applied' }).data().unique().length;
	};
	if (column === 'medication_class_count'){
		var sum = table.column(0,  { search:'applied' }).data().unique().length;
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

var ${param.block}_datatable = null;

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

	${param.block}_datatable = $('#${param.target_div}-table').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'drug_domain', visible: true, orderable: true },
        	{ data: 'concept_set_name', visible: true, orderable: true },
        	{ data: 'age', visible: true, orderable: true },
        	{ data: 'patient_display', visible: true, orderable: true, orderData: [4] },
        	{ data: 'patient_count', visible: false },
        	{ data: 'total_count', visible: true, orderable: true },
        	{ data: 'age_abbrev', visible: false },
        	{ data: 'age_seq', visible: false }
    	]
	} );

	${param.block}_datatable.on( 'search.dt', function () {
		console.log('${param.target_div}-table search', ${param.block}_datatable.search());
		${param.block}_refreshHistograms();
		$('#${param.block}_btn_clear').removeClass("no_clear");
		$('#${param.block}_btn_clear').addClass("show_clear");
	} );

	// this is necessary to populate the histograms for the panel's initial D3 rendering
	${param.block}_refreshHistograms();
	${param.block}_medication_refresh();

	
});

</script>
