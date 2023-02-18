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

<div id="${param.block}-mode" class="panel-heading viz-mode">
	<h4>Display</h4>
	<i id="${param.block}-mode-bar" data-toggle="tooltip" data-placement="top" title="Bar Chart" class="fas fa-hashtag text-primary">&nbsp;</i>  
	<i id="${param.block}-mode-barpercent" data-toggle="tooltip" data-placement="top" title="Percentage Bar Chart" class="fas fa-percent">&nbsp;</i> 
</div>

<script>

$('#${param.block}-mode-barpercent').tooltip();
$('#${param.block}-mode-bar').tooltip();

$('#${param.block}-mode-barpercent').on('click', function() {
	
	if (!document.getElementById("${param.block}-mode-barpercent").classList.contains("text-primary")) {
		document.getElementById("${param.block}-mode-barpercent").classList.add("text-primary");
	}
	document.getElementById("${param.block}-mode-bar").classList.remove("text-primary");
		
	var viz_props = ${param.viz_properties};
	for (i in viz_props){
		var properties = viz_props[i];
		
		$("#${param.block}_" + i + "_viz svg").remove();
		
		var array = eval("${param.block}_"+properties[0].array+"Array");
		localHorizontalGroupedPercentageBarChart_new(array, properties[0]);
	};	
});

$('#${param.block}-mode-bar').on('click', function() {
	
	if (!document.getElementById("${param.block}-mode-bar").classList.contains("text-primary")) {
		document.getElementById("${param.block}-mode-bar").classList.add("text-primary");
	}
	document.getElementById("${param.block}-mode-barpercent").classList.remove("text-primary");
	
	var viz_props = ${param.viz_properties};
	for (i in viz_props){
		
		var properties = viz_props[i];
		
		$("#${param.block}_" + i + "_viz svg").remove();
		
		var array = eval("${param.block}_"+properties[0].array+"Array");
		localHorizontalGroupedBarChart_new(array, properties[0]);
	};
		
});


</script>
