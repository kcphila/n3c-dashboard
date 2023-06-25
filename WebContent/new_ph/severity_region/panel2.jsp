<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
#d3viz .dataTables_filter{
    display: none;
}
</style>

<jsp:include page="../../graph_support/region_map_local.jsp"/>

<div id="frame">
	<div id="map1" class="group"></div>
</div>

<script>

var frame_crumbs = '';

frame_load('map1');


function frame_load(selection) {
	var $this = $("#"+selection);
	$this.load("<util:applicationRoot/>/new_ph/severity_region/"+selection+".jsp?did=${param.did}");
	cache_browser_history("public-health", "public-health/severity-region/map1");		
};

	

$(document).ready(function () {
	// set breadcrumb text to panel on intial load
    $('#topic_breadcrumb').html("Map"); 
});

</script>
