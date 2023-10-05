<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}opioid_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}opioid_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}opioid_body" aria-expanded="true" aria-controls="${param.block}opioid_body">
  					Opioids
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}opioid_body" class="collapse" aria-labelledby="${param.block}opioid_heading" data-parent="#${param.block}opioid_accordion">
			<div class="card-body">
				<div id="${param.block}opioid_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}opioid_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}opioid_panel');">None</button><br>
					<select id="${param.block}-opioid-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct opioids from n3c_dashboard_ph.sub_covopidemoageideal_csd order by opioids;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.opioids}">${row.opioids}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
