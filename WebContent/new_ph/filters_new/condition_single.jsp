<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}conditions_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}conditions_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}conditions_body" aria-expanded="true" aria-controls="${param.block}conditions_body">
  					Condition
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}conditions_body" class="collapse" aria-labelledby="${param.block}conditions_heading" data-parent="#${param.block}conditions_accordion">
			<div class="card-body">
				<div id="${param.block}conditions_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}conditions_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}conditions_panel');">None</button><br>
					<select id="${param.block}-conditions-select" multiple="multiple">
						<sql:query var="conditions" dataSource="jdbc/N3CPublic">
							select condition, condition_abbrev, condition_seq from (
								select distinct(UNNEST(STRING_TO_ARRAY(list_of_conditions, ', '))) as condition
								from n3c_dashboard_ph.enclave_cms_cnt_csd
								) as foo
							natural join n3c_dashboard.maternal_map
							order by condition_seq;
						</sql:query>
						<c:forEach items="${conditions.rows}" var="row" varStatus="rowCounter">
							<option value="${row.condition}">${row.condition_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>


