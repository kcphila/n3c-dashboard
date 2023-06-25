<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>


<!-- update to new db for questions and dashboards  -->

<style>
#limitations_drop a[aria-expanded = "true"] span.btn:after{
	font-family: "Font Awesome\ 5 Free"; 
	content: "\f056";
  	font-weight: 900;
}

#limitations_drop a[aria-expanded = "false"] span.btn:after{
	font-family: "Font Awesome\ 5 Free"; 
	content: "\f055";
	font-weight: 900;
}
</style>

<script>

$(document).ready(function() {
		
		$("body").css("cursor", "default");
					
	var paramcheck = "";
	var tertiary;
	paramcheck += paramcheck + "${param.tertiary_tab}";
	
	var tertiary_check = tertiary;
	
	if (tertiary_check === undefined){
		if (paramcheck != ''){
			tertiary_check = "${param.tertiary_tab}";
		} else {
			tertiary_check = "";
		}
	}
	
	var divContainer = document.getElementById("question-tile");
	divContainer.removeAttribute("style");
	divContainer.innerHTML = '<div id="d3viz"></div>';
		
	$("#d3viz").load("<util:applicationRoot/>/new_ph/frame.jsp?did=${param.did}&tertiary_tab="+tertiary_check);
});
</script>

