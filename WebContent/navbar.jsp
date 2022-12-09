<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="navbar-nih-branding-bar l-ribbon-wrapper">
  <ul class="l-ribbon">
    <li><span class="ribbon-hhs"></span><a id="hhs" href="https://www.hhs.gov">U.S. Department of Health &amp; Human Services</a><span class="ribbon-right"></span></li>
    <li><span class="ribbon-nih"></span><a id="nih" href="https://www.nih.gov/">National Institutes of Health</a><span class="ribbon-right"></span></li>
    <li><span class="ribbon-nih"></span><a id="ncats" href="https://ncats.nih.gov/">National Center for Advancing Translational Sciences</a><span class="ribbon-right"></span></li>
    <li><span class="ribbon-n3c"></span><a id="n3c" href="https://covid.cd2h.org/">National COVID Cohort Collaborative</a><span class="ribbon-right"></span></li>
  </ul>
</div>

<nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-between" style="margin-bottom:0px;">
	<a class="navbar-brand" href="<util:applicationRoot/>/">
		<img src="<util:applicationRoot/>/images/n3c_logo.png" width="30" height="30" class="d-inline-block" alt="N3C logo">
		N3C Dashboards
	</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
  

	<div class="collapse navbar-collapse" id="navbarNav">
		<ul class="navbar-nav">
			<c:if test="${not empty admin}">
				<li class="nav-item">
					<a class="nav-link" href="dashboard.jsp">Dashboard</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="admin.jsp">Admin</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="https://cd2h.org">CD2H</a>
				</li>
			</c:if>
		</ul>
		<ul class="navbar-nav ml-auto ">
<!-- 			<li> -->
<!-- 	    		<a role="button" href="https://covid.cd2h.org/account-instructions" class="btn my-2 my-sm-0 btn-n3c">Join N3C</a> -->
<!-- 	    	</li> -->
	    	<li>
	    		<div class="btn-group">
  					<button id="join_btn" type="button" class="btn btn-n3c dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    					Join N3C
  					</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="https://covid.cd2h.org/for-researchers">Researchers</a>
						<a class="dropdown-item" href="https://covid.cd2h.org/for-institutions">Institutions</a>
  					</div>
				</div>
		  	<li>
		  		<a title="Administration" class="nav-link" href="<util:applicationRoot/>/admin"><i class="fas fa-users-cog"></i></a>
		  	</li>
		  	<li>
		  		<a title="Data Downloads" class="nav-link" href="<util:applicationRoot/>/downloads"><i class="fas fa-download"></i></a>
		  	</li>
		</ul>
	</div>

    
</nav>


