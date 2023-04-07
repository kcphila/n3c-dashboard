<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

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
	<div class="col-12 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td>Total Patients on Paxlovid in Enclave</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> ${row.count}</div>
			</div>
		</div>
	</div>
</c:forEach>
