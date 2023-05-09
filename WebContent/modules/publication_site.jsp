<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<jsp:include page="../graph_support/graphic_save.jsp" />

<div class="row geo viz_section" id="contributing_sites" style="justify-content: center;">
	<div class="col-12">
		<div class="panel panel-primary">
			<div class="panel-body">
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div id="site-roster"></div>
						<jsp:include page="../modules/collaboration_table.jsp">
							<jsp:param name="ror" value="${param.ror}"/>
						</jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
