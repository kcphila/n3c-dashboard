<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}medication-class_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}medication-class_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}medication-class_body" aria-expanded="true" aria-controls="${param.block}medication-class_body">
  					Medication Class
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}medication-class_body" class="collapse" aria-labelledby="${param.block}medication-class_heading" data-parent="#${param.block}medication-class_accordion">
			<div class="card-body">
				<div id="${param.block}medication-class_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}medication-class_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}medication-class_panel');">None</button><br>
					<select id="${param.block}-medication-class-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct drug_domain from n3c_dashboard.drug_map order by 1;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.drug_domain}">${row.drug_domain}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>

