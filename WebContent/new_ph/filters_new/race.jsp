<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="race_accordion">
 		<div class="card">
 			<div class="card-header" id="race_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#race_body" aria-expanded="true" aria-controls="race_body">
  					Race
 				</button>
				</h2>
			</div>
		</div>
		<div id="race_body" class="collapse" aria-labelledby="race_heading" data-parent="#race_accordion">
			<div class="card-body">
				<div id="race_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('race_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('race_panel');">None</button><br>
					<select id="${param.block}-race-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select race,race_abbrev from n3c_dashboard.race_map order by race_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.race}">${row.race_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
