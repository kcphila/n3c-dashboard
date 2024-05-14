<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div id="combined-roc"></div>
<script>
$.getJSON("../../phastr/pasc-mortality/feeds/combined_roc.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="combined-roc-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("combined-roc");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#combined-roc-table').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 5,
    	dom: 'lfr<"datatable_overflow"t>Bip',
    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'false_positive_rate', visible: true, orderable: true, className: "text-right" },
        	{ data: 'true_positive_rate', visible: true, orderable: true, className: "text-right" },
        	{ data: 'lowerlimit_trueposrate', visible: true, orderable: true, className: "text-right" },
        	{ data: 'upperlimit_trueposrate', visible: true, orderable: true, className: "text-right" },
        	{ data: 'auc', visible: true, orderable: true, className: "text-right" },
        	{ data: 'auc_halfwidth', visible: true, orderable: true, className: "text-right" },
        	{ data: 'cohort', visible: true, orderable: true }
    	]
	} );

	
});
</script>
