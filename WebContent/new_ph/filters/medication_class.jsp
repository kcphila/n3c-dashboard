<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="panel-body">
	<h6>Medication Class</h6>
	<select id="${param.block}-medication-class-select" multiple="multiple">
		<sql:query var="cases" dataSource="jdbc/N3CPublic">
			select distinct drug_domain from n3c_questions_new.covid_patients_demographics_censored_medications order by 1;
		</sql:query>
		<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
			<option value="${row.drug_domain}">${row.drug_domain}</option>
		</c:forEach>
	</select>
</div>
