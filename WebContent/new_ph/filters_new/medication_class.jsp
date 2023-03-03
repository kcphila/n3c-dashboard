<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="medication-class_accordion">
 		<div class="card">
 			<div class="card-header" id="medication-class_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#medication-class_body" aria-expanded="true" aria-controls="medication-class_body">
  					Medication Class
 				</button>
				</h2>
			</div>
		</div>
		<div id="medication-class_body" class="collapse" aria-labelledby="medication-class_heading" data-parent="#medication-class_accordion">
			<div class="card-body">
				<div id="medication-class_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('medication-class_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('medication-class_panel');">None</button><br>
					<select id="${param.block}-medication-class-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct drug_domain from n3c_questions_new.covid_patients_demographics_censored_medications order by 1;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.drug_domain}">${row.drug_domain}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>

