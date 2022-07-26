<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

function ${param.block}_refresh${param.array}(data) {
	
	${param.block}_${param.array} = new Array();

	$("#${param.datatable_div}-table").DataTable().rows({search:'applied'}).data().each( function ( group, i ) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'date', {
    		  value: new Date(data[i].initial + "-02") // the -02 is to fake out the timezone calculations in D3
    		});
    	Object.defineProperty(obj, 'column1', {
  		  value: data[i].actual_count
  		});
    	Object.defineProperty(obj, 'column1_display', {
    		  value: data[i].count
    		});
    	Object.defineProperty(obj, 'column2', {
	  		  value: data[i].seven_day_rolling_avg
	  		});
    	${param.block}_${param.array}.push(obj);
    	Object.defineProperty(obj, 'initial', {
  		  value: data[i].initial
  		});
	});

    ${param.block}_${param.array}.sort((a,b) => (a.initial > b.initial) ? 1 : ((b.initial > a.initial) ? -1 : 0));
//    console.log("refreshed ${param.array}", ${param.block}_${param.array});
}

</script>
