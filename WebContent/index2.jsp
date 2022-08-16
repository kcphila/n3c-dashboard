<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" flush="true" />
<style>
.wrapper div {
  background-color: #aaa;
}

.outer{
  width:100%;
  height:120px;
  white-space: nowrap;
  position: relative;
  overflow-x:scroll;
  overflow-y:hidden;
}

.outer div{
  width: 24.5%;
  background-color: black;
  color: yellow;
  float: none;
  height: 90%;
  margin: 0 0.25%;
  display: inline-block;
  zoom: 1;
}

.inner div{
  white-space: wrap;
}
p {
    word-break: break-word;
    white-space: normal;
}
</style>
<body>
	<jsp:include page="navbar.jsp" flush="true" />

	<div class="wrapper">
	<sql:query var="topics" dataSource="jdbc/N3CPublic">
		select question,substring(description from 1 for 80)||'...' as description from n3c_questions.roster where question ~ 'Summary' and visible order by seqnum
	</sql:query>
	<h2>Summary Data</h2>
	<div class="outer">
		<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
			<div class="inner">
				<h4>${row.question}</h4>
				<p>${row.description}</p>
			</div>
		</c:forEach>
		${row.jsonb_pretty}
	</div>

	<sql:query var="topics" dataSource="jdbc/N3CPublic">
		select question,substring(description from 1 for 80)||'...' as description from n3c_questions.roster where question ~ 'Medication' and visible order by seqnum
	</sql:query>
	<h2>Medications</h2>
	<div class="outer">
		<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
			<div class="inner">
				<h4>${row.question}</h4>
				<p>${row.description}</p>
			</div>
		</c:forEach>
		${row.jsonb_pretty}
	</div>

	<sql:query var="topics" dataSource="jdbc/N3CPublic">
		select question,substring(description from 1 for 80)||'...' as description from n3c_questions.roster where question ~ 'Disease' and visible order by seqnum
	</sql:query>
	<h2>Other Disease</h2>
	<div class="outer">
		<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
			<div class="inner">
				<h4>${row.question}</h4>
				<p>${row.description}</p>
			</div>
		</c:forEach>
		${row.jsonb_pretty}
	</div>

	<sql:query var="topics" dataSource="jdbc/N3CPublic">
		select question,substring(description from 1 for 80)||'...' as description from n3c_questions.roster where question !~ 'Summary' and question !~ 'Medication' and question !~ 'Disease' and visible order by seqnum
	</sql:query>
	<h2>Other Aspects</h2>
	<div class="outer">
		<c:forEach items="${topics.rows}" var="row" varStatus="rowCounter">
			<div class="inner">
				<h4>${row.question}</h4>
				<p>${row.description}</p>
			</div>
		</c:forEach>
		${row.jsonb_pretty}
	</div>
	</div>

	<jsp:include page="footer.jsp" flush="true" />
</body>
</html>
