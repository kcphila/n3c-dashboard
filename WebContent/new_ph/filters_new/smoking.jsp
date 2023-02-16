<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="smokingstatus_accordion">
 		<div class="card">
 			<div class="card-header" id="smokingstatus_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#smokingstatus_body" aria-expanded="true" aria-controls="smokingstatus_body">
  					Smoking Status
 				</button>
				</h2>
			</div>
		</div>
		<div id="smokingstatus_body" class="collapse" aria-labelledby="smokingstatus_heading" data-parent="#smokingstatus_accordion">
			<div class="card-body">
				<div id="smokingstatus_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('smokingstatus_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('smokingstatus_panel');">None</button><br>
					<select id="${param.block}-smokingstatus-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select smoking_status_abbrev, smoking_status_seq from n3c_dashboard.status_map order by smoking_status_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.smoking_status_abbrev}">${row.smoking_status_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
