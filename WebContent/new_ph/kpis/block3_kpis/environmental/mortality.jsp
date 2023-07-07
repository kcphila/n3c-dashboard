<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

	
<sql:query var="totals" dataSource="jdbc/N3CPublic">
	select 
 		case
 			when sum(count) < 1000 then sum(count)::text
 			when sum(count) < 1000000 then to_char(sum(count)/1000.0, '999.99')||'k'
 			else to_char(sum(count)/1000000.0, '999.99')||'M'
 		end as count
			from (select
					case
						when (patient_count::text = '<20' or patient_count::text is null) then 0
						else patient_count::int
					end as count
				  from n3c_dashboard_ph.env_envsxmortvac_all_csd
				  where covid_patient_death_indicator = '1'
				) as foo;
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
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total Mortalities in View" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="<strong>Mortality Defined As:</strong>
										<ul class='low-padding-list'>
											<li>Any patient with a date of death in the Enclave</li>
											<li>(or) Any patient from a mortality-linked PPRL site who exists in one 
											of the external sources (ex., Government data with death certificates, ObituaryData.com, and obituary data from private sources)</li>
										</ul>
										<small class='kpi-small-note'>Note: this metric is distinct from the Mortality category associated with Severity, 
										as it does not limit deaths to only those suspected to be caused by COVID-19.</small>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">Mortalities in View* <i class="fas fa-info-circle"></i>
	  											<span class="sr-only">, or any patient with a date of death in the Enclave, or Any patient from a mortality-linked PPRL site who exists in 
													of the external sources
	  											</span>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-user"></i> <span id="${param.block}_mortality_patient_count_kpi">${row.count}</span></div>
			</div>
		</div>
	</div>

</c:forEach>