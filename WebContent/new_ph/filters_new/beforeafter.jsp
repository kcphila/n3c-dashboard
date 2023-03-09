<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<div class="accordion" id="symptomoccurrence_accordion">
 		<div class="card">
 			<div class="card-header" id="symptomoccurrence_heading">
				<h2 class="mb-0">
				<button class="filter_drop_button btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#symptomoccurrence_body" aria-expanded="true" aria-controls="symptomoccurrence_body">
  					Condition Relative to COVID+
 				</button>
				</h2>
			</div>
		</div>
		<div id="symptomoccurrence_body" class="collapse" aria-labelledby="symptomoccurrence_heading" data-parent="#symptomoccurrence_accordion">
			<div class="card-body">
				<div id="symptomoccurrence_panel">
					<button class="btn btn-light btn-sm" onclick="selectall('symptomoccurrence_panel');">All</button>
					<button class="btn btn-light btn-sm" onclick="deselect('symptomoccurrence_panel');">None</button><br>
					<select id="${param.block}-symptomoccurrence-select" multiple="multiple">
						<sql:query var="cases" dataSource="jdbc/N3CPublic">
							select distinct(case
								when (condition_after_covid_positive) then 'After COVID+'
								else 'Before COVID+'
								end) as condition from n3c_questions_new.symptom_before_or_after_covid;
						</sql:query>
						<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
							<option value="${row.condition}">${row.condition}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
	</div>
</div>
