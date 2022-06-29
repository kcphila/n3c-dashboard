<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<script>

$.getJSON("<util:applicationRoot/>/new_ph/medication_snapshot/feeds/greater_condition.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover compact site-wrapper';
	table.style.width = '100%';
	table.id="condition_table_2-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("condition_table_2");
	divContainer.appendChild(table);

	var data = json['rows'];

	${param.block}_datatable = $('#condition_table_2-table').DataTable( {
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
    	      filename: 'severity_csv_export',
    	      extension: '.csv'
    	    }, {
    	      extend: 'copy',
    	      className: 'btn btn-sm btn-light',
    	      titleAttr: 'Copy table data.',
    	      text: 'Copy'
    	    }]
    	},
       	paging: true,
        drawCallback: function () {
            $("#condition_table_2-table tbody td").not(":nth-child(1),:nth-child(2),:nth-child(3),:nth-child(4)").colorize();
          },
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[4, 'desc']],
     	columns: [
        	{ data: 'condition', visible: true, orderable: true },
        	{ data: 'KnownPositive', visible: true, orderable: true },
        	{ data: 'UnknownCovidTestStatus', visible: true, orderable: true },
        	{ data: 'KnownNegative', visible: true, orderable: true },
        	{ data: 'total', visible: true, orderable: true, }
    	]
	} );


	
});

</script>