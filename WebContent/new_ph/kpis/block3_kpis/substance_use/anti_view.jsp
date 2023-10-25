<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="totals" dataSource="jdbc/N3CPublic">
	select sum(patient_count) as count
			from (
				select
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.sub_alceth_csd
				union
				select
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.sub_alcrac_csd
				union 
				select
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.sub_alcsex_csd
				union 
				select
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.sub_covopiagemin_csd
		  	) as foo
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
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total Patients with an Anti-Opioid Intervention" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="
										<p>Total Number of Individuals within the view with an anti-opioid intervention 
										indicated in their EHR.</p>
										<small class='kpi-small-note'>Even without filters, this total may be less than the total number of patients with a substance use event within the Enclave due to the suppression of counts less than 20.</small>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">Total Patients in View* <i class="fas fa-info-circle"></i>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> <span id="${param.block}_patient_count_kpi">${row.count}</span></div>
				<div class="progress" id="${param.block}_patient_count_kpi_progressdiv" data-toggle="tooltip" data-placement="top" title="" data-original-title="100% in View" aria-hidden="true">
  					<div id="${param.block}_patient_count_kpi_progress" class="progress-bar" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 100% !important"></div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>

<script>
$('#${param.block}_patient_count_kpi_progressdiv').tooltip();
</script>