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
	box-shadow: 6px 7px 29px -2px rgba(197,222,255,1);
	-webkit-box-shadow: 6px 7px 29px -2px rgba(197,222,255,1);
	-moz-box-shadow: 6px 7px 29px -2px rgba(197,222,255,1);
}

.dashboard-section{
	margin-bottom: 40px;
}

.carousel-control-prev-icon {
	background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23007bff' viewBox='0 0 8 8'%3E%3Cpath d='M5.25 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E") !important;
}
.carousel-control-next-icon {
	background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23007bff' viewBox='0 0 8 8'%3E%3Cpath d='M2.75 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E") !important;
}

#summary_carousel .carousel-inner:hover{
	overflow: visible;
}

#summary_carousel .carousel-inner:hover ~ .control_icon .control-icon{
  background-image: none !important;
}


@media (max-width: 992px) {
    #test_carousel .carousel-inner .carousel-item > div {
        display: none;
    }
    #test_carousel .carousel-inner .carousel-item > div:first-child {
        display: block;
    }
}

#test_carousel .carousel-inner .carousel-item.active,
#test_carousel .carousel-inner .carousel-item-next,
#test_carousel .carousel-inner .carousel-item-prev {
    display: flex;
}

#test_carousel .carousel-inner .carousel-item-right.active,
#test_carousel .carousel-inner .carousel-item-next {
	transform: translateX(33.333%);
}

@media (min-width: 992px) {
	#test_carousel .carousel-inner .carousel-item-left.active, 
	#test_carousel .carousel-inner .carousel-item-prev {
		transform: translateX(-33.333%);
	}
}

#test_carousel .carousel-inner .carousel-item-right,
#test_carousel .carousel-inner .carousel-item-left{ 
  transform: translateX(0);
}

.card-link{
	flex-grow:1;
}

.card-link .col{
	margin-top: auto;
	text-align: center;
}

.card-body-links{
	display: flex;
	flex-direction: column;
}

</style>
<script>
	$(function(){
	    // Enables popover
	    $("[data-toggle=popover]").popover();
	});
