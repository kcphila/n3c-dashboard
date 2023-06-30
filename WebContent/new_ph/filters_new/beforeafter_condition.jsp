<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="conditionoccurrence_accordion">
 		<div class="card">
 			<div class="card-header" id="conditionoccurrence_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#conditionoccurrence_body" aria-expanded="true" aria-controls="conditionoccurrence_body">
  					Condition Occurrence
 				</button>
				</h2>
			</div>
		</div>
		<div id="conditionoccurrence_body" class="collapse" aria-labelledby="conditionoccurrence_heading" data-parent="#conditionoccurrence_accordion">
			<div class="card-body">
				<div id="conditionoccurrence_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('conditionoccurrence_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('conditionoccurrence_panel');">None</button><br>
					<select id="${param.block}-conditionoccurrence-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select medocc_abbrev from n3c_dashboard.medocc_map order by medocc_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.medocc_abbrev}">${row.medocc_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
