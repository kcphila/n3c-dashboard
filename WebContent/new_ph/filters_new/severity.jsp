<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

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
				<div id="severityselect_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('severityselect_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('severityselect_panel');">None</button><br>
					<select id="${param.block}-severity-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select severity,severity_abbrev from n3c_dashboard.severity_map order by severity_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.severity_abbrev}">${row.severity_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>