</script>
<body>
	<jsp:include page="navbar.jsp" flush="true" />
	
	<div class="row page_nav">
		<a href="#data-overview" class="btn btn-primary" role="button">Enclave Overview</a>
		<a href="#cases" class="btn btn-primary" role="button">Cases</a>
		<a href="#medications" class="btn btn-primary" role="button">Medications</a>
		<a href="#diseases" class="btn btn-primary" role="button">Diseases</a>
	</div>

	<div class="container content container-large">
		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,
			iframe_info
			from n3c_questions.roster 
			where iframe_info in ('severity-region', 'hss', 'smoking', 'delayed-mortality')
			order by seqnum
		</sql:query>
		
		<sql:query var="summary" dataSource="jdbc/N3CPublic">
			select question,
			iframe_info
			from n3c_questions.roster 
			where iframe_info in ('summary', 'pediatrics', 'SummaryDataAllAges')
			order by seqnum
		</sql:query>
		
		<div class="dashboard-section" id="fact-sheet">
			<div class="row mx-auto" style="padding: 10px; width:100%;">
				<div class="col-12 col-md-2"></div>
				<div class="col-12 col-md-8">
					<h1 style="text-align: center">The National COVID Cohort Collaborative (N3C)</h1>
					<jsp:include page="modules/fact_sheet.jsp" />
				</div>
			</div>
		</div>

		<div class="dashboard-section" id="data-overview">
			<h2>Enclave Data Overview</h2>
			
			<div class="row">
				<div class="col-8 my-auto">
					<h4>Summary Data</h3>
					<h5>These dashboard provides an overview of the demographics, severity, vaccination status, and comorbidities of 
					COVID+ patients within the Enclave. You can explore the full data, or specifically target adult or pediatrics age groups.</h5>
				</div>
				<div class="col-4">
					<div id="summary_carousel" class="carousel slide" data-interval="false">
						<div class="carousel-inner">
							<c:forEach items="${summary.rows}" var="row" varStatus="rowCounter">
								<div class="carousel-item <c:choose><c:when test = "${rowCounter.count == 1}">active</c:when></c:choose>">
									<div class="card hover-card mb-2" onclick="location.href='public-health/${row.iframe_info}';">
					   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
					   					<div class="card-body">
					     						<h5 class="card-title"><strong>${row.question}</strong></h5>
					   					</div>
					 				</div>
								</div>
							</c:forEach>
						</div>
						<a class="carousel-control-prev control_icon" href="#summary_carousel" role="button" data-slide="prev">
							<span class="carousel-control-prev-icon control-icon" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a>
						<a class="carousel-control-next control_icon" href="#summary_carousel" role="button" data-slide="next">
							<span class="carousel-control-next-icon control-icon" aria-hidden="true"></span>
					    	<span class="sr-only">Next</span>
						</a>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-12">
					<h4>Additional Topics to Explore</h4>
				</div>
			</div>
			<div class="row">
				<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
					<div class="col-12 col-md-6 col-lg-3 d-flex">
						<div class="card hover-card flex-fill mb-2" onclick="location.href='public-health/${row.iframe_info}';">
		   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
	     						<h5 class="card-title"><strong>${row.question}</strong></h5>
	     						<jsp:include page="dashboard_descriptions/${row.iframe_info}.jsp"/>
	     						<div class='row card-link'>
									<div class="col col-6">
										<a href='public-health/${row.iframe_info}'>Explore&#8196;<i class="fas fa-angle-right"></i></a> 
									</div>
									<div class="col col-6">
										<a tabindex="0" 
											class="btn btn-sm btn-primary" 
											role="button" data-html="true" 
											data-toggle="popover" 
											data-trigger="click" 
											title="<b>Available Topics</b>" 
											data-content="<a href='public-health/${row.iframe_info}/1'>COVID+ and Hospitalization</a> 
											<br> <a href='public-health/${row.iframe_info}/2'>Delayed Mortality</a>">
											Topics&#8196;<i class="fas fa-bars"></i>
										</a>
									</div>
								</div>
		   					</div>
		 				</div>
		 			</div>
				</c:forEach>
			</div>
			
		</div>
		
		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,
			iframe_info
			from n3c_questions.roster 
			where iframe_info in ('timeline', 'reinfection-time-series', 'reinfection')
			order by seqnum
		</sql:query>
		
		<div class="dashboard-section" id="cases">
			<h2>Cases</h2>
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
		
		
	
		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,iframe_info,substring(description from 1 for 80)||'...' as description from n3c_questions.roster where question ~ 'Medication' and visible order by seqnum
		</sql:query>
		<div class="dashboard-section" id="medications">
			<h2>Medications</h2>
			<div class="row">
				<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
					<div class="col-12 col-md-6 col-lg-3 d-flex">
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

		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,
			iframe_info
			from n3c_questions.roster 
			where iframe_info in ('hlh', 'diabetes-mellitus', 'long-covid')
			order by seqnum
		</sql:query>
		
		<div class="dashboard-section" id="diseases">
			<h2>Diseases</h2>
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
		
		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,
			iframe_info
			from n3c_questions.roster 
			where iframe_info in ('hlh', 'diabetes-mellitus', 'long-covid', 'timeline', 'reinfection-time-series', 'reinfection')
			order by seqnum
		</sql:query>
		
		<div class="dashboard-section" id="card-carousel">
			<h2>Card Carousel Example</h2>
			<div class="row">
				<div id="test_carousel" class="carousel slide" data-interval="false">
					<div class="carousel-inner">
						<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
							<div class="carousel-item <c:choose><c:when test = "${rowCounter.count == 1}">active</c:when></c:choose>">
								<div class="col-12 col-lg-4">
									<div class="card hover-card mb-2" onclick="location.href='public-health/${row.iframe_info}';">
					   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
					   					<div class="card-body">
					     						<h5 class="card-title"><strong>${row.question}</strong></h5>
					     						<jsp:include page="dashboard_descriptions/${row.iframe_info}.jsp"/>
					   					</div>
					 				</div>
					 			</div>
							</div>
						</c:forEach>
					</div>
					<a class="carousel-control-prev" href="#test_carousel" role="button" data-slide="prev">
						<span class="carousel-control-prev-icon control-icon" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a>
					<a class="carousel-control-next" href="#test_carousel" role="button" data-slide="next">
						<span class="carousel-control-next-icon control-icon" aria-hidden="true"></span>
				    	<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</div>
		
		
	</div>

	<jsp:include page="footer.jsp" flush="true" />
</body>

<script>
	
// code to make multi card carousel items scroll one at a time
$('#test_carousel .carousel-item').each(function(){
    var minPerSlide = 3;
    var next = $(this).next();
    if (!next.length) {
    	next = $(this).siblings(':first');
    }
    next.children(':first-child').clone().appendTo($(this));
    
    for (var i=0;i<minPerSlide;i++) {
 		next=next.next();
		if (!next.length) {
			next = $(this).siblings(':first');
		}
        next.children(':first-child').clone().appendTo($(this));
	}
});

// stop card clicks from being triggered when clicking inner links
$(".card a").click(function(e) {
	   e.stopPropagation();
});

</script>
</html>
