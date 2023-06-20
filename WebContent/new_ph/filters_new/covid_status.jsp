<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="covidstatus_accordion">
 		<div class="card">
 			<div class="card-header" id="covidstatus_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#covidstatus_body" aria-expanded="true" aria-controls="covidstatus_body">
  					COVID Status
 				</button>
				</h2>
			</div>
		</div>
		<div id="covidstatus_body" class="collapse" aria-labelledby="covidstatus_heading" data-parent="#covidstatus_accordion">
			<div class="card-body">
				<div id="covidstatus_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('covidstatus_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('covidstatus_panel');">None</button><br>
					<select id="${param.block}-covidstatus-select" multiple="multiple">
						<option value="Positive">Positive</option>
						<option value="Unknown">Unknown</option>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
