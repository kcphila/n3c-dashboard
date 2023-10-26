<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}anti_opioid_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}anti_opioid_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}anti_opioid_body" aria-expanded="true" aria-controls="${param.block}anti_opioid_body">
  					Anti-Opioids
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}anti_opioid_body" class="collapse" aria-labelledby="${param.block}anti_opioid_heading" data-parent="#${param.block}anti_opioid_accordion">
			<div class="card-body">
				<div id="${param.block}anti_opioid_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}anti_opioid_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}anti_opioid_panel');">None</button><br>
					<select id="${param.block}-anti-opioid-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select secondary,lower(secondary)||'_count' as value from n3c_dashboard.anti_opioid_map order by secondary;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.value}">${row.secondary}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
