<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

	<div class="col col-12 col-lg-2 side-col">
		<div id="mode" class="panel-heading filter-section">
			<h4>Display</h4>
			<div class="display_toggles">
				<i data-toggle="tooltip" data-placement="top" title="Bar Chart" id="mode-bar" class="fas fa-chart-bar fa-lg active-display">&nbsp;</i> 
				<i data-toggle="tooltip" data-placement="top" title="Pie Chart" id="mode-pie" class="fas fa-chart-pie fa-lg">&nbsp;</i> 
			</div>
		</div>	
		
		<div id="filter_checks" class="panel-primary filter-section">
			<h4>Filters</h4>
			<button id="btn_clear" class="d-none btn dash-filter-btn2 mt-0 filtered" onclick="uncheckAll();"><i class="fas fa-times-circle">&nbsp;</i>Clear Filters</button>
			
			
			<div class="panel-body">
				<div class="accordion" id="age_accordion">
			 		<div class="card">
			 			<div class="card-header" id="age_heading">
							<h2 class="mb-0">
							<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#age_body" aria-expanded="true" aria-controls="age_body">
			  					Age
			 				</button>
							</h2>
						</div>
					</div>
					<div id="age_body" class="collapse" aria-labelledby="age_heading" data-parent="#age_accordion">
						<div class="card-body">
							<div id="age_panel">
								<button class="btn btn-light btn-sm" onclick="selectall('age_panel');">All</button>
								<button class="btn btn-light btn-sm" onclick="deselect('age_panel');">None</button><br>
								<button class="btn btn-light btn-sm" onclick="checkPeds();">Peds</button>
								<button class="btn btn-light btn-sm" onclick="checkAdult();">Adult</button><br>
								
								<sql:query var="ages" dataSource="jdbc/N3CPublic">
									select age_bin,age_abbrev from n3c_dashboard.age_map5 order by age_seq;
								</sql:query>
								<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
									<label class="filter_option"><input type="checkbox" name="age_bin" value="${row.age_bin}" > ${row.age_abbrev}</label>
								</c:forEach>
								
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="panel-body">
				<div class="accordion" id="race_accordion">
			 		<div class="card">
			 			<div class="card-header" id="race_heading">
							<h2 class="mb-0">
							<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#race_body" aria-expanded="true" aria-controls="race_body">
			  					Race
			 				</button>
							</h2>
						</div>
					</div>
					<div id="race_body" class="collapse" aria-labelledby="race_heading" data-parent="#race_accordion">
						<div class="card-body">
							<div id="race_panel">
								<button class="btn btn-light btn-sm" onclick="selectall('race_panel');">All</button>
								<button class="btn btn-light btn-sm" onclick="deselect('race_panel');">None</button><br>
								<sql:query var="races" dataSource="jdbc/N3CPublic">
									select race,race_abbrev from n3c_dashboard.race_map order by race_seq;
								</sql:query>
								<c:forEach items="${races.rows}" var="row" varStatus="rowCounter">
									<label class="filter_option"><input type="checkbox" name="race" value="${row.race_abbrev}" > ${row.race_abbrev}</label>
								</c:forEach>
								
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="panel-body">
				<div class="accordion" id="ethnicity_accordion">
			 		<div class="card">
			 			<div class="card-header" id="ethnicity_heading">
							<h2 class="mb-0">
							<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#ethnicity_body" aria-expanded="true" aria-controls="ethnicity_body">
			  					Ethnicity
			 				</button>
							</h2>
						</div>
					</div>
					<div id="ethnicity_body" class="collapse" aria-labelledby="ethnicity_heading" data-parent="#ethnicity_accordion">
						<div class="card-body">
							<div id="ethnicity_panel">
								<button class="btn btn-light btn-sm" onclick="selectall('ethnicity_panel');">All</button>
								<button class="btn btn-light btn-sm" onclick="deselect('ethnicity_panel');">None</button><br>
								<sql:query var="ethnicities" dataSource="jdbc/N3CPublic">
									select ethnicity,ethnicity_abbrev from n3c_dashboard.ethnicity_map order by ethnicity_seq;
								</sql:query>
								<c:forEach items="${ethnicities.rows}" var="row" varStatus="rowCounter">
									<label class="filter_option"><input type="checkbox" name="ethnicity" value="${row.ethnicity}" > ${row.ethnicity_abbrev}</label>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="panel-body">
				<div class="accordion" id="sex_accordion">
			 		<div class="card">
			 			<div class="card-header" id="sex_heading">
							<h2 class="mb-0">
							<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#sex_body" aria-expanded="true" aria-controls="sex_body">
			  					Sex
			 				</button>
							</h2>
						</div>
					</div>
					<div id="sex_body" class="collapse" aria-labelledby="sex_heading" data-parent="#sex_accordion">
						<div class="card-body">
							<div id="sex_panel">
								<button class="btn btn-light btn-sm" onclick="selectall('sex_panel');">All</button>
								<button class="btn btn-light btn-sm" onclick="deselect('sex_panel');">None</button><br>
								<sql:query var="sexes" dataSource="jdbc/N3CPublic">
									select distinct gender_abbrev as sex_abbrev,gender_seq as sex_seq from n3c_dashboard.gender_map order by sex_seq;
								</sql:query>
								<c:forEach items="${sexes.rows}" var="row" varStatus="rowCounter">
									<label class="filter_option"><input type="checkbox" name="sex" value="${row.sex_abbrev}" > ${row.sex_abbrev}</label>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="panel-body">
				<div class="accordion" id="severity_accordion">
			 		<div class="card">
			 			<div class="card-header" id="severity_heading">
							<h2 class="mb-0">
							<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#severity_body" aria-expanded="true" aria-controls="severity_body">
			  					Severity
			 				</button>
							</h2>
						</div>
					</div>
					<div id="severity_body" class="collapse" aria-labelledby="severity_heading" data-parent="#severity_accordion">
						<div class="card-body">
							<div id="severity_panel">
								<button class="btn btn-light btn-sm" onclick="selectall('severity_panel');">All</button>
								<button class="btn btn-light btn-sm" onclick="deselect('severity_panel');">None</button><br>
								<sql:query var="severities" dataSource="jdbc/N3CPublic">
									select severity,severity_abbrev from n3c_dashboard.severity_map order by severity_seq;
								</sql:query>
								<c:forEach items="${severities.rows}" var="row" varStatus="rowCounter">
									<label class="filter_option"><input type="checkbox" name="severity" value="${row.severity_abbrev}" > ${row.severity_abbrev}</label>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>			
		
		</div>

		<jsp:include page="../meta/relatedDashboardsByTitle.jsp">
			<jsp:param name="title" value="Demographics"/>
		</jsp:include>
	</div>
	
	
	<script>
		function deselect(checkid){
		   $('#' + checkid + ' input[type="checkbox"]:checked').prop('checked',false).trigger('change');
		};
		
		function selectall(checkid){
		   $('#' + checkid + ' input[type="checkbox"]').prop('checked',true).trigger('change');
		};
	
	</script>
