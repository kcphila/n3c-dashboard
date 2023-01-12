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
</style>

<jsp:include page="head.jsp" flush="true" />

<body>
	<jsp:include page="navbar.jsp" flush="true"/>
	
	<div class="container container-large content">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="<util:applicationRoot/>/#dashboards">Dashboards</a></li>
				<li id="topic_breadcrumb" class="breadcrumb-item active" aria-current="page">N3C Publications</li>
			</ol>
		</nav>
		<div class="row page-title">
			<div class="col-12">
				<h1>N3C Publications</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<p class="section-description heading-text text-max mx-auto">Team science and attribution are central to the N3C's mission. 
				Because of this, N3C strives to create a conducive environment for research publication by providing 
				hands-on assistance during the manuscript preparation process and by highlighting research dissemination 
				in both traditional and non-traditional venues, including academic journals, preprint forums, 
				and public presentations. </p>
			</div>
		</div>
		<div class="section">
			<div class="row justify-content-center">
				<div class="col-12 col-sm-10">
					<div id="pub_table_section">
						<div style="text-align:center; margin-bottom:30px;">
							<div class="form-check form-check-inline publication">
	  							<input name="pub_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox1" value="Publication">
	  							<label class="form-check-label" for="inlineCheckbox1"><i class="fas fa-book-open"></i>  Publication</label>
							</div>
							<div class="form-check form-check-inline preprint">
	  							<input name="pub_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox2" value="Preprint">
	  							<label class="form-check-label" for="inlineCheckbox2"><i class="fas fa-file"></i>  Preprint</label>
							</div>
							<div class="form-check form-check-inline presentation">
	 							<input name="pub_type" class="form-check-input filter" type="checkbox" id="inlineCheckbox3" value="Presentation">
	  							<label class="form-check-label" for="inlineCheckbox3"><i class="fas fa-microphone"></i>  Presentation</label>
							</div>
						</div>
						<div id="publications-list" class="text-max mx-auto"></div>
						<c:import url="modules/publications.jsp"/>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	

	<jsp:include page="footer.jsp" flush="true" />
	
</body>
</html>
