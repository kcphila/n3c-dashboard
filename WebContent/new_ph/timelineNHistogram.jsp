<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

function ${param.block}_refresh${param.array}(data) {
	
	${param.block}_${param.array} = new Array();

	var aData = new Object;
	$("#${param.datatable_div}-table").DataTable().rows({search:'applied'}).data().each( function ( group, i ) {
    	var month = data[i].month;
    	var medication = data[i].medication;
    	var count = data[i].actual_count;
    	if (typeof aData[month] == 'undefined')
    		aData[month] = new Object();
    	aData[month][medication] = count;
	});
	var keys =  Object.keys(aData);
	for (let i = 0; i < keys.length; i++) { 
		var obj = new Object();
	    Object.defineProperty(obj, 'date', {
  			value: new Date(keys[i] + "-02") // the -02 is to fake out the timezone calculations in D3
	    });
	    Object.defineProperty(obj, 'elements', {
	    	value: aData[keys[i]]
	    });
	    ${param.block}_${param.array}.push(obj);
	}

	${param.block}_${param.array}.sort((a,b) => (a.date > b.date) ? 1 : ((b.date > a.date) ? -1 : 0));
	console.log("refreshed ${param.array}", ${param.block}_${param.array});
}

</script>
