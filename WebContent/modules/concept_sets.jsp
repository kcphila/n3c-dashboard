<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<script>
$.getJSON("<util:applicationRoot/>/feeds/concept_sets.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover table-expand';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="concept-set-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("concept-set-list");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#concept-set-table').DataTable( {
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
    	    	  columns: ':not(.noExport)'
              },
    	      text: 'CSV',
    	      filename: 'N3C_Concept_Set_csv_export',
    	      extension: '.csv'
    	    }, {
    	      extend: 'copy',
    	      className: 'btn btn-sm btn-light',
    	      exportOptions: {
    	    	  columns: ':not(.noExport)'
              },
    	      titleAttr: 'Copy table data.',
    	      text: 'Copy'
    	    }]
    	},
		language: {
            searchPlaceholder: "title, limitation, ..."
        },
		pageLength: 5,
		lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
		order: [[0, 'asc'],[1, 'asc']],
		columns: [
	      	  { data: 'type', visible: true },
        	  { data: 'title', visible: true },
	      	  { data: 'codeset_id', visible: true },
        	  { data: 'doi', visible: true,
        		  render: function ( data, type, row ) { return '<a href="'+row.doi+'">'+row.doi+'</a>';}
        	  },
        	  { data: 'created_by', visible: true},
        	  { data: 'creator', visible: true},
        	  { data: 'limitations', visible: true}
    	]
	} );
});
	
	
</script>

