<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="dashboard" uri="http://icts.uiowa.edu/N3CDashboardTagLib"%>
<!DOCTYPE html>


<html>
<jsp:include page="head.jsp" flush="true" />
<script src="<util:applicationRoot/>/resources/auth.js"></script>

<style>
#ph_data_drop a[aria-expanded = "true"] span.btn:after{
	font-family: "Font Awesome\ 5 Free"; 
	content: "\f056";
  	font-weight: 900;
}

#ph_data_drop a[aria-expanded = "false"] span.btn:after{
	font-family: "Font Awesome\ 5 Free"; 
	content: "\f055";
	font-weight: 900;
}

#ph_data_drop .card-header{
	background-color: white;
}

.accordion_text{
	color: #212529!important;
}

#frame .datatable_overflow{
	width: 100%;
	overflow:scroll;
}
</style>

<body>
	<jsp:include page="navbar.jsp" flush="true">
		<jsp:param name="page" value="health" />
	</jsp:include>

<!-- 	Breadcrumb logic is located in questions styled 3 and each dashboards panel -->
	<div class="container container-large content">
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="<util:applicationRoot/>/#dashboards">Dashboards</a></li>
			<li class="breadcrumb-item"><a id="dashboard_breadcrumb" href=""></a></li>
			<li id="topic_breadcrumb" class="breadcrumb-item active" aria-current="page"></li>
		</ol>
	</nav>

	<c:set var="path">public-health/${param.secondary_tab}</c:set>
	<dashboard:dashboard did="${dashboard:dashboardDidByPath(path)}">
		<div class="row">
			<div class="col-12 mx-auto">
				<div class="row">
					<div class="col-12">
						<div id="ph-dash-top">
							<h1 id="dashboard_name" class="page-title"><dashboard:dashboardTitle/></h1>
							<div id="question-description" class="section-description heading-text text-max mx-auto"><dashboard:dashboardDescription/></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		<div class="mb-5">
			<div id="dashboard" style="display: block;">
				<c:choose>
					<c:when test="${not empty param.secondary_tab }">
						<script>
								cache_browser_history("public-health", "public-health")
						</script>
						<jsp:include page="new_ph/questions.jsp?did=${tag_dashboard.did}&tertiary_tab=${param.tertiary_tab}" flush="true" />
					</c:when>
					<c:otherwise>
						<jsp:include page="new_ph/questions.jsp?did=${tag_dashboard.did}" flush="true" />
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		
		<script>
			var titleBread = document.getElementById("dashboard_breadcrumb");
			titleBread.innerHTML = '<dashboard:dashboardTitle/>';
			titleBread.setAttribute("href", "<util:applicationRoot/>/${path}");
		</script>
	</dashboard:dashboard>
		
		
		<script>
		$.getJSON("<util:applicationRoot/>/feeds/embedded_fact_sheet.jsp", function(json){
			var data = $.parseJSON(JSON.stringify(json));
			
			$('#rows').text(data['total_rows']);
			$('#sites').text(data['sites_ingested']); 	
		});
		
// 		Trying to get back broswer button to load, currently only saves last broswer
		window.addEventListener('popstate', function (event) {
			location.reload();
		});
		</script>
	</div>

	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>
