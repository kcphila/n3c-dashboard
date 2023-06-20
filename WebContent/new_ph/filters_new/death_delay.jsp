<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}delay_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}delay_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#${param.block}delay_body" aria-expanded="true" aria-controls="${param.block}delay_body">
  					Days After Discharge
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}delay_body" class="collapse show" aria-labelledby="${param.block}delay_heading" data-parent="#${param.block}delay_accordion">
			<div class="card-body">
				<div id="${param.block}delay_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}delay_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}delay_panel');">None</button><br>
					<select id="${param.block}-delay-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct datediff_bw_death_and_hos as date, split_part(datediff_bw_death_and_hos, '-', 1)::int 
							from n3c_dashboard_ph.mor_bindiffdeathHos_csd 
							where substring(datediff_bw_death_and_hos from '^[0-9]*')::int <= 28470
							order by split_part(datediff_bw_death_and_hos, '-', 1)::int;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.date}">${row.date}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
