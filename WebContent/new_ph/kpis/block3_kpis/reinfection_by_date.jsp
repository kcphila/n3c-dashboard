<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

 <sql:query var="totals" dataSource="jdbc/N3CPublic">
  	select to_char(sum(patient_count::int)/1000.0, '999.99')||'K' patient_count from n3c_dashboard_ph.reints_alltstsmonth_csd where patient_count!='<20' and subsequent_month = 2 and subsequent_year = 2022;
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="col-12 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td>Reinfected Patients Count</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> <span id="${param.block}_count_kpi">${row.patient_count}</span></div>
			</div>
		</div>
	</div>
</c:forEach>
