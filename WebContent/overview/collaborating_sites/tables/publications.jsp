<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<script>
var ${param.block}_datatable = null;

var ${param.block}_table = null;

$.getJSON("<util:applicationRoot/>/overview/collaborating_sites/feeds/${param.feed}", function(data){
		
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

	${param.block}_table = $('#${param.target_div}-table').DataTable( {
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
        	{ data: 'title',
        	  visible: true,
        	  orderable: true,
     		  render: function ( data, type, row ) {
				var buffer = '<a href="' + row.external_url + '">' +  row.title + '</a>';
				if (row.journal != null) {
					buffer = buffer + "<br>" + row.journal;
					if (row.pub_date != null)
						buffer = buffer + ", " + row.pub_date;
				}
				if (row.doi != null) {
					if (row.journal == null)
						buffer = buffer + "<br>doi: <a href='https://doi.org/" + row.doi + "'>" + row.doi +"</a>";
					else
						buffer = buffer + ", doi: <a href='https://doi.org/" + row.doi + "'>" + row.doi +"</a>";
				}
				return buffer;
           	  }
        	 },
        	{ data: 'external_url', visible: false, orderable: true },
        	{ data: 'id', visible: false, orderable: true },
        	{ data: 'doi', visible: false, orderable: true },
        	{ data: 'journal', visible: false, orderable: true },
        	{ data: 'pub_date', visible: false, orderable: true },
        	{ data: 'authors', visible: true, orderable: true }
    	]
	} );
});
</script>
