<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}alcohol_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}alcohol_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}alcohol_body" aria-expanded="true" aria-controls="${param.block}alcohol_body">
  					Alcohol Condition
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}alcohol_body" class="collapse" aria-labelledby="${param.block}alcohol_heading" data-parent="#${param.block}alcohol_accordion">
			<div class="card-body">
				<div id="${param.block}alcohol_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}alcohol_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}alcohol_panel');">None</button><br>
					<select id="${param.block}-alcohol-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct alcohol_condition from n3c_dashboard_ph.sub_covalcdemoageideal_csd order by alcohol_condition;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.alcohol_condition}">${row.alcohol_condition}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
