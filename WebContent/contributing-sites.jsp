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

.section-viz{
	width: 95%;
    margin: auto;
}

div.composite.tooltip {
    position: absolute;
    background-color: white;
    opacity: 0.9;
    height: auto;
    padding: 1px;
    pointer-events: none;
    max-width: 250px;
    padding-left: 10px;
}
</style>

<jsp:include page="head.jsp" flush="true" />

<body>
	<jsp:include page="navbar.jsp" flush="true">
  		<jsp:param name="page" value="explore"/>
	</jsp:include>
	
	<div class="container container-large content">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="<util:applicationRoot/>/#dashboards">Dashboards</a></li>
				<li id="topic_breadcrumb" class="breadcrumb-item active" aria-current="page">Institutions Contributing Data</li>
			</ol>
		</nav>
		<div class="row page-title">
			<div class="col-12">
				<h1>Institutions Contributing Data</h1>
			</div>
		</div>
		
		<div id="sites" class="section section-viz text-max">
			<div class="row">
				<div class="col-12">
					<p class="section-description heading-text text-max mx-auto">The N3C allows medical sites within the United States 
					to securely transfer anonymized data into the Enclave. The average interval for data transfer from our partners is 
					once a week. To explore the geographic coverage of our current partners, please see the map below.</p>
				</div>
			</div>
			<c:import url="modules/site_map.jsp"/>
		</div>
	</div>

	<jsp:include page="footer.jsp" flush="true" />
	<c:import url="modules/popover_init.jsp"/>
	
</body>
</html>