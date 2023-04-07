<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>


<style>
	.kpi_extract{
		text-align: center; 
		color: #AD1181;
	}
</style>

<div class="row kpi-row mt-2">
	<div class="col-12 col-md-4">
		
		<c:if test="${param.block == 'paxlovid_1' || param.block == 'paxlovid_2'}">
			<sql:query var="totals" dataSource="jdbc/N3CPublic">
			 	select to_char(sum(count)/1000.0, '999.99')||'k' as patient_count
			 	from (select 
						case
							when (ptct = '<20' or ptct is null) then 0
							else ptct::int
						end as count
						from n3c_questions.table1_union where demographic_feature='sex') as foo
			</sql:query>
			<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
				<div class="panel-primary kpi">
					<div class="kpi-inner">
						<div class="panel-body">
							<table>
								<tr>
									<td><span class="tip">
										<a class="viz_secondary_info" 
											title="<a class='close popover_close' data-dismiss='alert'>&times;</a> # of Patients Taking Paxlovid in Current View" 
											data-html="true" data-toggle="popover" 
											data-placement="top" 
											data-content="The data in this view is from an extract of patients prescribed Paxlovid performed on July 22, 2022." 
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
					<p class="kpi_extract"><i>Data is from static extract (July 22, 2022)</i></p>
					</div>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${param.block == 'paxlovid_3'}">
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
					<p class="kpi_extract"><i>Data is from static extract (July 22, 2022)</i></p>
					</div>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${param.block == 'paxlovid_8'}">
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
				<div class="panel-primary kpi" style="height:100%">
					<div class="kpi-inner m-auto">
						<div class="panel-body">
							<table>
								<tr>
									<td><span class="tip">
										<a class="viz_secondary_info" 
											title="<a class='close popover_close' data-dismiss='alert'>&times;</a> # of Patients Taking Paxlovid in Current View" 
											data-html="true" data-toggle="popover" 
											data-placement="top" 
											data-content="This data was from 14,475 patients prescribed Paxlovid at 20 healthcare systems from 15 states across the US." 
											aria-describedby="tooltip">
		 										<p style="margin-bottom:0px;">Patients in View <i class="fas fa-info-circle"></i>
		  											<span class="sr-only">: count is from data extract.</span>
		 										</p> 
	 									</a>
	 								</span></td>
								</tr>
							</table>
						</div>
						<div id="${param.block}_patient_count_kpi" class="panel-heading kpi_num"><i class="fas fa-users" aria-hidden="true"></i> 14.48k</div>
					<p class="kpi_extract"><i>Data is from static extract</i></p>
					</div>
				</div>
			</c:forEach>
		</c:if>
		
	</div>
	<div class="col-12 col-md-8 mx-auto m-auto text-max" style="font-weight: 400;">
		<c:if test="${param.block == 'paxlovid_8'}">
			<p>Paxlovid was approved for emergency use relatively recently (December 2021). In the three weeks after finishing a 
			5-day course of Paxlovid, only 838 of these 14,475 patients sought COVID-related care post-Paxlovid, and only 
			100 tested SARS-CoV-2 positive in a clinical setting. The hospitalization rate post-Paxlovid is also extremely low. 
			This data was from 14,475 patients prescribed Paxlovid at 20 healthcare systems from 15 states across the US.</p>
		</c:if>
		<p>All data shown occurred between the first day after the end of the 5-day course of Paxlovid 
		(i.e., day 6 post-Paxlovid) and three weeks following (i.e., day 27 post-Paxlovid).</p>
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