<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

function ${param.block}_refresh${param.array}(data) {
	
	${param.block}_${param.array} = new Array();
	$("#${param.datatable_div}-table").DataTable().rows({search:'applied'}).data().each( function ( group, i ) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'group', {
    		  value: data[i].${param.primary}
    		});
    	Object.defineProperty(obj, 'value', {
  		  value: data[i].${param.count}
  		});
    	Object.defineProperty(obj, 'variable', {
    		  value: data[i].${param.secondary}
    		});
    	${param.block}_${param.array}.push(obj);
	});
	//console.log("refreshed ${param.array}", ${param.block}_${param.array});
}
</script>