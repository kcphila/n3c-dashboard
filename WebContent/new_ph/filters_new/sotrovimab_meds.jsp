<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="othermeds_accordion">
 		<div class="card">
 			<div class="card-header" id="othermeds_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#othermeds_body" aria-expanded="true" aria-controls="othermeds_body">
  					Other Meds
 				</button>
				</h2>
			</div>
		</div>
		<div id="othermeds_body" class="collapse" aria-labelledby="othermeds_heading" data-parent="#othermeds_accordion">
			<div class="card-body">
				<div id="othermeds_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('othermeds_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('othermeds_panel');">None</button><br>
					<select id="${param.block}-othermeds-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct medications_abbrev, medications_seq from n3c_dashboard.medications_map order by medications_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.medications_abbrev}">${row.medications_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
