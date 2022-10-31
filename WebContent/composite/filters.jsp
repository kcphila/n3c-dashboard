<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

	<div class="col col-12 col-md-2 ">
		<div id="mode" class="panel-heading filter-section">
			<h4>Display:</h4>
			<div class="display_toggles">
				<i data-toggle="tooltip" data-placement="top" title="Bar Chart" id="mode-bar" class="fas fa-chart-bar fa-lg active-display">&nbsp;</i> 
				<i data-toggle="tooltip" data-placement="top" title="Pie Chart" id="mode-pie" class="fas fa-chart-pie fa-lg">&nbsp;</i> 
				<i data-toggle="tooltip" data-placement="top" title="Table" id="mode-table" class="fas fa-table fa-lg">&nbsp;</i>
			</div>
		</div>
		<div class=" panel-primary filter-section">
			<h4><i class="fas fa-filter">&nbsp;</i>Filters:</h4>
			<a class="btn btn-sm dash-filter-btn mt-0" onclick="uncheckAll();" style="color:white;"><i class="fas fa-times-circle">&nbsp;</i>Reset Filters</a>
			<div class="panel-body">
				<h5 id="age"><i class="fas fa-chevron-right"></i> Age</h5>
				<div id="age_panel" style="display:none;">
					<sql:query var="ages" dataSource="jdbc/N3CPublic">
						select age_bin,age_abbrev from n3c_dashboard.age_map5 order by age_seq;
					</sql:query>
					<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="age_bin" value="${row.age_bin}" > ${row.age_abbrev}
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h5 id="race"><i class="fas fa-chevron-right"></i> Race</h5>
				<div id="race_panel" style="display:none;">
					<sql:query var="races" dataSource="jdbc/N3CPublic">
						select race,race_abbrev from n3c_dashboard.race_map order by race_seq;
					</sql:query>
					<c:forEach items="${races.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="race" value="${row.race_abbrev}" > ${row.race_abbrev}
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h5 id="ethnicity"><i class="fas fa-chevron-right"></i> Ethnicity</h5>
				<div id="ethnicity_panel" style="display:none;">
					<sql:query var="ethnicities" dataSource="jdbc/N3CPublic">
						select ethnicity,ethnicity_abbrev from n3c_dashboard.ethnicity_map order by ethnicity_seq;
					</sql:query>
					<c:forEach items="${ethnicities.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="ethnicity" value="${row.ethnicity}" > ${row.ethnicity_abbrev}
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h5 id="sex"><i class="fas fa-chevron-right"></i> Sex</h5>
				<div id="sex_panel" style="display:none;">
					<sql:query var="sexes" dataSource="jdbc/N3CPublic">
						select distinct gender_abbrev as sex_abbrev,gender_seq as sex_seq from n3c_dashboard.gender_map order by sex_seq;
					</sql:query>
					<c:forEach items="${sexes.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="sex" value="${row.sex_abbrev}" > ${row.sex_abbrev}
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h5 id="severity"><i class="fas fa-chevron-right"></i> Severity</h5>
				<div id="severity_panel" style="display:none;">
					<sql:query var="severities" dataSource="jdbc/N3CPublic">
						select severity,severity_abbrev from n3c_dashboard.severity_map order by severity_seq;
					</sql:query>
					<c:forEach items="${severities.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="severity" value="${row.severity_abbrev}" > ${row.severity_abbrev}
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
