<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="drugs" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by month))
	from (
		(select month,coalesce(actual_count, 0) as column1 from
			(select distinct month from n3c_dashboard.month) as bar
			natural left outer join
			(select
				drug_name as medication,
				exposure_year||'-'||to_char(exposure_month, 'FM00') as month,
				count_per_month as count,
				case
					when (count_per_month = '<20' or count_per_month is null) then 0
					else count_per_month::int
				end as actual_count
			from n3c_questions.drug_monthly_count_summary where drug_name='PAXLOVID') as foo
			) as col1
			natural join
		(select month,coalesce(actual_count, 0) as column2 from
			(select distinct month from n3c_dashboard.month) as bar
			natural left outer join
			(select
				drug_name as medication,
				exposure_year||'-'||to_char(exposure_month, 'FM00') as month,
				count_per_month as count,
				case
					when (count_per_month = '<20' or count_per_month is null) then 0
					else count_per_month::int
				end as actual_count
			from n3c_questions.drug_monthly_count_summary where drug_name='REMDESIVIR') as foo
			) as col2
			natural join
		(select month,coalesce(actual_count, 0) as column3 from
			(select distinct month from n3c_dashboard.month) as bar
			natural left outer join
			(select
				drug_name as medication,
				exposure_year||'-'||to_char(exposure_month, 'FM00') as month,
				count_per_month as count,
				case
					when (count_per_month = '<20' or count_per_month is null) then 0
					else count_per_month::int
				end as actual_count
			from n3c_questions.drug_monthly_count_summary where drug_name='SOTROVIMAB') as foo
			) as col3
			natural join
		(select month,coalesce(actual_count, 0) as column4 from
			(select distinct month from n3c_dashboard.month) as bar
			natural left outer join
			(select
				drug_name as medication,
				exposure_year||'-'||to_char(exposure_month, 'FM00') as month,
				count_per_month as count,
				case
					when (count_per_month = '<20' or count_per_month is null) then 0
					else count_per_month::int
				end as actual_count
			from n3c_questions.drug_monthly_count_summary where drug_name='LAGEVRIO') as foo
			) as col4
	) as done;
</sql:query>
<c:forEach items="${drugs.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
	