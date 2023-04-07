<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="paxlovid_accordion">
 		<div class="card">
 			<div class="card-header" id="paxlovid_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#paxlovid_body" aria-expanded="true" aria-controls="paxlovid_body">
  					Paxlovid Status
 				</button>
				</h2>
			</div>
		</div>
		<div id="paxlovid_body" class="collapse" aria-labelledby="paxlovid_heading" data-parent="#paxlovid_accordion">
			<div class="card-body">
				<div id="paxlovid_panel">
					<select id="${param.block}-paxlovidstatus-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct pax_abbrev, pax_seq from n3c_dashboard.pax_map order by pax_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.pax_abbrev}">${row.pax_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>

