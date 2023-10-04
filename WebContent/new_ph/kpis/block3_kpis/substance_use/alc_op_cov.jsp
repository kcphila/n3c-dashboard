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
						when (covid_count::text = '<20' or covid_count::text is null) then 0
						else covid_count::int
					end as count
				  from n3c_dashboard_ph.substance_alc_opi_combined
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
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total COVID+ Patients with both an Alcohol-Related Condition and Opioid Use in View" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="
										<p>Total Number of COVID+ Individuals within the view who have both an alcohol-related condition and an opioid
										indicated in their EHR.</p>
										<small class='kpi-small-note'>Even without filters, this total may be less than the total number of COVID+ patients with both an alcohol-related condition and opioid use within the Enclave due to the suppression of counts less than 20.</small>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">COVID+ Patients in View* <i class="fas fa-info-circle"></i>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-user-plus"></i> <span id="${param.block}_patient_count_kpi">${row.count}</span></div>
			</div>
		</div>
	</div>
</c:forEach>
