<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="dashboard" uri="http://icts.uiowa.edu/N3CDashboardTagLib"%>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>

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

.allcaps{
	text-transform: uppercase;
}

.sections{
	margin-bottom: 100px;
	margin-top: 100px;
}

.section_first{
	margin-top: 0px;
	margin-bottom: 100px;
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
	}
	#hero_carousel .carousel-caption h1{
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

.card-section-heading{
	text-align: center;
	margin-bottom: 20px;
}

.slick-track{
	padding-bottom: 18px;
}

.slick-dots{
	bottom: -10px;
}

.slick-prev, 
.slick-next{
	z-index: 1;
	width: 50px;
	height: 100%;
}

.slick-prev{
	left: 0px;
}
.slick-next{
	right: -0px;
}

.slick-prev:before, 
.slick-next:before{
	font-size: 50px;
	color: #423f4e;
	background: white;
    border-radius: 50%;
    font-family: "Font Awesome 5 Free";
    font-weight: 800; 
   
}
.slick-prev:before{
	 content: "\f137";
}
.slick-next:before{
	 content: "\f138";
}

.slick-prev.slick-disabled:before, 
.slick-next.slick-disabled:before{
	display: none;
}

.slick-dots li button:before{
	color: #007bff;
}

.slick-dots li.slick-active button:before{
	color: #007bff;
}

/* general elements  ****************************************************/
#dash_nav .col{
	padding-left: 3px;
	padding-right: 3px;
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
					<a href="#dashboards" role="button" class="btn btn-lg btn-n3c">Explore Dashboards</a>&emsp;
					<a href="<util:applicationRoot/>/publications" role="button" class="btn btn-lg btn-outline-light">Publications</a>
				</div>
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="<util:applicationRoot/>/images/home/n3c_hero2.png" alt="Second slide">
				<div class="carousel-caption" >
					<h1>The National COVID Cohort Collaborative (N3C)</h1>
					<hr style="border-top: 1px solid white;">
					<h2 class="hidden">Your Trusted Comprehensive Source for COVID&#x2011;19 Patient-Centric Data.</h2>
					<br>
					<a href="https://covid.cd2h.org/account-instructions" role="button" class="btn btn-lg btn-n3c">Get Started</a>&emsp;
					<a href="<util:applicationRoot/>/exploration" role="button" class="btn btn-lg btn-outline-light">About</a>&emsp;
					<a href="<util:applicationRoot/>/distribution-demographics" role="button" class="btn btn-lg btn-outline-light">Distribution &amp; Demographics</a>
				</div>
			</div>
			<div class="carousel-item">
				<img class="d-block w-100" src="<util:applicationRoot/>/images/home/phastr_hero.png" alt="Third slide">
				<div class="carousel-caption" >
					<h1>N3C Public Health Answers to Speed Tractable Results (PHASTR)</h1>
					<hr style="border-top: 1px solid white;">
					<h2 class="hidden">Fast Actionable Analysis on High-Impact COVID-19 Public Health Questions</h2>
					<br>
					<a href="https://covid.cd2h.org/phastr" role="button" class="btn btn-lg btn-n3c">Learn More</a>
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
				<div class="row" id="dash_nav">
					<div class="col col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#section2'">
							<div class="card-body large-p">
								<p class="card-title">Overview<br>
								<i class="fas fa-database"></i></p>
							</div>
						</div>
					</div>
					<div class="col col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#section3'">
							<div class="card-body large-p">
								<p class="card-title">Members<br>
								<i class="fas fa-users"></i></p>
							</div>
						</div>
					</div>
					<div class="col col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#section4'">
							<div class="card-body large-p">
								<p class="card-title">Tracking<br>
								<i class="fas fa-chart-line"></i></p>
							</div>
						</div>
					</div>
					<div class="col col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#section5'">
							<div class="card-body large-p">
								<p class="card-title">Cases<br>
								<i class="fas fa-virus"></i></p>
							</div>
						</div>
					</div>
					<div class="col col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#section6'">
							<div class="card-body large-p">
								<p class="card-title">Medications<br>
						     	<i class="fas fa-pills"></i></p>
							</div>
						</div>
					</div>
					<div class="col col-12 col-md-6 col-lg-4 d-flex">
						<div class="card hover-card flex-fill mb-2 nav-card" onclick="location.href='#section7'">
							<div class="card-body large-p">
								<p class="card-title">Diseases & Risk Factors<br>
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
					<jsp:include page="search/search.jsp"/>
				</div>
			</div>
		</div>
		<dashboard:foreachCategory sortCriteria="seqnum" limitCriteria="1" var="catIter">
			<dashboard:category>
				<div id="section<dashboard:categoryCid/>" class="dashboard-section hidden">
					<h3 class="dashboard-heading text-center allcaps"><dashboard:categoryLabel/></h3>
					<div class="row featured-slick slick-test">
						<dashboard:foreachBinding sortCriteria="seqnum" var="bindIter">
							<dashboard:binding>
								<jsp:include page="dashboard_descriptions/displayDashboardTile.jsp?did=${tag_binding.did}&type=spotlight" />
							</dashboard:binding>
						</dashboard:foreachBinding>
					</div>
				</div>
			</dashboard:category>
		</dashboard:foreachCategory>
	</div>

	<div class="container content container-large">
		<dashboard:foreachCategory sortCriteria="seqnum" var="catIter">
			<c:if test="${!catIter.isFirst()}">
				<dashboard:category>
					<c:choose>
						<c:when test="${tag_category.seqnum == 2}">
							<c:set var="class_value" value="section_first hidden" />
						</c:when>
						<c:otherwise>
							<c:set var="class_value" value="section_ hidden" />
						</c:otherwise>
					</c:choose>
					<div id="section<dashboard:categoryCid/>" class="${class_value}">
						<h3 class="card-section-heading allcaps"><dashboard:categoryLabel/></h3>
						<div class="row featured-slick slick-test">
							<dashboard:foreachBinding filterCriteria="exists (select * from n3c_dashboard.dashboard where dashboard.did=binding.did and active)" sortCriteria="seqnum" var="bindIter">
								<dashboard:binding>
									<jsp:include page="dashboard_descriptions/displayDashboardTile.jsp?did=${tag_binding.did}&type=regular" />
								</dashboard:binding>
							</dashboard:foreachBinding>
						</div>
					</div>
				</dashboard:category>
			</c:if>
		</dashboard:foreachCategory>
	</div>

	<jsp:include page="footer.jsp" flush="true" />
	<jsp:include page="modules/fade_animation_init.jsp" flush="true" />
