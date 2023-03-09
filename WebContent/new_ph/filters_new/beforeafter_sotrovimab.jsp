<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="sotrovimaboccurrence_accordion">
 		<div class="card">
 			<div class="card-header" id="sotrovimaboccurrence_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#sotrovimaboccurrence_body" aria-expanded="true" aria-controls="sotrovimaboccurrence_body">
  					Sotrovimab Occurrence
 				</button>
				</h2>
			</div>
		</div>
		<div id="sotrovimaboccurrence_body" class="collapse" aria-labelledby="sotrovimaboccurrence_heading" data-parent="#sotrovimaboccurrence_accordion">
			<div class="card-body">
				<div id="sotrovimaboccurrence_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('sotrovimaboccurrence_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('sotrovimaboccurrence_panel');">None</button><br>
					<select id="${param.block}-sotrovimaboccurrence-select" multiple="multiple">
						<option value="Before Other Med">Before Other Med</option>
						<option value="After Other Med">After Other Med</option>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
