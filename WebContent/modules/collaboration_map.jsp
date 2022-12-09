<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<jsp:include page="../graph_support/graphic_save.jsp"/>

<div class="row geo viz_section" id="contributing_sites" style="justify-content:center;">
	<div class="col-12">
		<div class="panel panel-primary">
			<div class="panel-body">
				<div class="row">
					<div class="col-12">
						<div id="legend" style="overflow:hidden;"></div>
					</div>
					<div class="col-12">
						
						<div id="filters" style="overflow:hidden;">
							<sql:query var="types" dataSource="jdbc/N3CPublic">
								select org_type,site_seq,count(*) from n3c_collaboration.collaboration_organization, n3c_dashboard.site_map where org_type=site group by 1,2 order by 2
							</sql:query>
							<c:forEach items="${types.rows}" var="row" varStatus="rowCounter">
								<c:if test="${!rowCounter.last}">
									<input type="checkbox" name="type" value="${row.org_type}" > ${row.org_type}&emsp;
								</c:if>
								<c:if test="${rowCounter.last}">
									<input type="checkbox" name="type" value="${row.org_type}" > ${row.org_type}
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div id="graph" style="overflow:hidden;"></div>
						<div id="map_save_viz">
							<button id='svgButton' class="btn btn-light btn-sm" onclick="saveVisualization('graph', 'collaboration.svg');">Save as SVG</button>
							<button id='pngButton' class="btn btn-light btn-sm" onclick="saveVisualization('graph', 'collaboration.png');">Save as PNG</button>
							<button id='jpegButton' class="btn btn-light btn-sm" onclick="saveVisualization('graph', 'collaboration.jpg');">Save as JPEG</button>
						</div>
						<div id="site-roster"></div>
						<jsp:include page="../modules/collaboration_map_code.jsp"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

	<script>
		function deselect(checkid){
		   $('#' + checkid + ' input[type="checkbox"]:checked').prop('checked',false).trigger('change');
		};
		
		function selectall(checkid){
		   $('#' + checkid + ' input[type="checkbox"]').prop('checked',true).trigger('change');
		};
	
	</script>