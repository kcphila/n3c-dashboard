<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row page_nav mx-auto" style="justify-content: center;">
	<a href="#domain-teams" class="btn btn-primary" role="button">Domain Teams</a> <a href="#project-teams" class="btn btn-primary" role="button">Project Teams</a> <a href="#publications"
		class="btn btn-primary" role="button">Publications</a>
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
