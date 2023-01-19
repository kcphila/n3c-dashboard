<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="totals" dataSource="jdbc/N3CPublic">
	select to_char(value::int/1000000.0, '999.99')||'M' as count from n3c_admin.enclave_stats where title='covid_positive_patients';
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
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total COVID+ Patients in the N3C Data Enclave" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="<strong>COVID+ Defined As:</strong>
										<ul style='padding-inline-start: 15px;'>
											<li>Laboratory-confirmed positive COVID-19 PCR or Antigen test</li>
											<li>(or) Laboratory-confirmed positive COVID-19 Antibody test</li>
											<li>(or) Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</li>
										</ul>" aria-describedby="tooltip">
	 											<p style="margin-bottom:0px;">Total COVID+ Patients <i class="fas fa-info-circle"></i>
	  											<span class="sr-only">in the N3C Data Enclave, or patients who have had, a laboratory-confirmed positive COVID-19 PCR or Antigen test, 
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
				<div class="panel-heading kpi_num"><i class="fas fa-user-plus"></i> ${row.count}</div>
			</div>
		</div>
	</div>
	<sql:query var="totals" dataSource="jdbc/N3CPublic">
		select split_part(substring(value, '-(.+)'), '-', 1) as release,  to_char(TO_DATE(substring(value, '[\w]*-[\w]*-(.*)'), 'YYYY/MM/DD'), 'Mon DD, YYYY') as date from n3c_admin.enclave_stats where title='release_name';
	</sql:query>
	<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
		<p class="data-as-of"><em>Data as of ${row.date} (${row.release})</em></p>
	</c:forEach>
	<div class="kpi-limit"><a onclick="limitlink(); return false;" href="#limitations-section">* See Limitations Below</a></div>
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