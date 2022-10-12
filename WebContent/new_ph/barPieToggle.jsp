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
	<i id="${param.block}-${param.dimension}-mode-pie" data-toggle="tooltip" data-placement="top" title="Pie Chart" class="fas fa-chart-pie ">&nbsp;</i>
</div>
<script>

$('#${param.block}-${param.dimension}-mode-barpercent').tooltip();
$('#${param.block}-${param.dimension}-mode-bar').tooltip();
$('#${param.block}-${param.dimension}-mode-pie').tooltip();

$('#${param.block}-${param.dimension}-mode-barpercent').on('click', function() {

	properties = {
			domName: '#${param.block}_${param.dimension}_viz',
			barLabelWidth: 120,
			min_height: ${param.dimension_minheight},
			ordered: 0,
			colorscale: ${param.dimension_range},
			legend_label: '${param.dimension_name}',
			legend_data: ${param.dimension_legend},
			donutRatio: 0.5
		}
	
	
	if (!document.getElementById("${param.block}-${param.dimension}-mode-barpercent").classList.contains("text-primary")) {
		document.getElementById("${param.block}-${param.dimension}-mode-barpercent").classList.add("text-primary");
	}
	document.getElementById("${param.block}-${param.dimension}-mode-pie").classList.remove("text-primary");
	document.getElementById("${param.block}-${param.dimension}-mode-bar").classList.remove("text-primary");
	$("#${param.block}_${param.dimension}_viz svg").remove();
	$("#${param.block}_${param.dimension}_viz .pie-tool").remove();
	localPercentageBarChart(${param.block}_${param.dimension_name}Array, properties);
});

$('#${param.block}-${param.dimension}-mode-bar').on('click', function() {
	
	properties = {
			domName: '#${param.block}_${param.dimension}_viz',
			barLabelWidth: 120,
			min_height: ${param.dimension_minheight},
			ordered: 0,
			colorscale: ${param.dimension_range},
			legend_label: '${param.dimension_name}',
			legend_data: ${param.dimension_legend},
			donutRatio: 0.5
		}
	
	if (!document.getElementById("${param.block}-${param.dimension}-mode-bar").classList.contains("text-primary")) {
		document.getElementById("${param.block}-${param.dimension}-mode-bar").classList.add("text-primary");
	}
	document.getElementById("${param.block}-${param.dimension}-mode-pie").classList.remove("text-primary");
	document.getElementById("${param.block}-${param.dimension}-mode-barpercent").classList.remove("text-primary");
	$("#${param.block}_${param.dimension}_viz svg").remove();
	$("#${param.block}_${param.dimension}_viz .pie-tool").remove();
	localHorizontalBarChart_legend(${param.block}_${param.dimension_name}Array, properties);
});

$('#${param.block}-${param.dimension}-mode-pie').on('click', function() {
	
	properties = {
			domName: '#${param.block}_${param.dimension}_viz',
			barLabelWidth: 120,
			min_height: ${param.dimension_minheight},
			ordered: 0,
			colorscale: ${param.dimension_range},
			legend_label: '${param.dimension_name}',
			legend_data: ${param.dimension_legend},
			donutRatio: 0.5
		}
	
	if (!document.getElementById("${param.block}-${param.dimension}-mode-pie").classList.contains("text-primary")) {
		document.getElementById("${param.block}-${param.dimension}-mode-pie").classList.add("text-primary");
	}
	document.getElementById("${param.block}-${param.dimension}-mode-barpercent").classList.remove("text-primary");
	document.getElementById("${param.block}-${param.dimension}-mode-bar").classList.remove("text-primary");
	$("#${param.block}_${param.dimension}_viz svg").remove();
	$("#${param.block}_${param.dimension}_viz .pie-tool").remove();
	localPieChart(${param.block}_${param.dimension_name}Array, properties);
});

</script>
