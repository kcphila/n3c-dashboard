<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" flush="true" />
<style>
.hover-card{
	cursor: pointer;
}

.hover-card:hover{
	transform: scale(1.01);
}
</style>
<body>
	<jsp:include page="navbar.jsp" flush="true" />

	<div class="container content container-large">
		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,iframe_info,substring(description from 1 for 80)||'...' as description from n3c_questions.roster where question ~ 'Summary' and visible order by seqnum
		</sql:query>
		<h2>Summary Data</h2>
		<div class="row">
			<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
				<div class="col-12 col-md-6 col-lg-4 d-flex">
					<div class="card hover-card flex-fill mb-2" onclick="location.href='public-health/${row.iframe_info}';">
	   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
	   					<div class="card-body">
	     						<h5 class="card-title"><strong>${row.question}</strong></h5>
	     						<jsp:include page="dashboard_descriptions/${row.iframe_info}.jsp"/>
	   					</div>
	 				</div>
	 			</div>
			</c:forEach>
		</div>
	
		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,iframe_info,substring(description from 1 for 80)||'...' as description from n3c_questions.roster where question ~ 'Medication' and visible order by seqnum
		</sql:query>
		<h2>Medications</h2>
		<div class="row">
			<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
				<div class="col-12 col-md-6 col-lg-4 d-flex">
					<div class="card hover-card flex-fill mb-2" onclick="location.href='public-health/${row.iframe_info}';">
	   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
	   					<div class="card-body">
	     						<h5 class="card-title"><strong>${row.question}</strong></h5>
	     						<jsp:include page="dashboard_descriptions/${row.iframe_info}.jsp"/>
	   					</div>
	 				</div>
	 			</div>
			</c:forEach>
		</div>

		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,iframe_info,substring(description from 1 for 80)||'...' as description from n3c_questions.roster where question ~ 'Disease' and visible order by seqnum
		</sql:query>
		<h2>Other Disease</h2>
		<div class="row">
			<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
				<div class="col-12 col-md-6 col-lg-4 d-flex">
					<div class="card hover-card flex-fill mb-2" onclick="location.href='public-health/${row.iframe_info}';">
	   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
	   					<div class="card-body">
	     						<h5 class="card-title"><strong>${row.question}</strong></h5>
	     						<jsp:include page="dashboard_descriptions/${row.iframe_info}.jsp"/>
	   					</div>
	 				</div>
	 			</div>
			</c:forEach>
		</div>
	
		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,
			iframe_info,
			description
			from n3c_questions.roster 
			where question !~ 'Summary' and question !~ 'Medication' and question !~ 'Disease' and visible 
			order by seqnum
		</sql:query>
		<h2>Other Aspects</h2>
		<div class="row">
			<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
				<div class="col-12 col-md-6 col-lg-4 d-flex">
					<div class="card hover-card flex-fill mb-2" onclick="location.href='public-health/${row.iframe_info}';">
	   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
	   					<div class="card-body">
	     						<h5 class="card-title"><strong>${row.question}</strong></h5>
	     						<jsp:include page="dashboard_descriptions/${row.iframe_info}.jsp"/>
	   					</div>
	 				</div>
	 			</div>
			</c:forEach>
		</div>
	</div>

	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>
