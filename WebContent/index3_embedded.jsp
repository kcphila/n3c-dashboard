<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" flush="true" />
<style>

/* -------------- N3C Login Overrides ---------------------  */
a{
	color: #007bff;
}

.btn-primary, .btn-primary:visited{
	color: #007bff;
	background-color: white;
    border-color: #007bff;
}

.btn-primary:hover {
    color: white !important;
    background-color: #007bff;
    border-color: #007bff;
}

.btn-primary:active {
	color: white !important;
    background-color: #007bff !important;
    border-color: #007bff !important;
    box-shadow:none !important;
}

.btn-primary:not(:disabled):not(.disabled):active, 
.btn-primary:not(:disabled):not(.disabled).active, 
.show > .btn-primary.dropdown-toggle {
    color: white;
    background-color: #007bff;
    border-color: #007bff;
}


/* -------------- Front page style ---------------------  */
.n3c-page-head {
	max-width: 750px;
	text-align:left;
/* 	background: rgba(255, 255, 255, 0.7); */
    padding: 20px;
    margin: 20px;
    color: white;
}

.n3c-page-head hr{
	border-top: 1px solid white;
}

.n3c-page-header{
	margin-bottom:50px;
	justify-content:center;
}

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
	margin-bottom: 100px;
	margin-top: 100px;
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

.nav-card{
	width: 100%;
	color: #007bff;
	background: #edf6ff;
	border: none;
}

</style>
<script>
	$(function(){
	    // Enables popover
	    $("[data-toggle=popover]").popover();
	});
</script>
<body>
	<div class="row" style="width:100%; margin:auto; padding-bottom:40px; background-position: bottom; background-size: cover; background-image: url('<util:applicationRoot/>/images/home/team_hero.png');">
			<div class="head head-text col-12 col-md-10 col-lg-10 col-xl-11">
				<div class="n3c-page-head">			
					<h1>The National COVID Cohort Collaborative (N3C)</h1>
					<hr>
					<h3 class="hidden">Your Trusted Comprehensive Source for COVID&#x2011;19 Patient-Centric Data.</h3>
					<br>
					<a href="https://covid.cd2h.org/" role="button" class="btn btn-lg btn-n3c">Learn More</a>
				</div>
			</div>
		</div>
		
	<div class="container content container-large">

		<div class="row">
			<div class="col-12 col-lg-7">
				<jsp:include page="modules/fact_sheet_dashboard.jsp" />
			</div>
			<div class="col-12 col-lg-5" style="text-align:center; ">
				<h3>Explore Our Dashboards:</h3>
				<div class="row">
					<div class="col-12 col-sm-6 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#data-overview'">
							<div class="card-body">
								<h5 class="card-title">Enclave Overview</h5>
								<h1><i class="fas fa-database"></i></h1>
							</div>
						</div>
					</div>
					<div class="col-12 col-sm-6 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#cases'">
							<div class="card-body">
								<h5 class="card-title">Cases</h5>
								<h1><i class="fas fa-virus"></i></h1>
							</div>
						</div>
					</div>
					<div class="col-12 col-sm-6 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#medications'">
							<div class="card-body">
								<h5 class="card-title">Medications</h5>
						     	<h1><i class="fas fa-pills"></i></h1>
							</div>
						</div>
					</div>
					<div class="col-12 col-sm-6 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#diseases'">
							<div class="card-body">
								<h5 class="card-title">Diseases</h5>
								<h1><i class="fas fa-head-side-cough"></i></h1>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		

	
		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,
			iframe_info
			from n3c_questions_new.roster 
			where iframe_info in ('severity-region', 'hss', 'smoking', 'delayed-mortality')
			order by seqnum
		</sql:query>
		
		<sql:query var="summary" dataSource="jdbc/N3CPublic">
			select question,
			iframe_info
			from n3c_questions_new.roster 
			where iframe_info in ('summary', 'pediatrics', 'SummaryDataAllAges')
			order by seqnum
		</sql:query>
		

		<div class="dashboard-section hidden" id="data-overview">
			<h2>Enclave Data Overview</h2>
			
			<div class="row">
				<div class="col-12 col-md-8 my-auto">
					<h4>Summary Data</h3>
					<h5>These dashboard provides an overview of the demographics, severity, vaccination status, and comorbidities of 
					COVID+ patients within the Enclave. You can explore the full data, or specifically target adult or pediatrics age groups.</h5>
				</div>
				<div class="col-12 col-md-4">
					<div id="summary_carousel" class="carousel slide" data-interval="false">
						<div class="carousel-inner">
							<c:forEach items="${summary.rows}" var="row" varStatus="rowCounter">
								<div class="carousel-item <c:choose><c:when test = "${rowCounter.count == 1}">active</c:when></c:choose>">
									<div class="card hover-card mb-2" onclick="location.href='<util:applicationRoot/>/public-health/${row.iframe_info}';">
					   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
					   					<div class="card-body">
					     						<h5 class="card-title text-center"><strong>${row.question}</strong></h5>
					     						<jsp:include page="dashboard_descriptions/${row.iframe_info}.jsp"/>
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
						<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/public-health/${row.iframe_info}';">
		   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
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
			from n3c_questions_new.roster 
			where iframe_info in ('timeline', 'reinfection-time-series', 'reinfection')
			order by seqnum
		</sql:query>
		
		<div class="dashboard-section hidden" id="cases">
			<h2>Cases</h2>
			<div class="row">
				<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/public-health/${row.iframe_info}';">
		   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
		     						<h5 class="card-title"><strong>${row.question}</strong></h5>
		     						<jsp:include page="dashboard_descriptions/${row.iframe_info}.jsp"/>
		   					</div>
		 				</div>
		 			</div>
				</c:forEach>
			</div>
		</div>
		
		
	
		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,iframe_info,substring(description from 1 for 80)||'...' as description from n3c_questions_new.roster where question ~ 'Medication' and visible order by seqnum
		</sql:query>
		<div class="dashboard-section hidden" id="medications">
			<h2>Medications</h2>
			<div class="row">
				<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
					<div class="col-12 col-md-6 col-lg-3 d-flex">
						<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/public-health/${row.iframe_info}';">
		   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
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
			from n3c_questions_new.roster 
			where iframe_info in ('hlh', 'diabetes-mellitus', 'long-covid')
			order by seqnum
		</sql:query>
		
		<div class="dashboard-section hidden" id="diseases">
			<h2>Diseases</h2>
			<div class="row">
				<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/public-health/${row.iframe_info}';">
		   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
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
			from n3c_questions_new.roster 
			where iframe_info in ('hlh', 'diabetes-mellitus', 'long-covid', 'timeline', 'reinfection-time-series', 'reinfection')
			order by seqnum
		</sql:query>
		
		<div class="dashboard-section hidden" id="card-carousel">
			<h2>Card Carousel Example</h2>
			<div class="row">
				<div id="test_carousel" class="carousel slide" data-interval="false">
					<div class="carousel-inner">
						<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
							<div class="carousel-item <c:choose><c:when test = "${rowCounter.count == 1}">active</c:when></c:choose>">
								<div class="col-12 col-lg-4">
									<div class="card hover-card mb-2" onclick="location.href='<util:applicationRoot/>/public-health/${row.iframe_info}';">
					   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
					   					<div class="card-body card-body-links">
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

	<jsp:include page="modules/fade_animation_init.jsp" flush="true" />
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
