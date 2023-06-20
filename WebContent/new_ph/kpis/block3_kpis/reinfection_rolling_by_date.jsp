<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

 <sql:query var="totals" dataSource="jdbc/N3CPublic">
  	select to_char(max(seven_day_rolling_avg)/1000.0, '999.99')||'K' patient_count from
	(select
		 	to_char(initial_month,'FM00')||'/'||initial_year as initial_infection,
		 	to_char(subsequent_month, 'FM00')||'/'||subsequent_year as subsequent_infection,
		 	case
				when (patient_count = '<20') then 0
				else patient_count::int
			end as patient_count,
		 	initial_year||'-'||to_char(initial_month,'FM00') as initial,
		 	subsequent_year||'-'||to_char(subsequent_month, 'FM00') as subsequent
		 from n3c_dashboard_ph.reints_alltstsmonth_csd
		 ) as foo
		 natural join
		(select
			to_char(first_diagnosis_date::date, 'yyyy-mm') as initial,
			max(seven_day_rolling_avg) as seven_day_rolling_avg
		from n3c_questions_new.positive_cases_by_day_cumsum_censored
		group by 1
		) as bar
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="col-12 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td>Seven Day Rolling Average - Monthly Max Count</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> <span id="${param.block}_reinfected_rolling_by_date_kpi">${row.patient_count}</span></div>
			</div>
		</div>
	</div>
</c:forEach>
