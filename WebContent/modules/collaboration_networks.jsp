<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<jsp:include page="../graph_support/graphic_save.jsp" />

<div>
	<h4>
		Collaboration Networks <span class="tip">
			<button class="btn btn-xs btn-tip gly-radius" title="Interaction Tip:" data-toggle="popover" data-placement="top"
				data-content="&#x2022;Large blue icons are projects - mousing over shows the ID
				and title.&#13;&#x2022;The remaining icons are project members (color key at the right) - mouse over to see a name."
				aria-describedby="tooltip">
				<i class="fas fa-lightbulb"></i> <span class="sr-only">Large blue icons are projects - mousing over shows the ID and title.&#13;The remaining icons are project members (color key at the
					right) - mouse over to see a name.</span>
			</button>
		</span>
	</h4>
</div>


<div class="row mb-5">
	<div class="col-12 col-lg-6 col-xl-7">
		<select id="graph-select">
			<option value="persons-research">Persons - Research DURs</option>
			<option value="orgs">Organizations - Research DURs</option>
			<option value="persons-op">Persons - Operational DURs</option>
			<option value="challenge">Challenge and connected DURs (individuals)</option>
			<option value="challenge_org">Challenge and connected DURs (organizations)</option>
		</select>
	</div>
	<div class="col-12 col-lg-6 col-xl-5">
		<div id="legend" style="display: block;"></div>
	</div>
</div>

