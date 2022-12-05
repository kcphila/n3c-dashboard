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

.section-heading{
	margin-top: 30px;
	margin-bottom: 30px;
	text-align: center;
}

.display_toggles{
	color: #b6d9ff;
}

.display_toggles .fas{
	cursor: pointer;
	color: #b6d9ff;
}

.display_toggles .fas:hover{
	color: #007bff;
}

.display_toggles .active-display{
	color: #007bff!important;
}

.filter-section{
	margin-top:20px;
}

#limitations_drop a[aria-expanded = "false"] span.btn:after {
    font-family: "Font Awesome\ 5 Free";
    content: "\f055";
    font-weight: 900;
}

#limitations_drop a[aria-expanded = "true"] span.btn:after {
    font-family: "Font Awesome\ 5 Free";
    content: "\f056";
    font-weight: 900;
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

.filter-drop{
	cursor: pointer;
}

.multiselect-group.dropdown-item-text{
	font-weight:600;
}
</style>

<jsp:include page="head.jsp" flush="true" />

<body>
	<jsp:include page="navbar.jsp" flush="true">
  		<jsp:param name="page" value="explore"/>
	</jsp:include>
	
	<div class="container-fluid content">
		<div id="cohort">
			<div class="section-heading">
				<h2>Domain Teams and Investigator Teams</h2>
			</div>
			
			<div class="section section-viz">
				<div class="row">
					<div class="col-6 col-md-6 col-lg-6">
						<h3>Domain Teams</h3>
						<div id="domain-team-roster"></div>
						<c:import url="modules/domain_team_roster.jsp"/>
					</div>
					<div class="col-6 col-md-6 col-lg-6">
						<h3>Investigator Teams</h3>
						<div id="project-roster"></div>
						<c:import url="modules/project_roster.jsp"/>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp" flush="true" />
	
	<c:import url="modules/popover_init.jsp"/>
	
	<script>
	$(document).ready(function() {       
		$('#dimension_select').multiselect({		
		});
	});
	
	</script>
</body>
</html>