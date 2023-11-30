<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<div class="row" id="question-limits">
	<sql:query var="questions" dataSource="jdbc/N3CPublic">
		select limitations from n3c_dashboard.dashboard where did = 56
		</sql:query>
	<c:forEach items="${questions.rows}" var="row" varStatus="rowCounter">
		<div id="limitations-section" class="col col-12">
			<div class="accordion limitations_drop" id="limitations_drop">
				<div class="card">
					<a Title="expand/collapse limitations section" href="" class="accordion-toggle" data-toggle="collapse" data-target="#limitcollapseOne" aria-expanded="false" aria-controls="collapseOne">
						<div class="card-header" id="limitheadingOne">
							<h4 class="mb-0"><span class="accordion_text">Limitations</span>
								<span style="display:inline; float:right;" class="btn btn-link btn-block text-left collapsed icon-btn p-0 accordion-toggle"></span>
							</h4>
						</div>
					</a>
					<div id="limitcollapseOne" class="collapse" aria-labelledby="limitheadingOne" data-parent="#limitations_drop">
						<div class="card-body">
							${row.limitations}
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</div>