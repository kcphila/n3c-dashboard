<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

 <sql:query var="totals" dataSource="jdbc/N3CPublic">
 	select to_char(sum(num_patients)/1000.0, '999.99')||'k' as patient_count
 	from (select 
			max(total_patient_count) as num_patients
			from n3c_dashboard_ph.longcov_consetdemoagemin_csd) as foo
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
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total Long COVID Clinic Patients in the Enclave" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="
										<p>Total number of individuals within the Enclave who have had a 
										recorded medical visit to a Long COVID Specialty Clinic on or after 1/1/2019.</p>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">Total Long COVID Clinic Patients in Enclave* <i class="fas fa-info-circle"></i>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> <span id="${param.block}_patient_total_kpi">${row.patient_count}</span></div>
			</div>
		</div>
	</div>
</c:forEach>
