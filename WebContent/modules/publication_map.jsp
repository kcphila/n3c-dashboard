<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<jsp:include page="../graph_support/graphic_save.jsp" />

<div class="row geo viz_section" id="contributing_sites" style="justify-content: center;">
	<div class="col-12">
		<div class="panel panel-primary">
			<div class="panel-body">
				<div class="row">
					<div class="col-11">
						<div id="legend" style="overflow: hidden;"></div>
					</div>
					<div class="col-1">
						<div id="filters" style="overflow: hidden;">
							<span class="tip">
								<button class="btn btn-xs btn-tip gly-radius" data-html="true" title="Interaction Tip:" data-toggle="popover" data-placement="top"
									data-content="&#x2022;Search the Table to Update the Map.&#013;&#x2022;Click on a Heading to Sort the Table.&#013;&#x2022;Click and drag to reposition the map.&#013;&#x2022;Control drag up and down to zoom out and in.&#013;&#x2022;Hover over a node to identify the site and highlight its collaborations."
									aria-describedby="tooltip">
									<i class="fas fa-lightbulb"></i> <span class="sr-only">Search the Table to Update the Map.&#13;Click on a Heading to Sort the Table.</span>
								</button>
							</span>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-12 viz-header-section">
						<div class="btn-group float-right">
							<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="fas fa-download"></i>
							</button>
							<div class="dropdown-menu dropdown-menu-right">
								<a class="dropdown-item" onclick="saveVisualization('graph', 'collaboration_map.jpg');">Save as JPG</a>
								<a class="dropdown-item" onclick="saveVisualization('graph', 'collaboration_map.png');">Save as PNG</a>
								<a class="dropdown-item" onclick="saveVisualization('graph', 'collaboration_map.svg');">Save as SVG</a>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-12 col-lg-12">
						<div id="graph" style="overflow: hidden;"></div>
						<div id="site-roster"></div>
						<jsp:include page="../modules/collaboration_map_code.jsp">
							<jsp:param name="nodes" value="sitePublications.jsp"/>
							<jsp:param name="edges" value="sitePublicationEdges.jsp"/>
							<jsp:param name="legend" value="sitePublicationLegend.jsp"/>
						</jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
