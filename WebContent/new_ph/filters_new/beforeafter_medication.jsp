<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="medicationoccurrence_accordion">
 		<div class="card">
 			<div class="card-header" id="medicationoccurrence_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#medicationoccurrence_body" aria-expanded="true" aria-controls="medicationoccurrence_body">
  					Medication Occurrence
 				</button>
				</h2>
			</div>
		</div>
		<div id="medicationoccurrence_body" class="collapse" aria-labelledby="medicationoccurrence_heading" data-parent="#medicationoccurrence_accordion">
			<div class="card-body">
				<div id="medicationoccurrence_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('medicationoccurrence_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('medicationoccurrence_panel');">None</button><br>
					<select id="${param.block}-medicationoccurrence-select" multiple="multiple">
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
