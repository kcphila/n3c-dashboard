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
        	{ data: 'statename', visible: true, orderable: true },
        	{ data: 'countyname', visible: true, orderable: true },
        	{ data: 'cityname', visible: true, orderable: true },
        	{ data: 'postal_code', visible: true, orderable: true },
        	{ data: 'non_count_display', visible: true, orderable: true, orderData: [5], className: 'dt-body-right' },
        	{ data: 'non_count', visible: false, orderable: true },
        	{ data: 'covid_count_display', visible: true, orderable: true, orderData: [7], className: 'dt-body-right' },
        	{ data: 'covid_count', visible: false, orderable: true },
        	{ data: 'patient_count_died_display', visible: true, orderable: true, orderData: [9], className: 'dt-body-right' },
        	{ data: 'patient_count_died', visible: false, orderable: true },
        	{ data: 'patient_count_died_cause_covid_display', visible: true, orderable: true, orderData: [11], className: 'dt-body-right' },
        	{ data: 'patient_count_died_cause_covid', visible: false, orderable: true },
        	{ data: 'latitude', visible: false},
        	{ data: 'longitude', visible: false},
        	{ data: 'param_list', visible: false}
    	]
	} );

	const tableData = getTableData(table2);
	createD3Chart(tableData);
	setTableEvents(table2);
	
});

</script>
