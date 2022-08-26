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
								<td><i class="fas fa-user-plus"></i> COVID+ Patients*</td>
							</tr>
						</table>
					</div>
					<div class="panel-heading kpi_num">${row.count}</div>
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
								<td><i class="fas fa-users"></i> # of Patients Taking Paxlovid</td>
							</tr>
						</table>
					</div>
					<div class="panel-heading kpi_num">${row.count}</div>
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
							<td><i class="fas fa-users"></i> Filtered Patients with Visits</td>
						</tr>
					</table>
				</div>
				<div id="${param.block}_patient_count_kpi" class="panel-heading kpi_num">${row.patient_count}</div>
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
