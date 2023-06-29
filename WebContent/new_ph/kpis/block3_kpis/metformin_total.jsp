<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="totals" dataSource="jdbc/N3CPublic">
	select
		to_char(sum(patient_count::int), '999,999,999') as count,
		(select to_char(substring(value from '[a-zA-Z]*-v[0-9]*-(.*)')::date, 'Month FMDD, YYYY') as value
		 from n3c_admin.enclave_stats where title='release_name') as date,
		(select substring(value from '[a-zA-Z]*-v([0-9]*)-.*') as value
		 from n3c_admin.enclave_stats where title='release_name') as build
	from n3c_dashboard_ph.Meds_eth_csd where medication_names='Metformin' group by medication_names;
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
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total Patients Prescribed Metformin in Enclave" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="
										<p>Total Number of Individuals within the N3C Data Enclave who have Metformin indicated in their EHR </p>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">Total Metformin Patients in Enclave <i class="fas fa-info-circle"></i>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-prescription-bottle-alt"></i> ${row.count}</div>
				<div class="progress">
  					<div class="progress-bar w-75" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>
