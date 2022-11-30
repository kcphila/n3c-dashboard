<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<jsp:include page="../graph_support/graphic_save.jsp"/>

<div class="row geo viz_section" id="contributing_sites" style="justify-content:center;">
	<div class="col-12">
		<div class="panel panel-primary">
			<div class="panel-body">
				<div class="row">
					<div class="col-2 col-md-2 col-lg-2">
						<div id="legend" style="overflow:hidden;"></div>
						<div id="filters" style="overflow:hidden;">
							<b>Filter:</b>
							<sql:query var="types" dataSource="jdbc/N3CPublic">
								select org_type,site_seq,count(*) from n3c_collaboration.collaboration_organization, n3c_dashboard.site_map where org_type=site group by 1,2 order by 2
							</sql:query>
							<c:forEach items="${types.rows}" var="row" varStatus="rowCounter">
								<c:if test="${rowCounter.first}">
									Select: <button class="btn btn-light btn-sm" onclick="selectall('filters');">All</button>&nbsp;
									<button class="btn btn-light btn-sm" onclick="deselect('filters');">None</button>
									<br>
								</c:if>
								<c:if test="${!rowCounter.first}"><br></c:if>
								<input type="checkbox" name="type" value="${row.org_type}" > ${row.org_type}
							</c:forEach>
						</div>
					</div>
					<div class="col-5 col-md-5 col-lg-5">
						<div id="description" style="overflow:hidden;">
							This map illustrates inter-institutional collaboration between N3C participating sites.
							<ul>
								<li>Node characteristics</li>
								<ul>
									<li>Color : type of institution. [Key on left]</li>
									<li>Size : proportional to the total number of investigators on collaborative Enclave projects.</li>
								</ul>
								<li>Edge characteristics</li>
								<ul>
									<li>Present if two sites collaborate on at least one Enclave project.</li>
									<li>Opacity : proportional to the total number of investigators collaborating on those projects.</li>
								</ul>
							</ul>
						</div>
					</div>
					<div class="col-5 col-md-5 col-lg-5">
						<div id="description2" style="overflow:hidden;">
							Interaction:
							<ul>
								<li>Map overall</li>
								<ul>
									<li>Click and drag to reposition the map in view.</li>
									<li>Control drag up and down to zoom out and in.</li>
									<li>Filter the table (e.g. "CTR") to limit display to only those sites matching the search criteria.</li>
								</ul>
								<li>Specific Node</li>
								<ul>
									<li>Hover over a node to identify the site and highlight its collaborations.</li>
								</ul>
							</ul>
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
