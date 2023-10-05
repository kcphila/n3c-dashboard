<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<script>
var ${param.block}_datatable = null;

let draw2 = false;
var table2 = null;

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

	table2 = $('#${param.target_div}-table').DataTable( {
		searchDelay: 350,
		data: data,
       	paging: true,
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
    	      filename: 'environmental_vs_all_patients',
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
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'code', visible: false, orderable: true },
        	{ data: 'statename', visible: true, orderable: true },
        	{ data: 'countyname', visible: true, orderable: true },
        	{ data: 'param_list', visible: false, orderable: true },
        	{ data: 'non_count', visible: true, orderable: true },
        	{ data: 'covid_count', visible: true, orderable: true },
        	{ data: 'patient_count_died', visible: true, orderable: true },
        	{ data: 'patient_count_died_cause_covid', visible: true, orderable: true }
    	]
	} );

	const tableData = getTableData(table2);
	setTableEvents(table2);
	
});

function getTableData(table) {
	var tableData = {};
	const dataArray = [];

	table.rows({ search: "applied" }).every(function() {
		const data = this.data();
		dataArray.push(data);
	});

	tableData["sites"] = dataArray;
	return tableData;
}
</script>