</body>

<script>

// close all popovers when any carousel is changed
$(".slick-test").on("beforeChange", function (){
	$('.popover').popover('hide')
})

$(document).ready(function(){	
	
	$('.featured-slick').slick({
		arrows: true,
		dots: true,
		draggable: false,
		slidesToShow: 3.3,
		infinite: false,
		slidesToScroll: 1,
		centerMode: false,
		centerPadding: '40px',
		autoplay: false,
		responsive: [
		    {
		      breakpoint: 1200,
		      settings: {
		        arrows: true,
		        centerMode: false,
		        centerPadding: '40px',
		        slidesToShow: 2
		      }
		    },
		    {
		      breakpoint: 700,
		      settings: {
		        arrows: true,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 1
		      }
		    }
		  ]
	});
	
	$('.members-slick').slick({
		arrows: true,
		dots: true,
		draggable: false,
		infinite: false,
		slidesToShow: 3.3,
		slidesToScroll: 1,
		centerMode: false,
		autoplay: false,
		responsive: [
		    {
		      breakpoint: 1200,
		      settings: {
		        arrows: true,
		        centerMode: false,
		        centerPadding: '40px',
		        slidesToShow: 2
		      }
		    },
		    {
		      breakpoint: 700,
		      settings: {
		        arrows: true,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 1
		      }
		    }
		  ]
	});
	
	$('.diseases-slick').slick({
		arrows: true,
		dots: true,
		draggable: false,
		infinite: false,
		slidesToShow: 3.3,
		slidesToScroll: 1,
		centerMode: false,
		autoplay: false,
		responsive: [
		    {
		      breakpoint: 1200,
		      settings: {
		        arrows: true,
		        centerMode: false,
		        centerPadding: '40px',
		        slidesToShow: 2
		      }
		    },
		    {
		      breakpoint: 700,
		      settings: {
		        arrows: true,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 1
		      }
		    }
		  ]
	});
	
	$('.tracking-slick').slick({
		arrows: true,
		dots: true,
		draggable: false,
		infinite: false,
		slidesToShow: 3.3,
		slidesToScroll: 1,
		centerMode: false,
		autoplay: false,
		responsive: [
		    {
		      breakpoint: 1200,
		      settings: {
		        arrows: true,
		        centerMode: false,
		        centerPadding: '40px',
		        slidesToShow: 2
		      }
		    },
		    {
		      breakpoint: 700,
		      settings: {
		        arrows: true,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 1
		      }
		    }
		  ]
	});
	
	$('.cases-slick').slick({
		arrows: true,
		dots: true,
		draggable: false,
		infinite: false,
		slidesToShow: 3,
		slidesToScroll: 1,
		centerMode: false,
		autoplay: false,
		responsive: [
		    {
		      breakpoint: 1200,
		      settings: {
		        arrows: true,
		        centerMode: false,
		        centerPadding: '40px',
		        slidesToShow: 2
		      }
		    },
		    {
		      breakpoint: 700,
		      settings: {
		        arrows: true,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 1
		      }
		    }
		  ]
	});
	
	
	$('.medications-slick').slick({
		arrows: true,
		dots: true,
		draggable: false,
		infinite: false,
		slidesToShow: 3.3,
		slidesToScroll: 1,
		centerMode: false,
		autoplay: false,
		responsive: [
		    {
		      breakpoint: 1200,
		      settings: {
		        arrows: true,
		        centerMode: false,
		        centerPadding: '40px',
		        slidesToShow: 2
		      }
		    },
		    {
		      breakpoint: 700,
		      settings: {
		        arrows: true,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 1
		      }
		    }
		  ]
	});
	
	$('.overview-slick').slick({
		arrows: true,
		dots: true,
		draggable: false,
		infinite: false,
		slidesToShow: 3.3,
		slidesToScroll: 1,
		centerMode: false,
		autoplay: false,
		responsive: [
		    {
		      breakpoint: 1200,
		      settings: {
		        arrows: true,
		        centerMode: false,
		        centerPadding: '40px',
		        slidesToShow: 2
		      }
		    },
		    {
		      breakpoint: 700,
		      settings: {
		        arrows: true,
		        centerMode: true,
		        centerPadding: '40px',
		        slidesToShow: 1
		      }
		    }
		  ]
	}); 
});

function adjust_card_height(slick){
	//slick cards resize so they are the same height as largest (need to repeate for each new carousel)
	//Get cards
	var cards = $('.' + slick + ' .card');
	var maxHeight = 0;

	// Loop all cards and check height, if bigger than max then save it
	for (var i = 0; i < cards.length; i++) {
		if (maxHeight < $(cards[i]).outerHeight()) {
    		maxHeight = $(cards[i]).outerHeight();
  		}
	}
	// Set ALL card bodies to this height
	console.log(maxHeight);
	for (var i = 0; i < cards.length; i++) {
  		$(cards[i]).height(maxHeight);
	}
}

$(window).on("load", function() {
	adjust_card_height('featured-slick');
	adjust_card_height('overview-slick');
	adjust_card_height('members-slick');
	adjust_card_height('tracking-slick');
	adjust_card_height('cases-slick');
	adjust_card_height('medications-slick');
	adjust_card_height('diseases-slick');
});


// stop card clicks from being triggered when clicking inner links
$(".card a").click(function(e) {
	   e.stopPropagation();
});

</script>
</html>
