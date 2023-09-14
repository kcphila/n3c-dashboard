<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}cannabisstatus_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}cannabisstatus_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}cannabisstatus_body" aria-expanded="true" aria-controls="${param.block}cannabisstatus_body">
  					Cannabis Status
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}cannabisstatus_body" class="collapse" aria-labelledby="${param.block}cannabisstatus_heading" data-parent="#${param.block}cannabisstatus_accordion">
			<div class="card-body">
				<div id="${param.block}cannabisstatus_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}cannabisstatus_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}cannabisstatus_panel');">None</button><br>
					<select id="${param.block}-cannabisstatus-select" multiple="multiple">
						<option value="Positive">Positive</option>
						<option value="Unknown">Unknown</option>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
