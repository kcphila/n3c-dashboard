<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>

</style>
<div id="cumulative_1_cumulative_table" class="dash_viz" style="margin-top:20px;"></div>
<div id="cumulative_1_cumulative_table_hidden" class="dash_viz" style="margin-top:20px; display:none;"></div>

<script>
function ${param.block}_constrain_table(filter, constraint) {
	var table = $('#cumulative_1_cumulative_table-table').DataTable();
	
	switch (filter) {
	case 'gender':
		table.column(0).search(constraint, true, false, true).draw();	
		break;
	case 'race':
		table.column(4).search(constraint, true, false, true).draw();	
		break;
	}
	
	var kpis = '${param.target_kpis}'.split(',');
	for (var a in kpis) {
		${param.block}_updateKPI(table, kpis[a])
	}
}

function ${param.block}_updateKPI(table, column) {
	
	// console.log(column);
	
	var sum_string = '';
	var sum = table.rows({search:'applied'}).data().pluck(column).sum();
	
	if (sum < 1000) {
		sumString = sum+'';
	} else if (sum < 1000000) {
		sum = sum / 1000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "k";
	} else {
		sum = sum / 1000000.0;
		sumString = sum.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + "M";
		
	}
	
	document.getElementById('${param.block}'+'_'+column+'_kpi').innerHTML = sumString;
}

jQuery.fn.dataTable.Api.register( 'sum()', function ( ) {
	return this.flatten().reduce( function ( a, b ) {
		if ( typeof a === 'string' ) {
			a = a.replace(/[^\d.-]/g, '') * 1;
		}
		if ( typeof b === 'string' ) {
			b = b.replace(/[^\d.-]/g, '') * 1;
		}

		return a + b;
	}, 0 );
} );

var ${param.block}_datatable = null;
var ${param.block}_datatable2 = null;

