<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

var ${param.block}_active = ${param.secondary};
var ${param.block}_active_count = 0;

function ${param.block}_present(secondary) {
	if (${param.block}_active.length == 0)
		return true;
	return ${param.block}_active.includes(secondary);
}

function ${param.block}_refresh${param.array}(data) {
	//console.log("active secondary", ${param.block}_active);
	${param.block}_active_count = 0;
	
	${param.block}_${param.array} = new Array();
	$("#${param.datatable_div}-table").DataTable().rows({search:'applied'}).data().each( function ( group, i ) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: data[i].${param.primary}
    		});
    	Object.defineProperty(obj, 'seq', {
  		  value: i
  		});
    	Object.defineProperty(obj, 'abbrev', {
  		  value: data[i].${param.primary}
  		});
    	
    	var count = 0;
    	var secondaries = new Array();
    	secondaries.push(0);
    	${param.secondary}.forEach(function(secondary,index,arr) {
    		if (${param.block}_present(secondary)) {
    			secondaries.push(data[i][secondary]);
    			count += data[i][secondary];
    			${param.block}_active_count += data[i][secondary];
    		} else {
    			secondaries.push(0);    			
    		}
    	});
    	Object.defineProperty(obj, 'secondary', {
  		  value: secondaries
  		});
    	Object.defineProperty(obj, 'count', {
  		  value: count
  		});

    	${param.block}_${param.array}.push(obj);
	});

	<c:choose>
		<c:when test="${not empty param.sort}">
		    ${param.block}_${param.array}.sort((a,b) => (a.${param.sort} > b.${param.sort}) ? 1 : ((b.${param.sort} > a.${param.sort}) ? -1 : 0));
		</c:when>
		<c:when test="${not empty param.sort_desc}">
	    	${param.block}_${param.array}.sort((a,b) => (a.${param.sort_desc} < b.${param.sort_desc}) ? 1 : ((b.${param.sort_desc} < a.${param.sort_desc}) ? -1 : 0));
		</c:when>
		<c:otherwise>
		    ${param.block}_${param.array}.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));
		</c:otherwise>
	</c:choose>
    //console.log("refreshed ${param.array}", ${param.block}_${param.array});
}

</script>