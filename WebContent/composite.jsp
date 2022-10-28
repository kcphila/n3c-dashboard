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
	<jsp:include page="navbar.jsp" flush="true">
  		<jsp:param name="page" value="explore"/>
	</jsp:include>
	
	<div class="container content">
		<div id="cohort">
			<div class="row text-center">
				<div class="col-12">
					<h3>COVID+ Patient Demographics</h3>
				</div>
			</div>
			
			<div class="row section">
				<div class="col-12">
					<c:import url="composite/simple_grid.jsp"/>
				</div>	
			</div>
			<hr>
		</div>
	</div>
	
	

	<jsp:include page="footer.jsp" flush="true" />
	
	<c:import url="modules/popover_init.jsp"/>
	
</body>
</html>