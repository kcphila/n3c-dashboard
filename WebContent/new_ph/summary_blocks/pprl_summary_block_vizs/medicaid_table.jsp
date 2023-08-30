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
    background-color: #d3d4d5;
    border-radius: 5px 0px 0px 5px;
}
.barcms{
    background-color: #AD1181;
    border-radius: 0px 5px 5px 0px;
}

.ehrtext, 
.ehrtext span{
    color: #8B8B8B !important;
}
.ehrtext i{
	color: #d3d4d5;
}
.cmstext, 
.cmstext span{
    color: #AD1181 !important;
}
.smalltext{
    font-size: 12px;
}

/* Tooltip text */
.cmstool .tooltiptext {
  visibility: hidden;
  width: 120px;
  background-color: rgba(255, 255, 255, 0.55);
  color: black;
  text-align: center;
  border-radius: 6px;
 
  /* Position the tooltip text - see examples below! */
  position: absolute;
  z-index: 1;
}

/* Show the tooltip text when you mouse over the tooltip container */
.cmstool:hover .tooltiptext {
  visibility: visible;
}

</style>

<script>


var ${param.block}_datatable = null;


$.getJSON("<util:applicationRoot/>/new_ph/summary_blocks/pprl_summary_block_vizs/medicaid_table_feed.jsp", function(data, error){
	
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
                  columns: '.export'
              },
    	      text: 'CSV',
    	      filename: 'Medicaid_Enhancement',
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
            	        window.saveAs(blob, 'Medicaid_Enhancement.png');
            	    });
              }
    	    }, {
    	      text: 'JPG',
    	      className: 'btn btn-sm btn-light',
              action: function ( ) {
            	  domtoimage.toJpeg(document.getElementById('${param.target_div}-table'), { quality: 1, bgcolor: 'white' })
            	    .then(function (dataUrl) {
            	        var link = document.createElement('a');
            	        link.download = 'Medicaid_Enhancement.jpg';
            	        link.href = dataUrl;
            	        link.click();
            	    });
             }
        	}]
    	},
       	paging: false,
    	order: [[9, 'desc']],
     	columns: [
     		{ data: 'variable_type', visible: true, orderable: true, width: '130px',className: 'export' },
     		{ data: 'avg_in_ehr', visible: true, orderable: true, width: '80px', className: 'ehrtext export'},
     		{ data: 'avg_cms', visible: false, orderable: true, className: 'export'  },
        	{ data: 'common_cnt', visible: false, orderable: true,className: 'export'  },
     		{ data: 'additional_in_cms', visible: true, orderable: true, orderData: [5], className: 'cmstext', width: '240px', 
     			render: function(data, type, row, meta){
	 				var large_div = $("<div></div>");
	 				var text_div = $("<div></div>", {"class": "viz_text"});
	
	 				text_div.append(function(){
	                    return $("<div><strong>" +  row['additional_in_cms'] + "</strong><span class='smalltext'> : (Medicaid Total: "
	                    + row['avg_cms'] + " - Duplicates: "+ row['common_cnt']  +")</span></div>");
					});
	 				
	 				large_div.append(text_div);
	 				
					return large_div.prop("outerHTML");
     			}
    		},
    		{ data: 'additional_in_cms_download', visible: false, orderable: true, className: 'export'},
     		{ data: 'viz_total_avg', visible: true, orderable: false,
     			render: function(data, type, row, meta){
     				var large_div = $("<div></div>", {"class": "test"});
     				var max = row['max_total_avg'];
        			
     				var viz_div = $("<div></div>", {"class": "bar-chart-bar count"});

     				viz_div.append(function(){
						var bars = [];
						for (const [key, value] of Object.entries(row)) {
							if (key == 'avg_in_ehr'){
								var width = (value/max)*100
								bars.push($("<div></div>",{"class": "bar " + "barehr" }).css({ "width": width + "%"}))
							}
							if (key == 'additional_in_cms'){
								var width = (value/max)*100
								bars.push($("<div></div>",{"class": "bar " + "barcms" }).css({ "width": width + "%"}))
							}                            
                        }
                        return bars;
					});
     				
     				large_div.append(viz_div);
     				
     				
					
					return large_div.prop("outerHTML");
        		}
        	},
        	{ data: 'total_avg', visible: true, orderable: true, width: '80px',className: 'export'  },
        	{ data: 'max_total_avg', visible: false},
        	{ data: 'percentage_increase', visible: true, orderable: true, width: '80px',className: 'export'   }
    	]
	} );
});

</script>
