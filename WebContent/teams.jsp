<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html>
<html>

<style>
.section {
	margin-bottom: 100px;
}

.section-description {
	margin-top: 30px;
	margin-bottom: 60px;
}


</style>

<jsp:include page="head.jsp" flush="true" />

<body>
	<jsp:include page="navbar.jsp" flush="true">
		<jsp:param name="page" value="explore" />
	</jsp:include>

	<div class="container container-large content">
		<div class="row page-title">
			<div class="col-12">
				<h1>Teams and Their Results</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<p class="section-description heading-text text-max mx-auto"> 
				N3C Domain Teams enable researchers with shared interests to analyze data within the N3C Data Enclave and collaborate 
				more efficiently in a team science environment. Project Teams are groups exploring targeted research questions using 
				the N3C Data Enclave.
				</p>
			</div>
		</div>
		
		<div class="row page_nav mx-auto" style="justify-content: center;">
			<a href="#domain-teams" class="btn btn-primary" role="button">Domain Teams</a>
			<a href="#project-teams" class="btn btn-primary" role="button">Project Teams</a>
			<a href="#publications" class="btn btn-primary" role="button">Publications</a>
		</div>

		<div class="text-max mx-auto">
			<div class="section" id="domain-teams">
				<h2>Domain Teams</h2>
				<div id="domain-team-roster"></div>
				<c:import url="modules/domain_team_roster.jsp" />
			</div>
			<div class="section" id="project-teams">
				<h2>Project Teams</h2>
				<div id="project-roster"></div>
				<c:import url="modules/project_roster.jsp" />
			</div>
			<div class="section" id="publications">
				<h2>Publications</h2>
				<div id="pub_table_section">
					<div style="text-align: center; margin-bottom: 30px;">
						<div class="form-check form-check-inline publication">
							<input name="pub_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox1" value="Publication"> <label class="form-check-label" for="inlineCheckbox1"><i
								class="fas fa-book-open"></i> Publication</label>
						</div>
						<div class="form-check form-check-inline preprint">
							<input name="pub_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox2" value="Preprint"> <label class="form-check-label" for="inlineCheckbox2"><i
								class="fas fa-file"></i> Preprint</label>
						</div>
						<div class="form-check form-check-inline presentation">
							<input name="pub_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox3" value="Presentation"> <label class="form-check-label" for="inlineCheckbox3"><i
								class="fas fa-microphone"></i> Presentation</label>
						</div>
					</div>
				</div>
				<div id="publications-list"></div>
				<c:import url="modules/publications.jsp" />
			</div>
		</div>
	</div>


	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>