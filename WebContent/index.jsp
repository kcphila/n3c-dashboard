<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" flush="true" />
<style>

/* -------------- N3C Style Overrides ---------------------  */
.large-icons i{
	font-size: 2.8rem;
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

.heading-text{
	font-weight: 400;
}


/* -------------- Front page style ---------------------  */


/* cards ********************************************************/

.hover-card{
	cursor: pointer;
}

.hover-card:hover{
	transform: scale(1.01);
	box-shadow: 6px 7px 29px -2px rgba(197,222,255,1);
	-webkit-box-shadow: 6px 7px 29px -2px rgba(197,222,255,1);
	-moz-box-shadow: 6px 7px 29px -2px rgba(197,222,255,1);
}

.hover-card_noshadow {
	cursor: pointer;
	height: 100%;
}

.hover-card_noshadow:hover{
	transform: scale(1.01);
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

/* dashboard heading section *****************************************/
.dashboard_main{
	background: rgba(100,42,107,1);
	/* add other backgrounds here */
	background: linear-gradient(to top,rgba(255,255,255,1) 7%,rgba(255,255,255,0) 99%), linear-gradient(to right,#08354bff 0%, #0b4a69ff 47%, #0a405a8c 100%);
    margin-top: 20px;
    padding-bottom: 50px;
    padding-top: 20px;
    padding-right: 15px;
    padding-left: 15px;
}

.dashboard-heading{
	color: white;
}

.dashboard-section{
	margin-bottom: 100px;
	margin-top: 100px;
}

/* hero carousel ****************************************************/
.carousel-indicators{
	width: fit-content;
    margin: auto;
    bottom: 10px;
}
#hero_carousel{
	margin-bottom: 20px;
}

#hero_carousel .carousel-caption {
    position: absolute;
    right: 15%;
    top: 20px;
    left: 20px;
    z-index: 10;
    color: white;
    text-align: left;
    max-width: 750px;
}

/* hero carousel dynamic adjustment *******************/
@media (min-width: 1179px) and (max-width: 1350px){
	.carousel-caption h1{
		font-size: 2.3rem;
	}
	.carousel-caption h2{
		font-size: 1.8rem;
	}
	.carousel-caption .btn{
		padding: 5px 10px;
    	font-size: 1rem;
	}
	
}

@media (min-width: 913px) and (max-width: 1179px){
	.carousel-caption h1{
		font-size: 1.8rem;
	}
	.carousel-caption h2{
		font-size: 1.3rem;
	}
	.carousel-caption .btn{
		padding: 5px 10px;
    	font-size: 1rem;
	}
	
}

@media (min-width: 700px) and (max-width: 913px){
	.carousel-caption h1{
		font-size: 1.2rem;
	}
	.carousel-caption h2, 
	.carousel-caption hr{
		display:none;
	}
	.carousel-caption .btn{
		padding: 5px 10px;
    	font-size: 1rem;
	}
	
}

@media (max-width: 700px){
	#hero_carousel .carousel-caption{
		padding:0px;
		width: 100%;
		padding-right: 40px;
		text-shadow: 1px 0 0 #000, 0 -1px 0 #000, 0 1px 0 #000, -1px 0 0 #000;
	}
	#hero_carousel .btn:hover{
		text-shadow:none
	}
	#hero_carousel img{
		min-height: 150px;
	}
	#hero_carousel .carousel-indicators{
		bottom: 0px;
	}
	.carousel-caption h1{
		font-size: 1.2rem;
	}
	.carousel-caption h2, 
	.carousel-caption hr,
	.carousel-caption br{
		display:none;
	}
	.carousel-caption .btn{
		padding: 5px 10px;
    	font-size: .7rem;
	}
	
}


