<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
    <link href="https://unpkg.com/tabulator-tables@5.1.2/dist/css/tabulator.min.css" rel="stylesheet">
    <script type="text/javascript" src="https://unpkg.com/tabulator-tables@5.1.2/dist/js/tabulator.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.26.0/axios.min.js" integrity="sha512-bPh3uwgU5qEMipS/VOmRqynnMXGGSRv+72H/N260MQeXZIK4PG48401Bsby9Nq5P5fz7hy5UGNmC/W1Z51h2GQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdn.jsdelivr.net/npm/d3@7"></script>

<jsp:include page="head.jsp" flush="true" />

<body>
	<jsp:include page="navbar.jsp" flush="true">
  		<jsp:param name="page" value="recover"/>
	</jsp:include>

	<div class="container content container-large">
		
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="<util:applicationRoot/>/#dashboards">Dashboards</a></li>
				<li id="topic_breadcrumb" class="breadcrumb-item active" aria-current="page">PPRL</li>
			</ol>
		</nav>
		
		<div class="row">
			<div class="col-12 col-lg-12">
				<div class="header-text">
					<h1>Privacy-Preserving Record Linkage</h1>
					<p class="heading-text">Enabling data connectivity | Ensuring data security</p>
				</div>
				<div style="display: flex; align-items: center; justify-content: center;">
					<script type='text/javascript' src='https://tableau.bi.iu.edu/javascripts/api/viz_v1.js'></script>
					<div class='tableauPlaceholder' style='width: 1300px; height: 1127px;'>
						<object class='tableauViz' width='1300' height='1127' style='display:none;'>
							<param name='host_url' value='https%3A%2F%2Ftableau.bi.iu.edu%2F' />
							<param name='embed_code_version' value='3' />
							<param name='site_root' value='&#47;t&#47;prd' />
							<param name='name' value='LinkageHonestBroker-N3CPPRL&#47;LHB' />
							<param name='tabs' value='no' />
							<param name='toolbar' value='yes' />
							<param name='iid' value='1' />
							<param name='isGuestRedirectFromVizportal' value='y' />
						</object>
					</div>
				</div>
			</div>
			
		</div>
	</div>

	<jsp:include page="footer.jsp" flush="true" />

	

</body>
</html>

