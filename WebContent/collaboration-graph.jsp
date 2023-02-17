<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html>
<html>

<style>
.section{
	margin-bottom:100px;
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
		<jsp:include page="overview/collaboration_graph/collaboration_graph.jsp" flush="true" />
	</div>


	<jsp:include page="footer.jsp" flush="true" />
	
	<c:import url="modules/popover_init.jsp"/>
	
</body>
</html>