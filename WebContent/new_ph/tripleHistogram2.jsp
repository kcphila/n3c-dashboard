<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

function ${param.block}_refresh${param.array}(data) {

	newdata = [];
	
	$("#${param.datatable_div}-table").DataTable().rows({search:'applied'}).data().each( function (row) {
		var element = {};
		element.${param.primary} = row['${param.primary}'];
		element.${param.primary}_seq = row['${param.primary}_seq'];
		element.${param.primary}_abbrev = row['${param.primary}_abbrev'];
		element.${param.secondary} = row['${param.secondary}'];
		element.${param.secondary}_seq = row['${param.secondary}_seq'];
		element.${param.secondary}_abbrev = row['${param.secondary}_abbrev'];
		element.${param.tertiary} = row['${param.tertiary}'];
		element.${param.tertiary}_seq = row['${param.tertiary}_seq'];
		element.${param.tertiary}_abbrev = row['${param.tertiary}_abbrev'];
		element.patient_count = row['patient_count'];
		newdata.push(element);
	});

	
	function groupAndSum(arr, groupKeys, sumKeys){
		return Object.values(
			arr.reduce((acc,curr)=>{
				const group = groupKeys.map(k => curr[k]).join('-');
				acc[group] = acc[group] || Object.fromEntries(
					groupKeys.map(k => [k, curr[k]]).concat(sumKeys.map(k => [k, 0])));
				sumKeys.forEach(k => acc[group][k] += curr[k]);
			return acc;
			}, {})
		);
	}
	
	var groups = ['${param.primary}', '${param.primary}_seq', '${param.primary}_abbrev', '${param.secondary}', '${param.secondary}_seq', '${param.secondary}_abbrev', '${param.tertiary}', '${param.tertiary}_seq', '${param.tertiary}_abbrev']
	
	var res = groupAndSum(newdata, groups, ['patient_count']);
	${param.block}_${param.array} = res;

}

</script>