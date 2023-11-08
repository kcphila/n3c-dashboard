<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}comorbidity_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}comorbidity_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}comorbidity_body" aria-expanded="true" aria-controls="${param.block}comorbidity_body">
  					Comorbidity
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}comorbidity_body" class="collapse" aria-labelledby="${param.block}comorbidity_heading" data-parent="#${param.block}comorbidity_accordion">
			<div class="card-body">
				<div id="${param.block}comorbidity_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}comorbidity_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}comorbidity_panel');">None</button><br>
					<select id="${param.block}-comorbidity-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct concept_set_name as comorbidity from n3c_dashboard_ph.mh_sexvaccmor_other_csd order by 1;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.comorbidity}">${row.comorbidity}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
