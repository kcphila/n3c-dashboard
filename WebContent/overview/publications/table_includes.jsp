<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

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
	<div id="publications-list" class="text-max mx-auto"></div>
	<c:import url="/modules/publications.jsp" />
</div>
