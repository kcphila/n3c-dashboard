<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div id="survival-inpatient-weighted"></div>
<script>
$.getJSON("../../phastr/ucda/feeds/survival_inpatient_weighted.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="survival-inpatient-weighted-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("survival-inpatient-weighted");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#survival-inpatient-weighted-table').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 5,
    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'timeline', visible: true, orderable: true },
        	{ data: 'survival_proportion', visible: true, orderable: true },
        	{ data: 'ul', visible: true, orderable: true },
        	{ data: 'll', visible: true, orderable: true },
        	{ data: 'x__group', visible: true, orderable: true }
    	]
	} );

	
});
</script>
