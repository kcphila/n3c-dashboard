<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html>
<html>

<style>
.section{
	margin-bottom:100px;
}

.section-description{
	margin-top: 30px;
	margin-bottom: 60px;
}

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
</style>

<jsp:include page="head.jsp" flush="true" />

<body>
	<jsp:include page="navbar.jsp" flush="true"/>
	
	<div class="container content">
		<div class="row page-title">
			<div class="col-12">
				<h1>N3C Data Distribution and Demographics</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<p class="section-description heading-text text-max mx-auto">The N3C Data Enclave is a secure platform through which 
				harmonized clinical data provided by our contributing members are stored. The Enclave includes demographic and clinical 
				characteristics of patients tested for or diagnosed with COVID-19 and further information about the strategies and outcomes 
				of treatments for those suspected or confirmed to have the virus. To learn more about the data within the Enclave, explore 
				the dashboards below.</p>
			</div>
		</div>
		<div class="section">
			<div class="row">
				<div class="col-12 col-md-6 d-flex">
					<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/public-health/severity-region';">
	   					<img src="<util:applicationRoot/>/images/dashboards/severity-region.png" class="card-img-top" alt="...">
	   					<div class="card-body card-body-links">
     						<p class="card-title"><strong>Regional Distribution of COVID+ Patients</strong></p>
     						<p class="card-text">
								<jsp:include page="dashboard_descriptions/severity-region.jsp"/>
							</p>
	   					</div>
	 				</div>
	 			</div>
				<div class="col-12 col-md-6 d-flex">
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
	 			<div class="col-12 col-md-6 d-flex">
					<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/public-health/hss';">
	   					<img src="<util:applicationRoot/>/images/dashboards/hss.png" class="card-img-top" alt="...">
	   					<div class="card-body card-body-links">
     						<p class="card-title"><strong>Demographics Table for IRB Submission</strong></p>
     						<p class="card-text">
								<jsp:include page="dashboard_descriptions/hss.jsp"/>
							</p>
	   					</div>
	 				</div>
	 			</div>
	 			<div class="col-12 col-md-6 d-flex">
					<div class="card hover-card flex-fill mb-2 slick-card-disease" onclick="location.href='<util:applicationRoot/>/data-overview';">
		   				<img src="<util:applicationRoot/>/images/dashboards/SummaryDataAllAges.png" class="card-img-top" alt="...">
		   				<div class="card-body card-body-links">
	     					<p class="card-title"><strong>Demographics</strong></p>
	     					<p class="card-text">
								Learn more about the N3C Data and explore demographics, comorbidities, and vaccination counts.
							</p>
							<div class='row card-link'>
								<div class="col col-6">
									<a href='<util:applicationRoot/>/data-overview'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
								</div>
							</div>
		   				</div>
		 			</div>
		 		</div>
			</div>
		</div>
	</div>
	
	

	<jsp:include page="footer.jsp" flush="true" />
	
</body>
</html>
