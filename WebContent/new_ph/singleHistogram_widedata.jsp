<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

function ${param.block}_refresh${param.array}(data) {
	
	var arraytable = $('#${param.datatable_div}-table').DataTable();
	var allcolnames = [];

	arraytable.columns().every(function() {
		allcolnames.push(this.header().textContent)
	});
	
	var relatedcolnames = [];
	
	for (var i = 0; i < allcolnames.length; i++){
		var pattern = '${param.column_id}';
		if (allcolnames[i].includes(pattern)){
			relatedcolnames.push([allcolnames[i], i]);
		}
	}
	
	${param.block}_${param.array} = new Array();
	
	for (var i = 0; i < relatedcolnames.length; i++){
		var name = relatedcolnames[i][0];
		var parts = name.split(".");
		var seq = parts[1];
		var element = parts[2].replaceAll("_"," ");
		element = element.toLowerCase().split(' ').map((s) => s.charAt(0).toUpperCase() + s.substring(1)).join(' ');
		var count = arraytable.column(relatedcolnames[i][1], { search: 'applied' }).data().sum();
		
		var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: element
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: count
  		});
    	Object.defineProperty(obj, 'seq', {
	  		  value: seq
	  		});
    	Object.defineProperty(obj, 'abbrev', {
    		  value: element
    		});
    	${param.block}_${param.array}.push(obj);
	};


    ${param.block}_${param.array}.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
    //// console.log("refreshed ${param.array}", ${param.block}_${param.array});
}

</script>
