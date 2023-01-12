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

.popover {
    white-space: pre-wrap!important;    
}

#filters{
	width: fit-content;
    margin: auto;
    margin-top: 20px;
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
				<li id="topic_breadcrumb" class="breadcrumb-item active" aria-current="page">Inter-institutional Collaboration Map</li>
			</ol>
		</nav>
		<div class="row page-title">
			<div class="col-12">
				<h1>Inter-institutional Collaboration Map</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<p class="section-description heading-text text-max mx-auto"> 
				Collaborative team science is central to the N3C's mission. Below you can find a map of institutions with members working 
				within the N3C Data Enclave sized by their number of collaborative members. Links represent collaborations between at least 
				one member from each institution. The darker the link, the more collaborators. 
				 </p>
			</div>
		</div>
		<div class="section section-viz text-max">
			<div>
				<h4>Collaboration Map
					<span class="tip">
						<button class="btn btn-xs btn-tip gly-radius" data-html="true" title="Interaction Tip:" data-toggle="popover" data-placement="top" data-content="&#x2022;Search the Table to Update the Map.&#013;&#x2022;Click on a Heading to Sort the Table.&#013;&#x2022;Click and drag to reposition the map.&#013;&#x2022;Control drag up and down to zoom out and in.&#013;&#x2022;Hover over a node to identify the site and highlight its collaborations." aria-describedby="tooltip">
	  						<i class="fas fa-lightbulb"></i>
	  						<span class="sr-only">Search the Table to Update the Map.&#13;Click on a Heading to Sort the Table.</span>
						</button>
					</span>
				</h4>
			</div>
			<c:import url="modules/collaboration_map.jsp"/>
		</div>
	</div>


	<jsp:include page="footer.jsp" flush="true" />
	
	<c:import url="modules/popover_init.jsp"/>
	
</body>
</html>