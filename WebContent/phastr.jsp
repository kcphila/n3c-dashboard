<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="dashboard" uri="http://icts.uiowa.edu/N3CDashboardTagLib"%>

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

<jsp:include page="head.jsp">
	<jsp:param name="page" value="Data Distributions and Demographics"/>
</jsp:include>

<body>
	<jsp:include page="navbar.jsp" flush="true"/>
	
	<div class="container content">
		<div class="row page-title">
			<div class="col-12">
				<h1>N3C PHASTR</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<p class="section-description heading-text text-max mx-auto">The N3C PHASTR is designed to quickly address high-impact questions that 
				can be answered with N3C data. Its goal is to provide fast, actionable analysis of high-impact public health research questions. 
				The following dashboards present the results of completed analyses. 
				To view open questions or learn more about the initiative, <a href="https://covid.cd2h.org/phastr">click here.</a></p>
			</div>
		</div>
		<div class="section">
			<div class="row">
				<div class="col-12 col-md-6 d-flex">
					<dashboard:dashboard did="929">
						<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/<dashboard:dashboardPath />';">
		   					<img src="<util:applicationRoot/>/dashboard_descriptions/displayDashboardThumbnail.jsp?did=<dashboard:dashboardDid/>" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
	     						<p class="card-title"><strong><dashboard:dashboardTitle /></strong></p>
	     						<p class="card-text">
									<dashboard:dashboardBlurb />
								</p>
								<div class='row card-link'>
									<div class="col col-6">
										<a href='<util:applicationRoot/>/<dashboard:dashboardPath />'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
									</div>
								</div>
		   					</div>
		 				</div>
	 				</dashboard:dashboard>
	 			</div>
				<div class="col-12 col-md-6 d-flex">
					<dashboard:dashboard did="64">
						<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/<dashboard:dashboardPath />';">
		   					<img src="<util:applicationRoot/>/dashboard_descriptions/displayDashboardThumbnail.jsp?did=<dashboard:dashboardDid/>" class="card-img-top" alt="...">
		   					<div class="card-body card-body-links">
	     						<p class="card-title"><strong><dashboard:dashboardTitle /></strong></p>
	     						<p class="card-text">
									<dashboard:dashboardBlurb />
								</p>
								<div class='row card-link'>
									<div class="col col-6">
										<a href='<util:applicationRoot/>/<dashboard:dashboardPath />'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
									</div>
								</div>
		   					</div>
		 				</div>
	 				</dashboard:dashboard>
	 			</div>
			</div>
		</div>
	</div>
	
	

	<jsp:include page="footer.jsp" flush="true" />
	
</body>
</html>
