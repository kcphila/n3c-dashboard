<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
.viz-mode .fas{
	cursor: pointer;
	color: #b6d9ff;
}

.viz-mode .fas:hover{
	color: #007bff;
}
</style>
<div id="${param.block}-${param.dimension}-mode" class="panel-heading viz-mode">
	Choose Display:&nbsp; <i id="${param.block}-${param.dimension}-mode-barpercent" data-toggle="tooltip" data-placement="top" title="Percentage Bar Chart" class="fas fa-percent  text-primary">&nbsp;</i> 
	<i id="${param.block}-${param.dimension}-mode-bar" data-toggle="tooltip" data-placement="top" title="Bar Chart" class="fas fa-hashtag ">&nbsp;</i> 
</div>
<script>

$('#${param.block}-${param.dimension}-mode-barpercent').tooltip();
$('#${param.block}-${param.dimension}-mode-bar').tooltip();

$('#${param.block}-${param.dimension}-mode-barpercent').on('click', function() {
	
	if (!document.getElementById("${param.block}-${param.dimension}-mode-barpercent").classList.contains("text-primary")) {
		document.getElementById("${param.block}-${param.dimension}-mode-barpercent").classList.add("text-primary");
	}
	document.getElementById("${param.block}-${param.dimension}-mode-bar").classList.remove("text-primary");
	
	$("#${param.block}_${param.dimension}_viz svg").remove();
	$("#${param.block}_${param.dimension}_viz .pie-tool").remove();

	localHorizontalGroupedPercentageBarChart(${param.block}_${param.array},"${param.block}_${param.dimension}_viz", "${param.primary}", "${param.secondary}", "${param.count}", "${param.percent_label}", ${param.legend}, ${param.range}, "${param.label1}", "${param.label2}", ${param.left});	
});

$('#${param.block}-${param.dimension}-mode-bar').on('click', function() {
	
	if (!document.getElementById("${param.block}-${param.dimension}-mode-bar").classList.contains("text-primary")) {
		document.getElementById("${param.block}-${param.dimension}-mode-bar").classList.add("text-primary");
	}
	document.getElementById("${param.block}-${param.dimension}-mode-barpercent").classList.remove("text-primary");
	
	$("#${param.block}_${param.dimension}_viz svg").remove();
	$("#${param.block}_${param.dimension}_viz .pie-tool").remove();
	localHorizontalGroupedBarChart(${param.block}_${param.array},"${param.block}_${param.dimension}_viz", "${param.primary}", "${param.secondary}", "${param.count}", "${param.count_label}", ${param.legend}, ${param.range}, "${param.label1}", "${param.label2}", ${param.left});	
});


</script>
