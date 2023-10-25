<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

function ${param.block}_refresh${param.array}(data) {
	
	var aData = new Object;
	var bData = new Object;
	var cData = new Object;
	var dData = new Object;
	var maxIndex = 0;
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
    		secondaries.push(data[i][secondary]);
    		count += data[i][secondary];
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