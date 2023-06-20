<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<div class="secondary-description">
	<p><strong>Sample:</strong> <span class="tip">
		<a class="viz_secondary_info" title="COVID+ Defined As: <a class='close popover_close' data-dismiss='alert'>&times;</a>" data-html="true" data-toggle="popover" data-placement="top" data-content="<ul style='padding-inline-start: 15px;'><li>Laboratory-confirmed positive COVID-19 PCR or Antigen test</li></li></ul>" aria-describedby="tooltip">
			<u style="white-space:nowrap;">COVID+ patients <i class="fa fa-info" aria-hidden="true"></i></u> 
			<span class="sr-only">, or patients who have had a laboratory-confirmed positive COVID-19 PCR or Antigen test</span>
		</a>
		</span>&nbsp;in the N3C Data Enclave.
		<sql:query var="cases" dataSource="jdbc/N3CPublic">
			select
				to_char(c_date::date, 'FMMM/FMDD/YY') as date,
				to_char(first_diagnosis_count::int,'999,999') as first_diagnosis,
				to_char(subsequent_test_count::int, '999,999') as subsequent
			from n3c_dashboard_ph.rein_covdatecounts_csd where c_date ='2021-09-06'
		</sql:query>
		<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
			This graph shows the daily COVID+ cases within the Enclave broken down into first diagnoses and reinfections.
			For example, on ${row.date}, the data shows ${row.first_diagnosis} patients received their first positive test, and 
			${row.subsequent} patients experienced reinfections.
		</c:forEach>
		The definition of a reinfected patient is any patient who had more than one positive PCR or Antigen test 60 days or more apart. 
		For additional information, <a onclick="${param.block}limitlink(); return false;" href="#limitations-section">see limitations below</a>.
	</p>
	<em>Hover over the graph to show the counts for that day. Click and drag to focus on a specific time range. Double click to revert to the
		default time range.</em>
</div>