<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

 <sql:query var="totals" dataSource="jdbc/N3CPublic">
 	select 
 	case
 		when sum(num_patients) < 1000 then sum(num_patients)::text
 		when sum(num_patients) < 1000000 then to_char(sum(num_patients)/1000.0, '999.99')||'k'
 		else to_char(sum(num_patients)/1000000.0, '999.99')||'M'
 	end as patient_count
 	from (select 
			case
				when (patient_count = '<20' or patient_count is null) then 0
				else patient_count::int
			end as num_patients
			from n3c_dashboard_ph.mor_bindiffdeathHos_csd) as foo
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">

	<div class="col-12 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td>
								<span class="tip">
									<a class="viz_secondary_info" 
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total Mortalities After COVID-related Hospitalization Discharge in View" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="
										<p>Total number of individuals within the view who have mortality 
										indicated in their EHR after a COVID-related hospitalization discharge.</p>
										<small class='kpi-small-note'>Even without filters, this total may be less than the total number of mortalities after a COVID-related hopsitalization discharge within the Enclave due to the suppression of counts less than 20.</small>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">Total Patients in View* <i class="fas fa-info-circle"></i>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> <span id="${param.block}_patient_count_kpi">${row.patient_count}</span></div>
				<div class="progress" id="${param.block}_patient_count_kpi_progressdiv" data-toggle="tooltip" data-placement="top" title="" data-original-title="100% in View" aria-hidden="true">
  					<div id="${param.block}_patient_count_kpi_progress" class="progress-bar" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100% !important"></div>
				</div>
			</div>
		</div>
	</div>

</c:forEach>

<script>
	$('#${param.block}_patient_count_kpi_progressdiv').tooltip();
</script>