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
						when (count::text = '<20' or count is null) then 0
						else count::int
					end as count
				  from n3c_questions_new.postpax_hospitalization
				  where covid_w_pax = 1
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
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total Patients Prescribed Paxlovid in View" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="
										<p>Total Number of COVID+ Individuals within the N3C Data Enclave who have Paxlovid 
										indicated in their EHR within five days of their COVID Diagnosis and who had a recorded hospitalization after their COVID diagnosis.</p>
										<p> Anyone that received Paxlovid 
										before their COVID diagnosis or after the recommended 5-day period would be excluded. Additionally, 
										anyone who received Paxlovid but did not have a COVID diagnosis recorded within the Enclave would be 
										excluded. </p>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">Total Paxlovid Patients in View* <i class="fas fa-info-circle"></i>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-prescription-bottle-alt"></i> <span id="${param.block}_paxlovid_kpi">${row.count}</span></div>
			</div>
		</div>
	</div>
</c:forEach>
