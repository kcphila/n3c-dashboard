<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div id="analysis1-km"></div>
<script>
$.getJSON("../../phastr/pasc-mortality/feeds/analysis1_km.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="analysis1-km-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("analysis1-km");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#analysis1-km-table').DataTable( {
    	data: data,
       	paging: true,
       	dom: 'lfr<"datatable_overflow"t>Bip',
    	pageLength: 5,
    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'timeline', visible: true, orderable: true, className: "text-right" },
        	{ data: 'x__group', visible: true, orderable: true },
        	{ data: 'survival', visible: true, orderable: true, className: "text-right" },
        	{ data: 'survival_upper_0_95', visible: true, orderable: true, className: "text-right" },
        	{ data: 'survival_lower_0_95', visible: true, orderable: true, className: "text-right" }
    	]
	} );

	
});
</script>
