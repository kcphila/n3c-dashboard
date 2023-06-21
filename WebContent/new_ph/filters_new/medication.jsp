<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}medication_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}medication_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}medication_body" aria-expanded="true" aria-controls="${param.block}medication_body">
  					Medication
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}medication_body" class="collapse" aria-labelledby="${param.block}medication_heading" data-parent="#${param.block}medication_accordion">
			<div class="card-body">
				<div id="${param.block}medication_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}medication_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}medication_panel');">None</button><br>
					<select id="${param.block}-medication-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct drug_name from n3c_dashboard_ph.Meds_CovDemoAgeMin_csd
							order by 1;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.drug_name}">${row.drug_name}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>


