<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="numberofcomorbidities_accordion">
 		<div class="card">
 			<div class="card-header" id="numberofcomorbidities_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#numberofcomorbidities_body" aria-expanded="true" aria-controls="numberofcomorbidities_body">
  					# of Comorbidities
 				</button>
				</h2>
			</div>
		</div>
		<div id="numberofcomorbidities_body" class="collapse" aria-labelledby="numberofcomorbidities_heading" data-parent="#numberofcomorbidities_accordion">
			<div class="card-body">
				<div id="numberofcomorbidities_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('numberofcomorbidities_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('numberofcomorbidities_panel');">None</button><br>
					<select id="${param.block}-numberofcomorbidities-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct comorbidity_abbrev, comorbidity_seq from n3c_dashboard.comorbidity_number_map order by comorbidity_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.comorbidity_abbrev}">${row.comorbidity_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
