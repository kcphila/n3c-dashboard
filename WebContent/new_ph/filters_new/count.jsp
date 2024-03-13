<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}count_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}count_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}count_body" aria-expanded="true" aria-controls="${param.block}count_body">
  					Count Type
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}count_body" class="collapse" aria-labelledby="${param.block}count_heading" data-parent="#${param.block}count_accordion">
			<div class="card-body">
				<div id="${param.block}count_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}count_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}count_panel');">None</button><br>
					<select id="${param.block}-count-select" multiple="multiple">
						<sql:query var="count" dataSource="jdbc/N3CPublic">
							select count_abbrev as count, count_abbrev, count_seq
							from n3c_dashboard.count_map
							order by count_seq;
						</sql:query>
						<c:forEach items="${count.rows}" var="row" varStatus="rowCounter">
							<option value="${row.count}">${row.count}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>


