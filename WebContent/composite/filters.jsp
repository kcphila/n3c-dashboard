<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

	<div class="col-xs-2 ">
		<a onclick="uncheckAll();">Reset Filters</a>
		<div id="mode" class="panel-heading">
			Display: <i id="mode-pie" class="fas fa-chart-pie fa-lg"></i> <i id="mode-bar" class="fas fa-chart-bar fa-lg text-success"></i> <i id="mode-table" class="fas fa-table fa-lg"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<div class=" panel-primary">
			<div class="panel-body">
				<h4 id="age"><i class="fas fa-chevron-right"></i> Age</h4>
				<div id="age_panel" style="display:none;">
					<sql:query var="ages" dataSource="jdbc/N3CPublic">
						select age_bin,age_abbrev from n3c_dashboard.age_map6 order by age_seq;
					</sql:query>
					<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="age_bin" value="${row.age_bin}" > ${row.age_abbrev}
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h4 id="race"><i class="fas fa-chevron-right"></i> Race</h4>
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
				<h4 id="ethnicity"><i class="fas fa-chevron-right"></i> Ethnicity</h4>
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
				<h4 id="gender"><i class="fas fa-chevron-right"></i> Sex</h4>
				<div id="gender_panel" style="display:none;">
					<sql:query var="genders" dataSource="jdbc/N3CPublic">
						select distinct gender_abbrev,gender_seq from n3c_dashboard.gender_map order by gender_seq;
					</sql:query>
					<c:forEach items="${genders.rows}" var="row" varStatus="rowCounter">
						<c:if test="${!rowCounter.first}"><br></c:if>
						<input type="checkbox" name="gender" value="${row.gender_abbrev}" > ${row.gender_abbrev}
					</c:forEach>
				</div>
			</div>
			<div class="panel-body">
				<h4 id="severity"><i class="fas fa-chevron-right"></i> Severity</h4>
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
