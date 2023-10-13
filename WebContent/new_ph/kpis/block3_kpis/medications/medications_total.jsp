<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="totals" dataSource="jdbc/N3CPublic">
	select 
	case
 		when max(total_patient_count) < 1000 then max(total_patient_count)::text
 		when max(total_patient_count) < 1000000 then to_char(max(total_patient_count)/1000.0, '999.99')||'k'
 		else to_char(max(total_patient_count)/1000000.0, '999.99')||'M'
 	end as count
	from n3c_dashboard_ph.meds_covdemoagemin_csd;
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
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total Patients taking Select Medications" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="Patients in the N3C Data Enclave who have had a medical visit on or after 1/1/2019 in which a name and/or code associated with any of the medications of interest was recorded. " aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">Total Patients taking Select Medications <i class="fas fa-info-circle"></i>
	  											<span class="sr-only">in the N3C Data Enclave
	  											</span>
	 											</p> 
 									</a>
 								</span>
 							</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-user-plus"></i> ${row.count}</div>
			</div>
		</div>
	</div>

</c:forEach>

<script>
//popover stuff
$(function () {
	$('[data-toggle="popover"]').popover()
});
$(document).on("click", ".popover .close" , function(){
    $(this).parents(".popover").popover('hide');
});
</script>