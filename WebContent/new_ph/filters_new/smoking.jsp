<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}smoking_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}smoking_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}smoking_body" aria-expanded="true" aria-controls="${param.block}smoking_body">
  					Smoking Status
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}smoking_body" class="collapse" aria-labelledby="${param.block}smoking_heading" data-parent="#${param.block}smoking_accordion">
			<div class="card-body">
				<div id="${param.block}smoking_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}smoking_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}smoking_panel');">None</button><br>
					<select id="${param.block}-smoking-select" multiple="multiple">
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
