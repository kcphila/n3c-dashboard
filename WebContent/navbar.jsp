<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	    	<form class="form-inline">
	    		<button class="btn my-2 my-sm-0 btn-n3c" type="submit">Join N3C</button>
	  		</form>
		  	<li>
		  		<a class="nav-link" href="<util:applicationRoot/>/data-overview">composite</a>
		  	</li>
		  	<li>
		  		<a title="Administration" class="nav-link" href="<util:applicationRoot/>/admin"><i class="fas fa-users-cog"></i></a>
		  	</li>
		  	<li>
		  		<a title="Data Downloads" class="nav-link" href="<util:applicationRoot/>/downloads"><i class="fas fa-download"></i></a>
		  	</li>
		</ul>
	</div>

    
</nav>


