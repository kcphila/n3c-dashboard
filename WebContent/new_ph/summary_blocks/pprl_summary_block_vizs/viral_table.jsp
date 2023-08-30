<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/dom-to-image/2.6.0/dom-to-image.min.js"></script>





<style>

.table-hover tbody tr:hover {
    background-color: #edf6ff;
}

.table-no-borders td{
	border: none;
}

table.dataTable.compact thead th, table.dataTable.compact thead td{
	padding: 10px 5px;
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

.barunknown {
    background-color: #7458fc;
    border-radius: 5px 0px 0px 5px;
}
.barcovid{
    background-color: #4833B2;
    border-radius: 0px 5px 5px 0px;
}

.unknowntext, 
.unknowntext span{
    color: #7458fc !important;
}
.covidtext, 
.covidtext span{
    color: #4833B2 !important;
}

</style>

<script>


var ${param.block}_datatable = null;


$.getJSON("<util:applicationRoot/>/new_ph/summary_blocks/pprl_summary_block_vizs/viral_feed.jsp", function(data, error){
	
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
		th.innerHTML = '<span style="color:#333; font-weight:800; font-size:14px;">' + col[i].toString() + '</span>';
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
    	      filename: 'Viral_Variant_Counts',
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
            	        window.saveAs(blob, 'Viral_Variant_Counts.png');
            	    });
              }
    	    }, {
    	      text: 'JPG',
    	      className: 'btn btn-sm btn-light',
              action: function ( ) {
            	  domtoimage.toJpeg(document.getElementById('${param.target_div}-table'), { quality: 1, bgcolor: 'white' })
            	    .then(function (dataUrl) {
            	        var link = document.createElement('a');
            	        link.download = 'Viral_Variant_Counts.jpg';
            	        link.href = dataUrl;
            	        link.click();
            	    });
             }
        	}]
    	},
       	paging: false,
    	order: [[6, 'desc']],
     	columns: [
     		{ data: 'viral_variant', visible: true, orderable: true,className: 'export',width: '140px'},
        	{ data: 'covid_unknown', visible: true, orderable: true, orderData:[2],className: 'unknowntext export', width: '140px', render : DataTable.render.number( null, null, 0, '' )},
        	{ data: 'covid_unknown_int', visible: false},
        	{ data: 'covid_positive', visible: true, orderable: true, orderData:[4],className: 'covidtext export', width: '140px', render : DataTable.render.number( null, null, 0, '' )},
     		{ data: 'covid_positive_int', visible: false},
        	{ data: 'test', visible: true, orderable: false,
	        	render: function(data, type, row, meta){
	 				var large_div = $("<div></div>", {"class": "test"});
	 				var max = row['max_total'];

	 				var viz_div = $("<div></div>", {"class": "bar-chart-bar count"});
	
	 				viz_div.append(function(){
						var bars = [];
						for (const [key, value] of Object.entries(row)) {
							
							if (key == 'covid_unknown_int'){
								var width = 0;
								if (value >0){
									width = (value/max)*100;
								};
								bars.push($("<div></div>",{"class": "bar " + "barunknown" }).css({ "width": width + "%"}));
							}
							if (key == 'covid_positive_int'){
								var width = 0;
								if (value >0){
									width = (value/max)*100;
								};
								bars.push($("<div></div>",{"class": "bar " + "barcovid" }).css({ "width": width + "%"}));
							}                            
	                    }
	                    return bars;
					});
	 				large_div.append(viz_div);
					return large_div.prop("outerHTML");
	    		}
        	},
        	{ data: 'total', visible: true, orderable: true, orderData:[7],className: 'export bold', width: '130px', render : DataTable.render.number( null, null, 0, '' )},
        	{ data: 'total_int', visible: false},
        	{ data: 'max_total', visible: false}
    	]
	} );
});

</script>
