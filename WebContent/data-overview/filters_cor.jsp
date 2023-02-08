<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

	<div class="col col-12 col-md-2 ">
		<div id="mode" class="panel-heading filter-section">
			<h4>Display:</h4>
			<div class="display_toggles">
				<i data-toggle="tooltip" data-placement="top" title="Bar Chart" id="mode-bar" class="fas fa-chart-bar fa-lg active-display">&nbsp;</i> 
				<i data-toggle="tooltip" data-placement="top" title="Pie Chart" id="mode-pie" class="fas fa-chart-pie fa-lg">&nbsp;</i> 
			</div>
		</div>	
		
		<div id="filter_checks" class="panel-primary filter-section">
			<h4>Filters:</h4>
			<a id="btn_clear" class="d-none btn btn-sm dash-filter-btn mt-0 filtered" onclick="uncheckAll();" style="color:white;"><i class="fas fa-times-circle">&nbsp;</i>Reset Filters</a>
			<div class="panel-body">
				<h5 class="filter-drop" id="age"><i class="fas fa-chevron-right"></i> Age</h5>
				<div id="age_panel" style="display:none;">
					<button class="btn btn-light btn-sm" onclick="checkPeds();">Peds</button>
					<button class="btn btn-light btn-sm" onclick="checkAdult();">Adult</button><br>
					<sql:query var="ages" dataSource="jdbc/N3CPublic">
						select age_bin,age_abbrev from n3c_dashboard.age_map6 order by age_seq;
					</sql:query>
					<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
						<c:if test="${rowCounter.first}">
							Select: 
							<button class="btn btn-light btn-sm" onclick="selectall('age_panel');">All</button>&nbsp;
							<button class="btn btn-light btn-sm" onclick="deselect('age_panel');">None</button>
							<br>
						</c:if>
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="age_bin" value="${row.age_bin}" > ${row.age_abbrev}
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h5 class="filter-drop" id="race"><i class="fas fa-chevron-right"></i> Race</h5>
				<div id="race_panel" style="display:none;">
					<sql:query var="races" dataSource="jdbc/N3CPublic">
						select race,race_abbrev from n3c_dashboard.race_map order by race_seq;
					</sql:query>
					<c:forEach items="${races.rows}" var="row" varStatus="rowCounter">
						<c:if test="${rowCounter.first}">
							Select: <button class="btn btn-light btn-sm" onclick="selectall('race_panel');">All</button>&nbsp;
							<button class="btn btn-light btn-sm" onclick="deselect('race_panel');">None</button>
							<br>
						</c:if>
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="race" value="${row.race_abbrev}" > ${row.race_abbrev}
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h5 class="filter-drop" id="sex"><i class="fas fa-chevron-right"></i> Sex</h5>
				<div id="sex_panel" style="display:none;">
					<sql:query var="sexes" dataSource="jdbc/N3CPublic">
						select distinct gender_abbrev as sex_abbrev,gender_seq as sex_seq from n3c_dashboard.gender_map order by sex_seq;
					</sql:query>
					<c:forEach items="${sexes.rows}" var="row" varStatus="rowCounter">
						<c:if test="${rowCounter.first}">
							Select: <button class="btn btn-light btn-sm" onclick="selectall('sex_panel');">All</button>&nbsp;
							<button class="btn btn-light btn-sm" onclick="deselect('sex_panel');">None</button>
							<br>
						</c:if>
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="sex" value="${row.sex_abbrev}" > ${row.sex_abbrev}
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h5 class="filter-drop" id="severity"><i class="fas fa-chevron-right"></i> Severity</h5>
				<div id="severity_panel" style="display:none;">
					<sql:query var="severities" dataSource="jdbc/N3CPublic">
						select severity,severity_abbrev from n3c_dashboard.severity_map order by severity_seq;
					</sql:query>
					<c:forEach items="${severities.rows}" var="row" varStatus="rowCounter">
						<c:if test="${rowCounter.first}">
							Select: <button class="btn btn-light btn-sm" onclick="selectall('severity_panel');">All</button>&nbsp;
							<button class="btn btn-light btn-sm" onclick="deselect('severity_panel');">None</button>
							<br>
						</c:if>
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="severity" value="${row.severity_abbrev}" > ${row.severity_abbrev}
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h5 class="filter-drop" id="comorbidities"><i class="fas fa-chevron-right"></i> Comorbidities</h5>
				<div id="comorbidity_panel" style="display:none;">
					<sql:query var="comorbidities" dataSource="jdbc/N3CPublic">
						SELECT 
						distinct(
							case when (replace(condition_name, 'Charlson - ', '')) = 'DM' then 'Diabetes'
			            	else replace(condition_name, 'Charlson - ', '')
			            	end) AS symptoms, 
			            	(replace(condition_name, 'Charlson - ', '')) as condition_name
						from n3c_questions_new.covid_positive_comorbidity_non_grouped_demo_censored
						order by symptoms;
					</sql:query>
					<c:forEach items="${comorbidities.rows}" var="row" varStatus="rowCounter">
						<c:if test="${rowCounter.first}">
							Select: <button class="btn btn-light btn-sm" onclick="selectall('comorbidity_panel');">All</button>&nbsp;
							<button class="btn btn-light btn-sm" onclick="deselect('comorbidity_panel');">None</button>
							<br>
						</c:if>
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="comorbidity" value="${row.condition_name}" > ${row.condition_name}
					</c:forEach>
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
