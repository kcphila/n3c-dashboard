<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="testresult_accordion">
 		<div class="card">
 			<div class="card-header" id="testresult_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#testresult_body" aria-expanded="true" aria-controls="testresult_body">
  					Test Result
 				</button>
				</h2>
			</div>
		</div>
		<div id="testresult_body" class="collapse" aria-labelledby="testresult_heading" data-parent="#testresult_accordion">
			<div class="card-body">
				<div id="testresult_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('testresult_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('testresult_panel');">None</button><br>
					<select id="${param.block}-testresult-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct result_abbrev, result_seq from n3c_dashboard.result_map order by result_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.result_abbrev}">${row.result_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>

