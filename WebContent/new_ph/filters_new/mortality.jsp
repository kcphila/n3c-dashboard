<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}mortality_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}mortality_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}mortality_body" aria-expanded="true" aria-controls="${param.block}mortality_body">
  					Mortality Status
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}mortality_body" class="collapse" aria-labelledby="${param.block}mortality_heading" data-parent="#${param.block}mortality_accordion">
			<div class="card-body">
				<div id="${param.block}mortality_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}mortality_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}mortality_panel');">None</button><br>
					<select id="${param.block}-mortality-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct mortality_abbrev, mortality_seq from n3c_dashboard.mortality_map order by mortality_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.mortality_abbrev}">${row.mortality_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
