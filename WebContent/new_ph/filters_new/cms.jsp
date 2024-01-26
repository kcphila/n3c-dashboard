<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="${param.block}cms_accordion">
 		<div class="card">
 			<div class="card-header" id="${param.block}cms_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#${param.block}cms_body" aria-expanded="true" aria-controls="${param.block}cms_body">
  					CMS Type
 				</button>
				</h2>
			</div>
		</div>
		<div id="${param.block}cms_body" class="collapse" aria-labelledby="${param.block}cms_heading" data-parent="#${param.block}cms_accordion">
			<div class="card-body">
				<div id="${param.block}cms_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('${param.block}cms_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('${param.block}cms_panel');">None</button><br>
					<select id="${param.block}-cms-select" multiple="multiple">
						<option value="Medicaid">Medicaid</option>
						<option value="Medicare">Medicare</option>
						<option value="None">None</option>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
