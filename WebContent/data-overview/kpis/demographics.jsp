<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<span class="tip">
	<a class="viz_secondary_info" 
		title="<a href='#' class='close' data-dismiss='alert'>&times;</a> Total Patients in View" 
		data-html="true" 
		data-toggle="popover" 
		data-placement="top" 
		data-content="<p><strong>Sample:</strong> All Patients in the N3C Data Enclave</p>
			<small class='kpi-small-note'>Note: Even without filters, this total may be less than the total number of 
			patients within the Enclave due to the suppression of counts less than 20.</small>" 
		aria-describedby="tooltip">
		<p style="white-space:nowrap;">Total Patients in View <i class="fas fa-info-circle" aria-hidden="true"></i></p>
	</a>
</span>
<sql:query var="totals" dataSource="jdbc/N3CPublic">
	select to_char(value::int/1000000.0, '999.99')||'M' as count 
	from (
		select sum(case when (patient_count = '<20' or patient_count is null) then 0 else patient_count::numeric end) as value 
		from n3c_dashboard_ph.demo_demo_mort_sev_vacc_all_covid_csd
	) y;
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="kpi_num"><i class="fas fa-users" aria-hidden="true"></i> <span id='count_kpi'>${row.count}</span></div>
</c:forEach>
	<div class="progress" id="demographics_patient_count_kpi_progressdiv" data-toggle="tooltip" data-placement="top" title="" data-original-title="100% in View" aria-hidden="true">
  		<div id="demographics_patient_count_kpi_progress" class="progress-bar" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 100% !important"></div>
	</div>
	
<script>
$('#demographics_patient_count_kpi_progressdiv').tooltip();
</script>