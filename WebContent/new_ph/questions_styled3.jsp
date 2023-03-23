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

$.getJSON("<util:applicationRoot/>/feeds/questions.jsp", function(data){
	
	var json = $.parseJSON(JSON.stringify(data));
	var data = json['rows'];

	(async() => {
		
		$("body").css("cursor", "default");
		
		var index = data.findIndex(object => {
			return object.iframe_info === '${param.secondary_tab}';
		});
		
		if ($('.ph-tab .active > a').attr("href") == '#ph-summary'){
			cache_browser_history("public-health", "public-health" + (index == -1 ? '' : "/${param.secondary_tab}"))
		};
		if (index < 0) {index = 0;};
		
	 	$('#dashboard_select').val(JSON.stringify(data[index]));
			
		document.getElementById("question-tile").removeAttribute("style");
		
		frame_render(data[index]);
		

	})();
});


function frame_render(question, tertiary) {	
	
	var paramcheck = "";
	paramcheck += paramcheck + "${param.tertiary_tab}";
	
	var tertiary_check = tertiary;
	
	if (tertiary_check === undefined){
		if (paramcheck != ''){
			tertiary_check = "${param.tertiary_tab}";
		} else {
			tertiary_check = "";
		}
	}
	
	var descriptionContainer = document.getElementById("question-description");
	var titleContainer = document.getElementById("dashboard_name");
	var divContainer = document.getElementById("question-tile");
	var titleBread = document.getElementById("dashboard_breadcrumb");
	
	descriptionContainer.innerHTML = question.description;
	titleContainer.innerHTML = question.question;
	titleBread.innerHTML = question.question;
	titleBread.setAttribute("href", "<util:applicationRoot/>/public-health/"+question.iframe_info);


	var viz_id = question.seqnum;

// 	cache_browser_history("public-health", "public-health/"+question.iframe_info);
	
	divContainer.innerHTML = '<div id="d3viz"></div>';
		
	// console.log("url: " + "<util:applicationRoot/>/new_ph/frame.jsp?frame="+question.iframe_info+"&tertiary_tab="+tertiary_check)
	$("#d3viz").load("<util:applicationRoot/>/new_ph/frame.jsp?frame="+question.iframe_info+"&tertiary_tab="+tertiary_check);
	
		
// 	});
}




</script>

