<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

 <sql:query var="totals" dataSource="jdbc/N3CPublic">
  	select to_char(sum(count::int)/1000.0, '999.99')||'K' count from n3c_questions_new.all_tests_month_cohort_reinfection_time_series where count!='<20';
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="col-12 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td>Total Patients Reinfected</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> <span id="${param.block}_actual_count_kpi">${row.count}</span></div>
			</div>
		</div>
	</div>
</c:forEach>
