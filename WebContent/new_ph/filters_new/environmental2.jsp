<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}environmental_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}environmental_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}environmental_body" aria-expanded="true" aria-controls="${param.block}environmental_body">
  					Environmental Factor
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}environmental_body" class="collapse" aria-labelledby="${param.block}environmental_heading" data-parent="#${param.block}environmental_accordion">
			<div class="card-body">
				<div id="${param.block}environmental_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}environmental_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}environmental_panel');">None</button><br>
					<select id="${param.block}-environmental-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct(env_factor) from n3c_dashboard_ph.env_mortcnt_cov_csd
							where env_factor is not null 
							and patient_count != '<20' 
							order by env_factor;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.env_factor}">${row.env_factor}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>

