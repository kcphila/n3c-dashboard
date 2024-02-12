<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}condition_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}condition_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}condition_body" aria-expanded="true" aria-controls="${param.block}condition_body">
  					Condition
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}condition_body" class="collapse" aria-labelledby="${param.block}condition_heading" data-parent="#${param.block}condition_accordion">
			<div class="card-body">
				<div id="${param.block}condition_panel">
					<small>Note: Select a single option to see all patients with that condition. Each additional selection will only show patients with that specific combination.</small><br>
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}condition_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}condition_panel');">None</button><br>
					<select id="${param.block}-condition-select" multiple="multiple">
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


