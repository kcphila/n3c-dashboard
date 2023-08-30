<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/dom-to-image/2.6.0/dom-to-image.min.js"></script>





<style>

.table-hover tbody tr:hover {
    background-color: #edf6ff;
}

.table-no-borders td{
	border: none;
}

.bar-chart-bar {
    display: block; 
    position:relative; 
    width: 100%; 
    height: 20px; 
}
.bar {
    float: left; 
    height: 100%; 
}

.barehr {
    background-color: #a6a6a6;
    border-radius: 5px 0px 0px 5px;
}
.barmortality{
    background-color: #007bff;
    border-radius: 0px 5px 5px 0px;
}

.ehrtext, 
.ehrtext span{
    color: #8B8B8B !important;
}
.mortalitytext, 
.mortalitytext span{
    color: #007bff !important;
}
.smalltext{
    font-size: 12px;
}

</style>

<script>


var ${param.block}_datatable = null;


$.getJSON("<util:applicationRoot/>/new_ph/summary_blocks/pprl_summary_block_vizs/mortality_table_feed.jsp", function(data, error){
	
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover compact site-wrapper table-no-borders';
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
	

	var ${param.block}_datatable = $('#${param.target_div}-table').DataTable( {
	    data: data,
    	dom: 'lr<"datatable_overflow"t>Bip',
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
                  columns: '.export'
              },
    	      text: 'CSV',
    	      filename: 'Mortality_Enhancement',
    	      extension: '.csv'
    	    }, {
    	      extend: 'copy',
    	      className: 'btn btn-sm btn-light',
    	      exportOptions: {
                  columns: '.export'
              },
    	      titleAttr: 'Copy table data.',
    	      text: 'Copy'
    	    }, {
    	      text: 'PNG',
    	      className: 'btn btn-sm btn-light',
              action: function ( ) {
            	  domtoimage.toBlob(document.getElementById('${param.target_div}-table'))
            	    .then(function (blob) {
            	        window.saveAs(blob, 'Mortality_Enhancement.png');
            	    });
              }
    	    }, {
    	      text: 'JPG',
    	      className: 'btn btn-sm btn-light',
              action: function ( ) {
            	  domtoimage.toJpeg(document.getElementById('${param.target_div}-table'), { quality: 1, bgcolor: 'white' })
            	    .then(function (dataUrl) {
            	        var link = document.createElement('a');
            	        link.download = 'Mortality_Enhancement.jpg';
            	        link.href = dataUrl;
            	        link.click();
            	    });
             }
        	}]
    	},
       	paging: false,
    	order: false,
    	bInfo : false,
     	columns: [
     		{ data: 'variable_type', visible: true, orderable: false, width: '80px',className: 'export' },
     		{ data: 'ehr_death_table', visible: true, orderable: false, width: '100px', className: 'ehrtext export', render : DataTable.render.number( null, null, 0, '' )},
     		{ data: 'pprl_3_source_mortality_and_death', visible: false, orderable: false, className: 'export', render : DataTable.render.number( null, null, 0, '' )  },
        	{ data: 'common_cnt', visible: false, orderable: false,className: 'export', render : DataTable.render.number( null, null, 0, '' )  },
     		{ data: 'additional_in_pprl', visible: true, orderable: false, className: 'mortalitytext', width: '300px', 
     			render: function(data, type, row, meta){
	 				var large_div = $("<div></div>");
	 				var text_div = $("<div></div>", {"class": "viz_text"});
	
	 				text_div.append(function(){
	                    return $("<div><strong>" +  row['additional_in_pprl'].toLocaleString() + "</strong><span class='smalltext'> : (Mortality Total: "
	                    + row['pprl_3_source_mortality_and_death'].toLocaleString() + " - Duplicates: "+ row['common_cnt'].toLocaleString()  +")</span></div>");
					});
	 				large_div.append(text_div);
					return large_div.prop("outerHTML");
     			}
    		},
    		{ data: 'additional_in_pprl_download', visible: false, orderable: false, className: 'export', render : DataTable.render.number( null, null, 0, '' )},
     		{ data: 'viz_total', visible: true, orderable: false,
     			render: function(data, type, row, meta){
     				var large_div = $("<div></div>", {"class": "test"});
     				var viz_div = $("<div></div>", {"class": "bar-chart-bar count"});
     				viz_div.append(function(){
						var bars = [];
						for (const [key, value] of Object.entries(row)) {
							if (key == 'ehr_death_table'){
								var width = (value/data)*100
								bars.push($("<div></div>",{"class": "bar " + "barehr" }).css({ "width": width + "%"}))
							}
							if (key == 'additional_in_pprl'){
								var width = (value/data)*100
								bars.push($("<div></div>",{"class": "bar " + "barmortality" }).css({ "width": width + "%"}))
							}                            
                        }
                        return bars;
					});
     				
     				large_div.append(viz_div);
					return large_div.prop("outerHTML");
        		}
        	},
        	{ data: 'total', visible: true, orderable: false, width: '80px',className: 'export', render : DataTable.render.number( null, null, 0, '' ) },
        	{ data: 'percentage_increase', visible: true, orderable: false, width: '80px',className: 'export'   }
    	]
	} );
});

</script>