$.getJSON("<util:applicationRoot/>/new_ph/cumulative/feeds/cumulative_summary2.jsp", function(data){
	
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];
	var table = document.createElement("table");
	table.className = 'table table-hover compact site-wrapper';
	table.style.width = '100%';
	table.setAttribute("data-cols-width", "45,14,14,14,14,14,14,14,14,14,14,14,14,15");
	table.id="cumulative_1_cumulative_table_hidden-table";

	var header= table.createTHead();
	var footer= table.createTFoot();

    var header_row1 = header.insertRow(); 
	var header_row2 = header.insertRow(); 
	var header_row3 = header.insertRow(); 
	
	var th1 = document.createElement("th");
	th1.setAttribute("rowspan", "3");
	th1.setAttribute("colspan", "1");
	// set table export style attributes
	th1.setAttribute("data-a-h", "center");
	th1.setAttribute("data-f-bold", "true");
	th1.setAttribute("data-f-sz", "16");
	th1.setAttribute("data-fill-color", "e3efff");
	th1.setAttribute('data-b-a-s', 'medium'); 
	th1.setAttribute('data-b-a-c', 'ffffff'); 
	th1.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">Racial Categories</span>';
	header_row1.appendChild(th1);
	
	var th2 = document.createElement("th");
	th2.setAttribute("colspan", "12");
	th2.setAttribute("rowspan", "1");
	// set table export style attributes
	th2.setAttribute("data-a-h", "center");
	th2.setAttribute("data-f-bold", "true");
	th2.setAttribute("data-f-sz", "16");
	th2.setAttribute("data-fill-color", "e3efff");
	th2.setAttribute('data-b-a-s', 'medium'); 
	th2.setAttribute('data-b-a-c', 'ffffff'); 
	th2.style.textAlign = 'Center';
	th2.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">Ethnic/Gender Categories</span>';
	header_row1.appendChild(th2);
	
	var th3 = document.createElement("th");
	th3.setAttribute("rowspan", "3");
	th3.setAttribute("colspan", "1");
	// set table export style attributes
	th3.setAttribute("data-a-h", "center");
	th3.setAttribute("data-f-bold", "true");
	th3.setAttribute("data-f-sz", "16");
	th3.setAttribute("data-fill-color", "e6e9eb");
	th3.setAttribute('data-b-a-s', 'medium'); 
	th3.setAttribute('data-b-a-c', 'ffffff'); 
	th3.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">Total</span>';
	header_row1.appendChild(th3);

	var ethnicity_vals = ['Non-Hispanic or Latino', 'Hispanic or Latino', 'Unknown or Not Reported Ethnicity'];
	var gender_vals = ['Female', 'Male', 'Other', 'Unknown'];

	for (i in ethnicity_vals) {
		var th = document.createElement("th");
		th.setAttribute("colspan", "4");
		th.setAttribute("rowspan", "1");
		// set table export style attributes
		th.setAttribute("data-a-h", "center");
		th.setAttribute("data-fill-color", "e3efff");
		th.setAttribute("data-f-sz", "14");
		th.setAttribute('data-b-a-s', 'medium'); 
		th.setAttribute('data-b-a-c', 'ffffff'); 
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + ethnicity_vals[i] + '</span>';
		header_row2.appendChild(th);
		for (i in gender_vals){
			var th = document.createElement("th");
			th.setAttribute("colspan", "1");
			th.setAttribute("rowspan", "1");
			// set table export style attributes
			th.setAttribute("data-a-h", "center");
			th.setAttribute("data-fill-color", "e3efff");
			th.setAttribute("data-f-sz", "14");
			th.setAttribute('data-b-a-s', 'medium'); 
			th.setAttribute('data-b-a-c', 'ffffff'); 
			th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + gender_vals[i] + '</span>';
			header_row3.appendChild(th);
		}
	};

	var divContainer = document.getElementById("cumulative_1_cumulative_table_hidden");
	divContainer.appendChild(table);

	var data = json['rows'];

	${param.block}_datatable2 = $('#cumulative_1_cumulative_table_hidden-table').DataTable( {
		data: data,
    	dom: 'lr<"datatable_overflow"t>ip',
       	paging: false,
    	order: [[0, 'asc']],
    	columnDefs: [
    	     {
    	        'targets': [1,2,3,4, 5, 6, 7, 8, 9, 10, 11, 12],
    	        'createdCell':  function (td) {
    	           $(td).attr('data-t', 'n'); 
    	           $(td).attr('data-f-sz', '11'); 
    	           $(td).attr('data-b-a-s', 'medium'); 
    	           $(td).attr('data-b-a-c', 'ffffff'); 
    	           $(td).attr('data-fill-color', 'f0f2f2');
    	        }, 
    	        'className': 'sum'
    	     },{
    	    	 'targets': [13],
    	    	 'createdCell':  function (td) {
      	         	$(td).attr('data-t', 'n'); 
      	         	$(td).attr('data-f-sz', '13'); 
      	         	$(td).attr('data-b-a-s', 'medium'); 
     	           	$(td).attr('data-b-a-c', 'ffffff'); 
      	         	$(td).attr('data-f-bold', 'true'); 
      	         	$(td).attr('data-fill-color', 'e6e9eb');
      	        }, 
    	        'className': 'sum'
    	     },
    	     {
    	    	 'targets': [0],
    	    	 'createdCell':  function (td) {
      	         	$(td).attr('data-f-sz', '14'); 
      	         	$(td).attr('data-b-a-s', 'medium'); 
     	           	$(td).attr('data-b-a-c', 'ffffff'); 
      	         	$(td).attr('data-fill-color', 'e3efff');
      	        }
    	     }
    	],
     	columns: [
        	{ data: 'race', visible: true, orderable: false },
        	{ data: 'count_non_hispanic_female', visible: true, orderable: false },
        	{ data: 'count_non_hispanic_male', visible: true, orderable: false },
        	{ data: 'count_non_hispanic_other', visible: true, orderable: false },
        	{ data: 'count_non_hispanic_unknown', visible: true, orderable: false },
        	{ data: 'count_hispanic_female', visible: true, orderable: false },
        	{ data: 'count_hispanic_male', visible: true, orderable: false },
        	{ data: 'count_hispanic_other', visible: true, orderable: false },
        	{ data: 'count_hispanic_unknown', visible: true, orderable: false },
        	{ data: 'count_ethnicity_unknown_female', visible: true, orderable: false },
        	{ data: 'count_ethnicity_unknown_male', visible: true, orderable: false},
        	{ data: 'count_ethnicity_unknown_other', visible: true, orderable: false},
        	{ data: 'count_ethnicity_unknown_unknown', visible: true, orderable: false},
        	{ data: 'total', visible: true, orderable: false }
    	],
    	drawCallback: function ( settings ) {    	
			var table = $('#cumulative_1_cumulative_table_hidden-table').DataTable();
			var rows = table.rows().nodes();
			var table_length = table.data().count();
			var values =[0,0,0,0,0,0,0,0,0,0,0,0,0]

			table.columns( '.sum' ).every( function (i) {
				var sum = this
					.data()
					.reduce( function (a,b) {
					return a + b;
					});
				values[i-1] = sum;
			});
			
			$(rows).eq(table_length-1).after(
					'<tr class="group" style="background: lightgray; font-weight: bold">' + 
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="16">'+'Total'+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[0]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[1]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[2]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[3]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[4]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[5]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[6]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[7]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[8]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[9]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[10]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[11]+'</td>'+
					'<td data-b-a-s="medium" data-b-a-c="ffffff" data-fill-color="e6e9eb" data-f-bold="true" data-f-sz="13" data-t="n">'+values[12]+'</td></tr>'
			);   
        }
	} );
	


	
});

