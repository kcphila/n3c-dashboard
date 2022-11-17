<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div class="row geo viz_section" id="contributing_sites" style="justify-content:center;">
	<div class="col-12">
		<div class="panel panel-primary">
			<div class="panel-body">
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div id="graph" style="overflow:hidden;"></div>
						<div id="site-roster"></div>
						<jsp:include page="../modules/collaboration_map_code.jsp"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>