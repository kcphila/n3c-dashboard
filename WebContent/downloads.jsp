<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
    <link href="https://unpkg.com/tabulator-tables@5.1.2/dist/css/tabulator.min.css" rel="stylesheet">
    <script type="text/javascript" src="https://unpkg.com/tabulator-tables@5.1.2/dist/js/tabulator.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.26.0/axios.min.js" integrity="sha512-bPh3uwgU5qEMipS/VOmRqynnMXGGSRv+72H/N260MQeXZIK4PG48401Bsby9Nq5P5fz7hy5UGNmC/W1Z51h2GQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.jsdelivr.net/npm/d3@7"></script>


<jsp:include page="head.jsp" flush="true" />

<body>
	<jsp:include page="navbar.jsp" flush="true">
  		<jsp:param name="page" value="downloads"/>
	</jsp:include>

	<div class="container content container-large">
		
		<div class="row">
			<div class="col-12 col-lg-12">
				<div class="header-text">
					<h3>N3C Dashboard Data Downloads</h3>
				</div>
				<p>The data used to populate the various visualizations, etc. in the N3C Dashboard are available below for download as JSON and CSV.</p>
			</div>
		</div>
		<div class="row">
			<div class="col-12 col-lg-12">
				<div id="download-div"></div>
			</div>
		</div>
	</div>

	
	<jsp:include page="footer.jsp" flush="true" />
<script>

var downloads_datatable = null;

$.getJSON("<util:applicationRoot/>/feeds/downloads.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover compact';
	table.style.width = '100%';
	table.id="download-div-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("download-div");
	divContainer.appendChild(table);

	var data = json['rows'];

	downloads_datatable = $('#download-div-table').DataTable( {
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
    	      filename: 'enclave_export_list',
    	      extension: '.csv'
    	    }, {
    	      extend: 'copy',
    	      className: 'btn btn-sm btn-light',
    	      titleAttr: 'Copy table data.',
    	      exportOptions: {
                  columns: ':visible'
              },
    	      text: 'Copy'
    	    }]
    	},
       	paging: true,
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc'],[1, 'asc']],
     	columns: [
        	{ data: 'category', visible: true, orderable: true },
        	{ data: 'file', visible: true, orderable: true },
        	{ data: 'updated', visible: true, orderable: true, className: "text-nowrap"},
            { data: 'row_count', visible: true, orderable: true, className: "text-right", render: $.fn.dataTable.render.number(',', '.', 0, '')},
         	{ data: 'attributes', visible: true, orderable: true},
         	{ data: 'json', visible: true, orderable: false},
         	{ data: 'csv', visible: true, orderable: false}
    	]
	} );

});

</script>

</body>
</html>

