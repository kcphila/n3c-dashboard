<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

function ${param.block}_refresh${param.array}(data) {

	var aData = new Object;
	var bData = new Object;
	var cData = new Object;
	$("#${param.datatable_div}-table").DataTable().rows({search:'applied'}).data().each( function ( group, i ) {
	
		if ('${param.filter_col2}' == 'null'){
			if (data[i].${param.filter_col} == '${param.filter}'){
				<c:choose>
					<c:when test="${empty param.primary_abbrev}">
		    			var group = data[i].${param.primary};
					</c:when>
					<c:otherwise>
						var group = data[i].${param.primary_abbrev};
					</c:otherwise>
				</c:choose>
			
				if (typeof data[i].${param.primary}_abbrev !== 'undefined'){
					cData[group] = data[i].${param.primary}_abbrev;
				}else{
					cData[group] = data[i].${param.primary};
				};
		    	var seq = data[i].${param.primary}_seq;
		    	var count = data[i].${param.count};
		        if (typeof aData[group] == 'undefined') {
		            aData[group] = count;
		            bData[group] = seq;
		         } else
		        	 aData[group] += count;
			};
		} else {
			if (data[i].${param.filter_col} == '${param.filter}' && data[i].${param.filter_col2} == '${param.filter2}'){
				<c:choose>
					<c:when test="${empty param.primary_abbrev}">
		    			var group = data[i].${param.primary};
					</c:when>
					<c:otherwise>
						var group = data[i].${param.primary_abbrev};
					</c:otherwise>
				</c:choose>
			
				if (typeof data[i].${param.primary}_abbrev !== 'undefined'){
					cData[group] = data[i].${param.primary}_abbrev;
				}else{
					cData[group] = data[i].${param.primary};
				};
		    	var seq = data[i].${param.primary}_seq;
		    	var count = data[i].${param.count};
		        if (typeof aData[group] == 'undefined') {
		            aData[group] = count;
		            bData[group] = seq;
		         } else
		        	 aData[group] += count;
			};
		}
	});

	${param.block}_${param.array} = new Array();
    for(var i in aData) {
    	var obj = new Object();
    	Object.defineProperty(obj, 'element', {
    		  value: i
    		});
    	Object.defineProperty(obj, 'count', {
  		  value: aData[i]
  		});
    	Object.defineProperty(obj, 'seq', {
	  		  value: bData[i]
	  		});
    	Object.defineProperty(obj, 'abbrev', {
    		  value: cData[i]
    		});
    	${param.block}_${param.array}.push(obj);
    }
    ${param.block}_${param.array}.sort((a,b) => (a.seq > b.seq) ? 1 : ((b.seq > a.seq) ? -1 : 0));

}

</script>
