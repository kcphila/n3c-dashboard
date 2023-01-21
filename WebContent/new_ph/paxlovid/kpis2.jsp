<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<div class="row">
	<sql:query var="totals" dataSource="jdbc/N3CPublic">
		select to_char(value::int/1000000.0, '999.99')||'M' as count from n3c_admin.enclave_stats where title='covid_positive_patients';
	</sql:query>
	<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
		<div class="col-12 col-sm-4 kpi-main-col">
			<div class="panel-primary kpi">
				<div class="kpi-inner">
					<div class="panel-body">
						<table>
							<tr>
								<td><span class="tip">
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
 								</span></td>
							</tr>
						</table>
					</div>
					<div class="panel-heading kpi_num"><i class="fas fa-user-plus"></i> ${row.count}</div>
				</div>
			</div>
		</div>
	</c:forEach>
	<sql:query var="totals" dataSource="jdbc/N3CPublic">
		select
			to_char(count, '999,999') as count,
			(select to_char(substring(value from '[a-zA-Z]*-v[0-9]*-(.*)')::date, 'Month FMDD, YYYY') as value
			 from n3c_admin.enclave_stats where title='release_name') as date,
			(select substring(value from '[a-zA-Z]*-v([0-9]*)-.*') as value
			 from n3c_admin.enclave_stats where title='release_name') as build
		from n3c_questions.drug_count_summary where drug_name='PAXLOVID';
	</sql:query>
	<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
		<div class="col-12 col-sm-4 kpi-main-col">
			<div class="panel-primary kpi">
				<div class="kpi-inner">
					<div class="panel-body">
						<table>
							<tr>
								<td><span class="tip">
									<a class="viz_secondary_info" 
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> Total # of Patients Taking Paxlovid in the Enclave" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="Count is <strong>current</strong> as of ${row.date} (Release Build ${row.build})" 
										aria-describedby="tooltip">
	 										<p style="margin-bottom:0px;">Total # of Patients Taking Paxlovid <i class="fas fa-info-circle"></i>
	  											<span class="sr-only">in the N3C Data Enclave: count is <strong>current</strong> as of ${row.date} (Release Build ${row.build})</span>
	 										</p> 
 									</a>
 								</span></td>
							</tr>
						</table>
					</div>
					<div class="panel-heading kpi_num"><i class="fas fa-users" aria-hidden="true"></i> ${row.count}</div>
				<p style="text-align: center"><i>Count is current as of ${row.date} (Release Build ${row.build}).</i></p>
				</div>
			</div>
		</div>
 	</c:forEach>
 <sql:query var="totals" dataSource="jdbc/N3CPublic">
 	select to_char(sum(count)/1000.0, '999.99')||'k' as patient_count
 	from (select 
			case
				when (ptct = '<20' or ptct is null) then 0
				else ptct::int
			end as count
			from n3c_questions.persons_with_visits) as foo
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="col-12 col-sm-4 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
								<td><span class="tip">
									<a class="viz_secondary_info" 
										title="<a class='close popover_close' data-dismiss='alert'>&times;</a> # of Patients Taking Paxlovid w/Subsequent Visit in Current View" 
										data-html="true" data-toggle="popover" 
										data-placement="top" 
										data-content="The data in this view is from an extract of patients prescribed Paxlovid who had subsequent visits within 27 days performed on July 22, 2022." 
										aria-describedby="tooltip">
	 										<p style="margin-bottom:0px;">Patients in View <i class="fas fa-info-circle"></i>
	  											<span class="sr-only">: count is from data extracted July 22, 2022.</span>
	 										</p> 
 									</a>
 								</span></td>
							</tr>
					</table>
				</div>
				<div id="${param.block}_patient_count_kpi" class="panel-heading kpi_num"><i class="fas fa-users" aria-hidden="true"></i> ${row.patient_count}</div>
			<p style="text-align: center"><i>Count is from data extracted July 22, 2022.</i></p>
			</div>
		</div>
	</div>
</c:forEach>
</div>
<div class="row">
	<div class="col-12 mx-auto mt-2 mb-2 text-center">
		<p>All data shown occurred between the first day after the end of the 5-day course of Paxlovid (i.e., day 6 post-Paxlovid) and three weeks following (i.e., day 27 post-Paxlovid).</p>
	</div>
</div>


<script>
//popover stuff
$(function () {
	$('[data-toggle="popover"]').popover()
});
$(document).on("click", ".popover .close" , function(){
    $(this).parents(".popover").popover('hide');
});
</script>
