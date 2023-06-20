<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="environmental_accordion">
 		<div class="card">
 			<div class="card-header" id="environmental_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#environmental_body" aria-expanded="true" aria-controls="environmental_body">
  					Environmental Factor
 				</button>
				</h2>
			</div>
		</div>
		<div id="environmental_body" class="collapse" aria-labelledby="environmental_heading" data-parent="#environmental_accordion">
			<div class="card-body">
				<div id="environmental_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('environmental_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('environmental_panel');">None</button><br>
					<select id="${param.block}-environmental-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct(environmental_factor) from n3c_dashboard_ph.env_allcnt_all_csd order by environmental_factor;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.environmental_factor}">${row.environmental_factor}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>

