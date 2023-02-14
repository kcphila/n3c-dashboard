<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../graph_support/graphic_save.jsp" />

<div class="row geo viz_section" id="contributing_sites" style="justify-content:center;">
	<div class="col-12">
		<div class="panel panel-primary">
			<div>
				<h4>N3C Contributing Sites
				<span class="tip">
					<button class="btn btn-xs btn-tip gly-radius" title="Interaction Tip:" data-toggle="popover" data-placement="top" data-content="Search the Table to Update the Map.&#13;Click on a Heading to Sort the Table." aria-describedby="tooltip">
  						<i class="fas fa-lightbulb"></i>
  						<span class="sr-only">Search the Table to Update the Map.&#13;Click on a Heading to Sort the Table.</span>
					</button>
				</span>
				</h4>
			</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-12 viz-header-section">
						<div class="btn-group float-right">
							<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="fas fa-download"></i>
							</button>
							<div class="dropdown-menu dropdown-menu-right">
								<a class="dropdown-item" onclick="saveVisualization('graph', 'contributing_sites.jpg');">Save as JPG</a>
								<a class="dropdown-item" onclick="saveVisualization('graph', 'contributing_sites.png');">Save as PNG</a>
								<a class="dropdown-item" onclick="saveVisualization('graph', 'contributing_sites.svg');">Save as SVG</a>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-12 col-lg-12">
						<div id="graph" style="overflow:hidden;"></div>
						<div id="site-roster"></div>
						<jsp:include page="../modules/site_map_code.jsp"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>