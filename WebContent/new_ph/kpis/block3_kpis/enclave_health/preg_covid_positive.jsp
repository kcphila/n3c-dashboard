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
				  from n3c_dashboard_ph.mh_all_patient_age_min_demographics_csd
				  where covid_indicator = 1
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
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total COVID+ Patients in View" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="
										<strong>COVID+ Defined As:</strong>
										<ul class='low-padding-list'>
											<li>Laboratory-confirmed positive COVID-19 PCR or Antigen test</li>
											<li>(or) Laboratory-confirmed positive COVID-19 Antibody test</li>
											<li>(or) Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</li>
										</ul>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">COVID+ in View* <i class="fas fa-info-circle"></i>
	  											<span class="sr-only">, or patients who have had, a laboratory-confirmed positive COVID-19 PCR or Antigen test, 
	  												a laboratory-confirmed positive COVID-19 Antibody test, or a Medical visit in which the ICD-10 code for COVID-19 
	  												(U07.1) was recorded
	  											</span>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-user-plus"></i> <span id="${param.block}_covid_patient_count_kpi">${row.count}</span></div>
			</div>
		</div>
	</div>

</c:forEach>
