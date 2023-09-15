<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 viz-header-section">
		<h2 id="cci-title" class="viz-title"></h2>
		<div class="btn-group float-right">
			<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-download"></i>
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" onclick="save_viz_pass_cci('.jpg');">Save as JPG</a>
				<a class="dropdown-item" onclick="save_viz_pass_cci('.png');">Save as PNG</a>
				<a class="dropdown-item" onclick="save_viz_pass_cci('.svg');">Save as SVG</a>
			</div>
		</div>
	</div>
	<div class="col-12"> 
		<div id="${param.block}_cci_legend"></div>
	</div>
	<div class="col-12">
		<div class="loading">
			<img src="<util:applicationRoot/>/images/loader.gif" alt="load">
		</div>
		<div id="${param.block}_cci_viz" class="dash_viz clip">
		</div>
	</div>
</div>

<script>

//this is to change the title of the download based on which visualization mode is selected
function save_viz_pass_cci(extension){
	var text = text = "Counts of ${param.topic_title} by Charlson Comorbidity Index (CCI) Score Range and Paxlovid Status" + extension;
	saveVisualization('${param.block}_cci_viz', text);
};


var title = "Counts of ${param.topic_title} by Charlson Comorbidity Index (CCI) Score Range and Paxlovid Status";
$("#cci-title").text(title);


function ${param.block}_cci_refresh() {
	var properties = {
			domName: '${param.block}_cci_viz',
			block: '${param.block}',
			primary: 'cci',
			secondary: 'paxlovid',
			count: 'patient_count',
			xaxis_label: 'Count',
			xaxis_label2: 'Percent',
			legend_label: paxlovid_legend,
			colorscale: paxlovid_range,
			label1: 'CCI',
			label2: 'Paxlovid Status',
			offset: 170,
			array: 'paxlovid',
			legendid: '${param.block}_cci_legend',
			nopercent: true
	};
	
	d3.select("#${param.block}_cci_viz").select("svg").remove();
	
	localHorizontalGroupedBarChart_new(${param.block}_statusArray, properties);	
}

</script>
