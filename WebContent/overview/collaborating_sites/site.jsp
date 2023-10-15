<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
.nav-card{
	width: 100%;
	color: #007bff;
	background: #edf6ff;
	border: none;
}
</style>

<!DOCTYPE html>
<html>

<jsp:include page="../../head.jsp" flush="true" />

<body>
	<jsp:include page="../../navbar.jsp" flush="true">
		<jsp:param name="page" value="explore" />
	</jsp:include>

	<div class="container container-large content">
		<jsp:include page="../block.jsp">
			<jsp:param name="block" value="collaborating_sites" />
			<jsp:param name="block_header" value="Site Collaboration Profile" />
			<jsp:param name="did" value="680" />

			<jsp:param name="simple_panel" value="collaborating_sites/site_panel.jsp?ror=${param.ror}" />
		</jsp:include>
	</div>

	<jsp:include page="../../footer.jsp" flush="true" />
	<c:import url="modules/popover_init.jsp" />

</body>
</html>
