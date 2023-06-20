<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}age_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}age_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}age_body" aria-expanded="true" aria-controls="${param.block}age_body">
  					Age
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}age_body" class="collapse" aria-labelledby="${param.block}age_heading" data-parent="#${param.block}age_accordion">
			<div class="card-body">
				<div id="${param.block}age_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}age_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}age_panel');">None</button><br>
					<button class="btn btn-light btn-sm" onclick="checkPeds();">Peds</button>
					<button class="btn btn-light btn-sm" onclick="checkAdult();">Adult</button><br>
					<select id="${param.block}-age-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select age, age_abbrev from n3c_dashboard.age_map_ideal order by age_seq;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.age}">${row.age_abbrev}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
	function checkPeds() {
		$('input[type="checkbox"][value="<18"]').prop('checked',true).trigger('change');

		$('input[type="checkbox"][value="18-64"]').prop('checked',false).trigger('change');
		$('input[type="checkbox"][value="65+"]').prop('checked', false).trigger('change');
		$('input[type="checkbox"][value="Unknown"]').prop('checked', false).trigger('change');
	};

	function checkAdult() {
		$('input[type="checkbox"][value="<18"]').prop('checked',false).trigger('change');
		$('input[type="checkbox"][value="Unknown"]').prop('checked', false).trigger('change');

		$('input[type="checkbox"][value="18-64"]').prop('checked',true).trigger('change');
		$('input[type="checkbox"][value="65+"]').prop('checked', true).trigger('change');
	};
</script>