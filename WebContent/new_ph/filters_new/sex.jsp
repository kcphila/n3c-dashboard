<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

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
					<select id="${param.block}-sex-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct gender_abbrev as sex_abbrev,gender_seq as sex_seq from n3c_dashboard.gender_map order by sex_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.sex_abbrev}">${row.sex_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