.slick-dots li button:before{
	font-size: 20px;
	font-family: 'Font Awesome 5 free';
	content: '\f068';
	font-weight: 900;
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
	
	<div id="hero_carousel" class="carousel slide" data-interval="10000" data-touch="true" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#hero_carousel" data-slide-to="0" class="active"></li>
			<li data-target="#hero_carousel" data-slide-to="1"></li>
			<li data-target="#hero_carousel" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img class="d-block w-100" src="<util:applicationRoot/>/images/home/dash_hero2.png" alt="First slide">
				<div class="carousel-caption" >
					<h1>N3C Dashboards</h1>
					<hr style="border-top: 1px solid white;">
					<h2 class="hidden">Reliable High-Velocity COVID-19 Insights Brought to you by the N3C.</h2>
					<br>
					<a href="#dashboards" role="button" class="btn btn-lg btn-outline-light">Dashboards</a>&emsp;
					<a href="<util:applicationRoot/>/publications" role="button" class="btn btn-lg btn-outline-light">Publications</a>&emsp;
					<a href="<util:applicationRoot/>/recover" role="button" class="btn btn-lg btn-outline-light">RECOVER Initiative</a>
				</div>
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="<util:applicationRoot/>/images/home/n3c_hero2.png" alt="Second slide">
				<div class="carousel-caption" >
					<h1>The National COVID Cohort Collaborative (N3C)</h1>
					<hr style="border-top: 1px solid white;">
					<h2 class="hidden">Your Trusted Comprehensive Source for COVID&#x2011;19 Patient-Centric Data.</h2>
					<br>
					<a href="https://covid.cd2h.org/" role="button" class="btn btn-lg btn-outline-light">Distribution</a>&emsp;
					<a href="https://covid.cd2h.org/account-instructions" role="button" class="btn btn-lg btn-outline-light">Demographics</a>&emsp;
					<a href="<util:applicationRoot/>/exploration" role="button" class="btn btn-lg btn-outline-light">About</a>
				</div>
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="<util:applicationRoot/>/images/home/phastr_hero.png" alt="Third slide">
				<div class="carousel-caption" >
					<h1>N3C Public Health Answers to Speed Tractable Results (PHASTR)</h1>
					<hr style="border-top: 1px solid white;">
					<h2 class="hidden">Fast Actionable Analysis on High-Impact COVID-19 Public Health Questions</h2>
					<br>
					<a href="https://covid.cd2h.org/phastr" role="button" class="btn btn-lg btn-outline-light">Learn More</a>&emsp;
					<a href="https://covid.cd2h.org/phastr" role="button" class="btn btn-lg btn-outline-light">Explore Results</a>
				</div>
			</div>
		</div>
	</div>
		
	<div class="container content container-large intro-section" style="margin-bottom:0px;">
		<div class="row">
			<div class="col-12 col-lg-12 col-xl-7" style="display:flex;">
				<jsp:include page="modules/fact_sheet_dashboard.jsp" />
			</div>
			<div class="col-12 col-lg-12 col-xl-5 large-icons" style="text-align:center; ">
				<h2>Explore Our Dashboards</h2>
				<div class="row">
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#data-overview'">
							<div class="card-body large-p">
								<p class="card-title">Overview<br>
								<i class="fas fa-database"></i></p>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#members'">
							<div class="card-body large-p">
								<p class="card-title">Members<br>
								<i class="fas fa-users"></i></p>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#tracking'">
							<div class="card-body large-p">
								<p class="card-title">Tracking<br>
								<i class="fas fa-chart-line"></i></p>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#cases'">
							<div class="card-body large-p">
								<p class="card-title">Cases<br>
								<i class="fas fa-virus"></i></p>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#medications'">
							<div class="card-body large-p">
								<p class="card-title">Medications<br>
						     	<i class="fas fa-pills"></i></p>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#diseases'">
							<div class="card-body large-p">
								<p class="card-title">Diseases<br>
								<i class="fas fa-head-side-cough"></i></p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="dashboard_main">
		<div id="dashboards" class="dashboard-heading">
			<div class="row container-large m-auto py-2">
				<div class="col-12 col-md-8">
					<h2>Dashboards</h2>
				</div>
				<div class="col-12 col-md-4 m-auto">
					<div class="input-group rounded">
						<input type="search" class="form-control rounded" placeholder="Search All Dashboards" aria-label="Search" aria-describedby="search-addon" />
						<span class="input-group-text border-0" id="search-addon">
							<i class="fas fa-search"></i>
						</span>
					</div>
				</div>
			</div>
		</div>
		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,
			iframe_info
			from n3c_questions_new.roster 
			where iframe_info in ('Paxlovid', 'medication-time-series', 'long-covid', 'severity-region')
			order by seqnum
		</sql:query>
		<div id="card-carousel" class="hidden">
			<h3 class="dashboard-heading text-center">FEATURED</h3>
			<div class="row featured-slick">
				<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card_noshadow mb-2 slick-card-1">
		   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
	     						<p class="card-title"><strong>${row.question}</strong></p>
	     						<jsp:include page="dashboard_descriptions/${row.iframe_info}.jsp"/>
		   					</div>
		 				</div>
		 			</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<div class="container content container-large">
		<sql:query var="topics" dataSource="jdbc/N3CPublic">
			select question,
			iframe_info
			from n3c_questions_new.roster 
			where iframe_info in ('severity-region', 'hss', 'smoking', 'delayed-mortality')
			order by seqnum
		</sql:query>
		

		<div class="dashboard-section hidden" id="data-overview" style="margin-top:0px;">
			<h3>DATA OVERVIEW</h3>
			<div class="row">
				<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
					<div class="col-12 col-md-6 col-lg-3 d-flex">
						<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/public-health/${row.iframe_info}';">
		   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
	     						<p class="card-title"><strong>${row.question}</strong></p>
	     						<jsp:include page="dashboard_descriptions/${row.iframe_info}.jsp"/>
		   					</div>
		 				</div>
		 			</div>
				</c:forEach>
			</div>
		</div>
		

		<div class="dashboard-section hidden" id="members" style="margin-top:0px;">
			<h3>MEMBERS</h3>
			<div class="row">
			
				<div class="col-12 col-md-6 col-lg-3 d-flex">
					<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/contributing-sites';">
	   					<img src="<util:applicationRoot/>/images/dashboards/data-partners.png" class="card-img-top" alt="...">
	   					<div class="card-body card-body-links">
     						<p class="card-title"><strong>Institutions Contributing Data</strong></p>
     						<p class="card-text">
								Explore our institutional data partners, the data-models they utilize, and the status of their transfers.
							</p>
							
							<div class='row card-link'>
								<div class="col col-6">
									<a href='<util:applicationRoot/>/contributing-sites'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
								</div>
							</div>
	   					</div>
	 				</div>
	 			</div>
	 			<div class="col-12 col-md-6 col-lg-3 d-flex">
					<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/users';">
	   					<img src="<util:applicationRoot/>/images/dashboards/user-metrics.png" class="card-img-top" alt="...">
	   					<div class="card-body card-body-links">
     						<p class="card-title"><strong>Site and User Metrics</strong></p>
     						<p class="card-text">
								Explore registration, usage, and other administrative metrics for the N3C.
							</p>
							
							<div class='row card-link'>
								<div class="col col-6">
									<a href='<util:applicationRoot/>/users'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
								</div>
							</div>
	   					</div>
	 				</div>
	 			</div>
	 			<div class="col-12 col-md-6 col-lg-3 d-flex">
					<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/publications';">
	   					<img src="<util:applicationRoot/>/images/dashboards/publications.png" class="card-img-top" alt="...">
	   					<div class="card-body card-body-links">
     						<p class="card-title"><strong>Publications</strong></p>
     						<p class="card-text">
								Explore the publications, presentations, and preprints resulting from research done within the N3C Data Enclave.
							</p>
							
							<div class='row card-link'>
								<div class="col col-6">
									<a href='<util:applicationRoot/>/publications'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
								</div>
							</div>
	   					</div>
	 				</div>
	 			</div>
	 			<div class="col-12 col-md-6 col-lg-3 d-flex">
					<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/collaboration-graph';">
	   					<img src="<util:applicationRoot/>/images/dashboards/collaboration-network.png" class="card-img-top" alt="...">
	   					<div class="card-body card-body-links">
     						<p class="card-title"><strong>Collaboration Networks</strong></p>
     						<p class="card-text">
								Explore the collaborations between individuals and institutions working on projects within the N3C.
							</p>
							
							<div class='row card-link'>
								<div class="col col-6">
									<a href='<util:applicationRoot/>/collaboration-graph'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
								</div>
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
			where iframe_info in ('Paxlovid', 'medication-time-series')
			order by seqnum
		</sql:query>
		

		<div class="dashboard-section hidden" id="tracking" style="margin-top:0px;">
			<h3>TRACKING</h3>
			<div class="row" style="justify-content: center;">
				<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/public-health/${row.iframe_info}';">
		   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
	     						<p class="card-title"><strong>${row.question}</strong></p>
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
			<h3>CASES</h3>
			<div class="row">
				<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/public-health/${row.iframe_info}';">
		   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
		     					<p class="card-title"><strong>${row.question}</strong></p>
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
			<h3>MEDICATIONS</h3>
			<div class="row">
				<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
					<div class="col-12 col-md-6 col-lg-3 d-flex">
						<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/public-health/${row.iframe_info}';">
		   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
		     					<p class="card-title"><strong>${row.question}</strong></p>
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
			<h3>DISEASES</h3>
			<div class="row">
				<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
					<div class="col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/public-health/${row.iframe_info}';">
		   					<img src="<util:applicationRoot/>/images/dashboards/${row.iframe_info}.png" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
		     					<p class="card-title"><strong>${row.question}</strong></p>
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
		
		
	</div>

	<jsp:include page="footer.jsp" flush="true" />
	<jsp:include page="modules/fade_animation_init.jsp" flush="true" />
</body>

<script>
$(document).ready(function(){
	var slider = $('.featured-slick').slick({
		arrows: false,
		dots: true,
		draggable: false,
		slidesToShow: 3,
		slidesToScroll: 1,
		centerMode: true,
		autoplay: false,
		responsive: [
		    {
		      breakpoint: 1200,
		      settings: {
		        arrows: false,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 2
		      }
		    },
		    {
		      breakpoint: 700,
		      settings: {
		        arrows: false,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 1
		      }
		    }
		  ]
	});
	
	slider.on('mousewheel', function(e){

	  	if(e.originalEvent.wheelDelta /120 > 0) {
	  		jQuery(this).slick('slickPrev');
	  	}
	  	else{
	  		jQuery(this).slick('slickNext');
	  	}
	});
	

	
	//slick cards resize so they are the same height as largest (need to repeate for each new carousel)
	//Get cards
	var cards = $('.slick-card-1');
	var maxHeight = 0;

	// Loop all cards and check height, if bigger than max then save it
	for (var i = 0; i < cards.length; i++) {
		if (maxHeight < $(cards[i]).outerHeight()) {
    		maxHeight = $(cards[i]).outerHeight();
  		}
	}
	// Set ALL card bodies to this height
	for (var i = 0; i < cards.length; i++) {
  		$(cards[i]).height(maxHeight);
	}
});


// code to make multi card carousel items scroll one at a time
// using slick now not this logic
// $('#featured_carousel .carousel-item').each(function(){
//     var minPerSlide = 3;
//     var next = $(this).next();
//     if (!next.length) {
//     	next = $(this).siblings(':first');
//     }
//     next.children(':first-child').clone().appendTo($(this));
    
//     for (var i=0;i<minPerSlide;i++) {
//  		next=next.next();
// 		if (!next.length) {
// 			next = $(this).siblings(':first');
// 		}
//         next.children(':first-child').clone().appendTo($(this));
// 	}
// });

// $('#test_carousel .carousel-item').each(function(){
//     var minPerSlide = 3;
//     var next = $(this).next();
//     if (!next.length) {
//     	next = $(this).siblings(':first');
//     }
//     next.children(':first-child').clone().appendTo($(this));
    
//     for (var i=0;i<minPerSlide;i++) {
//  		next=next.next();
// 		if (!next.length) {
// 			next = $(this).siblings(':first');
// 		}
//         next.children(':first-child').clone().appendTo($(this));
// 	}
// });



// stop card clicks from being triggered when clicking inner links
$(".card a").click(function(e) {
	   e.stopPropagation();
});

</script>
</html>
