<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="totals" dataSource="jdbc/N3CPublic">
 	select 
 		case
 			when count_ethnicity_unknown < 1000 then count_ethnicity_unknown::text
 			when count_ethnicity_unknown < 1000000 then to_char(count_ethnicity_unknown/1000.0, '999.99')||'k'
 			else to_char(count_ethnicity_unknown/1000000.0, '999.99')||'M'
 		end as count from (
    	select
    	sum(case when (count_ethnicity_unknown = '<20') then 0 else COALESCE(count_ethnicity_unknown::int, 0) end) as count_ethnicity_unknown
    	from n3c_questions.person_agg_demographic_censored
	) as foo;
</sql:query>
<c:forEach items="${totals.rows}" var="row" varStatus="rowCounter">
	<div class="col-12 kpi-main-col">
		<div class="panel-primary kpi">
			<div class="kpi-inner">
				<div class="panel-body">
					<table>
						<tr>
							<td>Total Patients of Uknown Ethnicity</td>
						</tr>
					</table>
				</div>
				<div class="panel-heading kpi_num"><i class="fas fa-users"></i> <span id="${param.block}_count_ethnicity_unknown_kpi">${row.count}</span></div>
			</div>
		</div>
	</div>
</c:forEach>
