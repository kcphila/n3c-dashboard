<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="medications_accordion">
 		<div class="card">
 			<div class="card-header" id="medications_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#medications_body" aria-expanded="true" aria-controls="medications_body">
  					Medications
 				</button>
				</h2>
			</div>
		</div>
		<div id="medications_body" class="collapse" aria-labelledby="medications_heading" data-parent="#medications_accordion">
			<div class="card-body">
				<div id="medications_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('medications_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('medications_panel');">None</button><br>
					<select id="${param.block}-medications-select" multiple="multiple">
					<sql:query var="cases" dataSource="jdbc/N3CPublic">
						select distinct drug_name as medication from  n3c_dashboard_ph.medtimeser_drug_monthcnt_csd
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