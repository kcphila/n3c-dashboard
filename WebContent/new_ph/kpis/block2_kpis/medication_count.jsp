<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="totals" dataSource="jdbc/N3CPublic">
 	select count(distinct medication) from n3c_dashboard.medication_map;
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="col-12 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td>Medication Count *</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><span id="${param.block}_medication_count_kpi">${row.count}</span></div>
			</div>
		</div>
	</div>
</c:forEach>