$.getJSON("<util:applicationRoot/>/new_ph/cumulative/feeds/cumulative_summary.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}

	var table = document.createElement("table");
	table.className = 'table table-hover compact site-wrapper';
	table.style.width = '100%';
	table.setAttribute("data-cols-width", "45,32,32,32,10");
	table.id="cumulative_1_cumulative_table-table";

	var header= table.createTHead();

    var header_row1 = header.insertRow(); 
	var header_row2 = header.insertRow(); 
	
	var th1 = document.createElement("th");
	th1.setAttribute("rowspan", "2");
	th1.setAttribute("colspan", "1");
	// set table export style attributes
	th1.setAttribute("data-a-h", "center");
	th1.setAttribute("data-f-bold", "true");
	th1.setAttribute("data-f-sz", "16");
	th1.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">Racial Categories & Gender</span>';
	header_row1.appendChild(th1);
	var th2 = document.createElement("th");
	th2.setAttribute("colspan", "4");
	th2.setAttribute("rowspan", "1");
	// set table export style attributes
	th2.setAttribute("data-a-h", "center");
	th2.setAttribute("data-f-bold", "true");
	th2.setAttribute("data-f-sz", "16");
	th2.style.textAlign = 'Center';
	th2.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">Ethnic Categories</span>';
	header_row1.appendChild(th2);
	var th3 = document.createElement("th");
	th3.setAttribute("rowspan", "2");
	th3.setAttribute("colspan", "1");
	// set table export style attributes
	th3.setAttribute("data-a-h", "center");
	th3.setAttribute("data-f-bold", "true");
	th3.setAttribute("data-f-sz", "16");
	th3.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">Total</span>';
	header_row1.appendChild(th3);

	var other_vals = ['Non-Hispanic or Latino', 'Hispanic or Latino', 'Unknown or Not Reported', 'Race']

	for (i in other_vals) {
		var th = document.createElement("th");
		th.setAttribute("colspan", "1");
		th.setAttribute("rowspan", "1");
		// set table export style attributes
		th.setAttribute("data-a-h", "center");
		th.setAttribute("data-f-bold", "true");
		th.setAttribute("data-f-sz", "16");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:14px;">' + other_vals[i] + '</span>';
		header_row2.appendChild(th);
	}

	var divContainer = document.getElementById("cumulative_1_cumulative_table");
	divContainer.appendChild(table);

	var data = json['rows'];

	${param.block}_datatable = $('#cumulative_1_cumulative_table-table').DataTable( {
		data: data,
    	dom: '<"mb-2 d-flex"B>lr<"datatable_overflow"t>ip',
    	buttons: {
    	    dom: {
    	      button: {
    	        tag: 'button',
    	        className: ''
    	      }
    	    },
    	    buttons: [{
    	      className: 'btn btn-dash',
    	      titleAttr: 'Excel export.',
    	      text: '<i class="fas fa-download"></i> Download Full Data (Excel)',
			  action: function ( e, dt, node, config ) {
				  let table = $("#cumulative_1_cumulative_table_hidden-table");
			        TableToExcel.convert(table[0], {
			           name: 'N3C_Enclave_Demographics_Full.xlsx' 
			        });
              }
    	    },{
    	      className: 'btn btn-sm btn-light',
    	      titleAttr: 'Excel export.',
    	      text: 'Data in View (Excel)',
			  action: function ( e, dt, node, config ) {
				  let table = $("#cumulative_1_cumulative_table-table");
			        TableToExcel.convert(table[0], {
			           name: 'N3C_Enclave_Demographics.xlsx' 
			        });
              }
    	    },
    	    {
  	      		extend: 'csv',
  	      		exportOptions: {
	  	          	format: {
	  	            	header: function(content, index) {
	  	            		if(index === 0){
	  	            			return "Gender"
	  	            		} else if (index === 1 || index === 2 || index === 3){
	  	            			return "Eth: " + content.replace(/(<([^>]+)>)/gi, "");
	  	            		} else {
	  	            			return content.replace(/(<([^>]+)>)/gi, "");
	  	            		};
	  	           		}
	  	          	}
  	      		},
	      		className: 'btn btn-sm btn-light',
	     		titleAttr: 'CSV export.',
	      		text: 'Data in View (CSV)',
	      		filename: 'N3C_Enclave_Demographics',
	      		extension: '.csv'
	    
      	    }]
    	},
       	paging: false,
    	order: [[4, 'asc']],
    	columnDefs: [
    	     {
    	        'targets': [1,2,3,5],
    	        'createdCell':  function (td, cellData, rowData, row, col) {
    	           $(td).attr('data-t', 'n'); 
    	        }
    	     }
    	],
     	columns: [
        	{ data: 'gender', visible: true, orderable: false },
        	{ data: 'count_non_hispanic', visible: true, orderable: false },
        	{ data: 'count_hispanic', visible: true, orderable: false },
        	{ data: 'count_ethnicity_unknown', visible: true, orderable: false},
        	{ data: 'race', visible: false},
        	{ data: 'total', visible: true, orderable: false }
    	],
    	drawCallback: function ( settings ) {    	
			var table = $('#cumulative_1_cumulative_table-table').DataTable();
			var rows = table.rows({ search: 'applied' }).nodes();
			var last= null;
			var subTotal = new Array();
			var groupID = -1;
			var aData = new Array();
			var index = 0;

			table.rows({ search: 'applied' }).data().each( function ( values, i ) {
				var group = values['race'];
				var vals = table.row(table.row($(rows).eq(i)).index()).data();
				var total = vals.total;
				var non_total = vals.count_non_hispanic;
				var hisp_total = vals.count_hispanic;
				var unk_total = vals.count_ethnicity_unknown;
				
				if (typeof aData[group] == 'undefined') {
					aData[group] = new Array();
					aData[group].rows = [];
					aData[group].total = [];
					aData[group].non_total = [];
					aData[group].hisp_total = [];
					aData[group].unk_total = [];
				}
				
				aData[group].rows.push(i); 
				aData[group].total.push(total); 
				aData[group].non_total.push(non_total); 
				aData[group].hisp_total.push(hisp_total); 
				aData[group].unk_total.push(unk_total); 
			});

			var idx= 0;

			for(var race in aData){
            	idx =  Math.min.apply(Math,aData[race].rows);
            	
				var sum = 0; 
				var non_sum = 0; 
				var hisp_sum = 0; 
				var unk_sum = 0; 
				
				$.each(aData[race].total,function(k,v){
					sum = sum + v;
				});
				$.each(aData[race].non_total,function(k,v){
					non_sum = non_sum + v;
				});
				$.each(aData[race].hisp_total,function(k,v){
					hisp_sum = hisp_sum + v;
				});
				$.each(aData[race].unk_total,function(k,v){
					unk_sum = unk_sum + v;
				});
				
				$(rows).eq(idx).before(
					'<tr class="table_group" style="background: #D2E5FA; font-weight: bold;">' + 
					'<td data-fill-color="D2E5FA" data-f-bold="true" data-f-sz="13">'+race+'</td>'+
					'<td data-fill-color="D2E5FA" data-f-bold="true" data-f-sz="13" data-t="n">'+non_sum+'</td>'+
					'<td data-fill-color="D2E5FA" data-f-bold="true" data-f-sz="13" data-t="n">'+hisp_sum+'</td>'+
					'<td data-fill-color="D2E5FA" data-f-bold="true" data-f-sz="13" data-t="n">'+unk_sum+'</td>'+
					'<td data-fill-color="D2E5FA" data-f-bold="true" data-f-sz="13" data-t="n">'+sum+'</td></tr>'
				);    
            };
        }
	} );
});



</script>
