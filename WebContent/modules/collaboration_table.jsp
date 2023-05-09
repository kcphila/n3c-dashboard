<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script>


	let draw2 = false;
	var table2 = null;
	
	$(document).ready( function () {
		$.getJSON("<util:applicationRoot/>/feeds/publications_by_site.jsp?ror=${param.ror}", function(data) {
			console.log(data);
	
			var json = $.parseJSON(JSON.stringify(data));
			var col = [];

			for (i in json['headers']){
				col.push(json['headers'][i]['label']);
			}

			var table = document.createElement("table");
			table.className = 'table table-hover compact site-wrapper';
			table.style.width = '100%';
			table.id = "site-table";
			var header= table.createTHead();
			var header_row = header.insertRow(0); 

			for (i in col) {
				var th = document.createElement("th");
				th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + col[i].toString() + '</span>';
				header_row.appendChild(th);
			}
			var divContainer = document.getElementById("site-roster");
			divContainer.appendChild(table);
			data = json['rows'];
			table2 = $('#site-table').DataTable({
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
						text: 'CSV',
						filename: 'N3C_sites_csv_export',
						extension: '.csv'
					}, {
						extend: 'copy',
						className: 'btn btn-sm btn-light',
						titleAttr: 'Copy table data.',
						text: 'Copy'
					}]
				},
				pageLength: 10,
				lengthMenu: [10, 25, 50, 75, 100],
				order: [[1, 'asc']],
				columns: [
					{ data: 'id', visible: false, orderable: true },
					{
						data: 'title', visible: true, orderable: true,
						render: function(data, type, row) {
							return '<a href="' + row.external_url + '"><span>' + row.title + '<\/span></a>';
						}
					},
					{
						data: 'authors', visible: true, orderable: true,
						render: function (data, type, row) {
							var names = [];
							$.each(data, function(index, value) {
								names.push( value.last_name + ",&nbsp;" + value.first_name );
							});
							return names.join('<br>');
						}
					},
					{ data: 'external_url', visible: false }
				]
			});
		});
	});
</script>
