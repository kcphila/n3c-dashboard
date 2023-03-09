<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="diagnosis_accordion">
 		<div class="card">
 			<div class="card-header" id="diagnosis_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#diagnosis_body" aria-expanded="true" aria-controls="diagnosis_body">
  					COVID Diagnosis Type
 				</button>
				</h2>
			</div>
		</div>
		<div id="diagnosis_body" class="collapse" aria-labelledby="diagnosis_heading" data-parent="#diagnosis_accordion">
			<div class="card-body">
				<div id="diagnosis_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('diagnosis_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('diagnosis_panel');">None</button><br>
					<select id="${param.block}-diagnosis-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct diagnosis_abbrev, diagnosis_seq from n3c_dashboard.diagnosis_map order by diagnosis_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.diagnosis_abbrev}">${row.diagnosis_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