<div class="container content container-large">
	<div id="content">
		<div id="collaboration_wrapper" class="col col-12 col-md-12 viz-section" style="display: block;">
			<div class="btn-group float-right viz-demo">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('collaboration_graph', 'collaboration_graph-age.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('collaboration_graph', 'collaboration_graph-age.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('collaboration_graph', 'collaboration_graph-age.svg');">Save as SVG</a>
				</div>
			</div>
			<div class="panel-body">
				<div id="collaboration_graph"></div>
			</div>
		</div>
		<div id="organization_wrapper" class="col col-12 col-md-12 viz-section" style="display: none;">
			<div class="btn-group float-right viz-demo">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('organization_graph', 'organization_graph.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('organization_graph', 'organization_graph.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('organization_graph', 'organization_graph.svg');">Save as SVG</a>
				</div>
			</div>
			<div class="panel-body">
				<div id="organization_graph"></div>
			</div>
		</div>
		<div id="operational_wrapper" class="col col-12 col-md-12 viz-section" style="display: none;">
			<div class="btn-group float-right viz-demo">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('operational_graph', 'operational_graph.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('operational_graph', 'operational_graph.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('operational_graph', 'operational_graph.svg');">Save as SVG</a>
				</div>
			</div>
			<div class="panel-body">
				<div id="operational_graph"></div>
			</div>
		</div>
		<div id="challenge_wrapper" class="col col-12 col-md-12 viz-section" style="display: none;">
			<div class="btn-group float-right viz-demo">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('challenge_graph', 'challenge_graph.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('challenge_graph', 'challenge_graph.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('challenge_graph', 'challenge_graph.svg');">Save as SVG</a>
				</div>
			</div>
			<div class="panel-body">
				<div id="challenge_graph"></div>
			</div>
		</div>
		<div id="challenge_org_wrapper" class="col col-12 col-md-12 viz-section" style="display: none;">
			<div class="btn-group float-right viz-demo">
				<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<i class="fas fa-download"></i>
				</button>
				<div class="dropdown-menu dropdown-menu-right">
					<a class="dropdown-item" onclick="saveVisualization('challenge_org_graph', 'challenge_org_graph.jpg');">Save as JPG</a>
					<a class="dropdown-item" onclick="saveVisualization('challenge_org_graph', 'challenge_org_graph.png');">Save as PNG</a>
					<a class="dropdown-item" onclick="saveVisualization('challenge_org_graph', 'challenge_org_graph.svg');">Save as SVG</a>
				</div>
			</div>
			<div class="panel-body">
				<div id="challenge_org_graph"></div>
			</div>
		</div>
	</div>
</div>
<c:set var="root">
	<util:applicationRoot />
</c:set>

<c:url var="encodedMapURL" value="data.jsp">
	<c:param name="detectionAlg" value="site" />
	<c:param name="resolution" value="1" />
	<c:param name="mode" value="${param.mode}" />
	<c:param name="query" value="${param.query}" />
	<c:param name="selectedNode" value="${param.selectedNode}" />
	<c:param name="radius" value="${param.radius}" />
</c:url>
<jsp:include page="../graph_support/forcePhoto.jsp" flush="true">
	<jsp:param name="charge" value="-350" />
	<jsp:param name="ld" value="70" />
	<jsp:param name="height" value="900" />
	<jsp:param name="target" value="organization_graph" />
	<jsp:param name="legend_div" value="legend" />
	<jsp:param name="data_page" value="${root}/feeds/project_organization_graph.jsp" />
	<jsp:param name="detectionAlg" value="sites" />
</jsp:include>
<jsp:include page="../graph_support/forcePhoto.jsp" flush="true">
	<jsp:param name="charge" value="-350" />
	<jsp:param name="ld" value="70" />
	<jsp:param name="height" value="0" />
	<jsp:param name="target" value="collaboration_graph" />
	<jsp:param name="data_page" value="${root}/feeds/project_graph.jsp" />
	<jsp:param name="detectionAlg" value="sites" />
</jsp:include>
<jsp:include page="../graph_support/forcePhoto.jsp" flush="true">
	<jsp:param name="charge" value="-350" />
	<jsp:param name="ld" value="70" />
	<jsp:param name="height" value="450" />
	<jsp:param name="target" value="operational_graph" />
	<jsp:param name="data_page" value="${root}/feeds/project_operational_graph.jsp" />
	<jsp:param name="detectionAlg" value="sites" />
</jsp:include>
<jsp:include page="../graph_support/forcePhoto.jsp" flush="true">
	<jsp:param name="charge" value="-350" />
	<jsp:param name="ld" value="70" />
	<jsp:param name="height" value="750" />
	<jsp:param name="target" value="challenge_graph" />
	<jsp:param name="data_page" value="${root}/feeds/project_challenge_graph.jsp" />
	<jsp:param name="detectionAlg" value="sites" />
</jsp:include>
<jsp:include page="../graph_support/forcePhoto.jsp" flush="true">
	<jsp:param name="charge" value="-350" />
	<jsp:param name="ld" value="70" />
	<jsp:param name="height" value="600" />
	<jsp:param name="target" value="challenge_org_graph" />
	<jsp:param name="data_page" value="${root}/feeds/project_challenge_organization_graph.jsp" />
	<jsp:param name="detectionAlg" value="sites" />
</jsp:include>

<c:import url="modules/popover_init.jsp" />


<script>
	function deselect(checkid) {
		$('#' + checkid + ' input[type="checkbox"]:checked').prop('checked',
				false).trigger('change');
	};

	function selectall(checkid) {
		$('#' + checkid + ' input[type="checkbox"]').prop('checked', true)
				.trigger('change');
	};
</script>

<script>
	$(document).ready(function() {
		$('#graph-select').select2();
	});

	$('#graph-select')
			.on(
					'select2:select',
					function(e) {
						var data = e.params.data;

						console.log(data.id);

						if (data.id == 'orgs') {
							document.getElementById("organization_wrapper").style.display = "block";
							document.getElementById("collaboration_wrapper").style.display = "none";
							document.getElementById("operational_wrapper").style.display = "none";
							document.getElementById("challenge_wrapper").style.display = "none";
							document.getElementById("challenge_org_wrapper").style.display = "none";
						}
						if (data.id == 'persons-research') {
							document.getElementById("organization_wrapper").style.display = "none";
							document.getElementById("collaboration_wrapper").style.display = "block";
							document.getElementById("operational_wrapper").style.display = "none";
							document.getElementById("challenge_wrapper").style.display = "none";
							document.getElementById("challenge_org_wrapper").style.display = "none";
						}
						if (data.id == 'persons-op') {
							document.getElementById("organization_wrapper").style.display = "none";
							document.getElementById("collaboration_wrapper").style.display = "none";
							document.getElementById("operational_wrapper").style.display = "block";
							document.getElementById("challenge_wrapper").style.display = "none";
							document.getElementById("challenge_org_wrapper").style.display = "none";
						}
						if (data.id == 'challenge') {
							document.getElementById("organization_wrapper").style.display = "none";
							document.getElementById("collaboration_wrapper").style.display = "none";
							document.getElementById("operational_wrapper").style.display = "none";
							document.getElementById("challenge_wrapper").style.display = "block";
							document.getElementById("challenge_org_wrapper").style.display = "none";
						}
						if (data.id == 'challenge_org') {
							console.log('reached');
							document.getElementById("organization_wrapper").style.display = "none";
							document.getElementById("collaboration_wrapper").style.display = "none";
							document.getElementById("operational_wrapper").style.display = "none";
							document.getElementById("challenge_wrapper").style.display = "none";
							document.getElementById("challenge_org_wrapper").style.display = "block";
						}

					});
</script>
