<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="vaccinationstatus_accordion">
 		<div class="card">
 			<div class="card-header" id="vaccinationstatus_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#vaccinationstatus_body" aria-expanded="true" aria-controls="vaccinationstatus_body">
  					Vaccination Status
 				</button>
				</h2>
			</div>
		</div>
		<div id="vaccinationstatus_body" class="collapse" aria-labelledby="vaccinationstatus_heading" data-parent="#vaccinationstatus_accordion">
			<div class="card-body">
				<div id="vaccinationstatus_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('vaccinationstatus_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('vaccinationstatus_panel');">None</button><br>
					<select id="${param.block}-vaccinationstatus-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct vaccinated_abbrev, vaccinated_seq from n3c_dashboard.vaccinated_map order by vaccinated_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.vaccinated_abbrev}">${row.vaccinated_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
