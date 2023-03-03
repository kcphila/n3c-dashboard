<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="medication_accordion">
 		<div class="card">
 			<div class="card-header" id="medication_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#medication_body" aria-expanded="true" aria-controls="medication_body">
  					Medication
 				</button>
				</h2>
			</div>
		</div>
		<div id="medication_body" class="collapse" aria-labelledby="medication_heading" data-parent="#medication_accordion">
			<div class="card-body">
				<div id="medication_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('medication_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('medication_panel');">None</button><br>
					<select id="${param.block}-medication-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct medication from n3c_dashboard.medication_map 
							where medication != 'Available, in progress'
							order by 1;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.medication}">${row.medication}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>


