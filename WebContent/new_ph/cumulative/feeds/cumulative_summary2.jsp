<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select *, count_non_hispanic_female + count_non_hispanic_male + count_non_hispanic_other + count_non_hispanic_unknown + count_hispanic_female + count_hispanic_male + count_hispanic_other + count_hispanic_unknown + count_ethnicity_unknown_female + count_ethnicity_unknown_male + count_ethnicity_unknown_other + count_ethnicity_unknown_unknown as total
		from(
		    select 
		        race,
		        COALESCE(MAX(count_non_hispanic) FILTER (WHERE sex = 'Female'), 0) AS count_non_hispanic_female,
		        COALESCE(MAX(count_non_hispanic) FILTER (WHERE sex = 'Male'), 0) AS count_non_hispanic_male,
		        COALESCE(MAX(count_non_hispanic) FILTER (WHERE sex = 'Other'), 0) AS count_non_hispanic_other,
		        COALESCE(MAX(count_non_hispanic) FILTER (WHERE sex = 'Unknown'), 0) AS count_non_hispanic_unknown,
		        COALESCE(MAX(count_hispanic) FILTER (WHERE sex = 'Female'), 0) AS count_hispanic_female,
		        COALESCE(MAX(count_hispanic) FILTER (WHERE sex = 'Male'), 0) AS count_hispanic_male,
		        COALESCE(MAX(count_hispanic) FILTER (WHERE sex = 'Other'), 0) AS count_hispanic_other,
		        COALESCE(MAX(count_hispanic) FILTER (WHERE sex = 'Unknown'), 0) AS count_hispanic_unknown,
		        COALESCE(MAX(count_ethnicity_unknown) FILTER (WHERE sex = 'Female'), 0) AS count_ethnicity_unknown_female,
		        COALESCE(MAX(count_ethnicity_unknown) FILTER (WHERE sex = 'Male'), 0) AS count_ethnicity_unknown_male,
		        COALESCE(MAX(count_ethnicity_unknown) FILTER (WHERE sex = 'Other'), 0) AS count_ethnicity_unknown_other,
		        COALESCE(MAX(count_ethnicity_unknown) FILTER (WHERE sex = 'Unknown'), 0) AS count_ethnicity_unknown_unknown
		    from(
		            select 
		            race,
		            case when (count_non_hispanic = '<20') then 0 else COALESCE(count_non_hispanic::int, 0) end as count_non_hispanic,  
		            case when (count_hispanic = '<20') then 0 else COALESCE(count_hispanic::int, 0) end as count_hispanic, 
		            case when (count_ethnicity_unknown = '<20') then 0 else COALESCE(count_ethnicity_unknown::int,0) end as count_ethnicity_unknown, 
		            sex
		            from n3c_dashboard_ph.demoirb_demo_csd
		            order by sex
		    ) as foo
		    group by race
		) as foo2
	) as done;
</sql:query>
{
    "headers": [
        {"value":"race", "label":"Race"},
        {"value":"count_non_hispanic_female", "label":"Non-Hispanic or Latino Female"},
        {"value":"count_non_hispanic_male", "label":"Non-Hispanic or Latino Male"},
        {"value":"count_non_hispanic_other", "label":"Non-Hispanic or Latino Other"},
        {"value":"count_non_hispanic_unknown", "label":"Non-Hispanic or Latino Uknown"},
        {"value":"count_hispanic_female", "label":"Hispanic or Latino Female"},
        {"value":"count_hispanic_male", "label":"Hispanic or Latino Male"},
        {"value":"count_hispanic_other", "label":"Hispanic or Latino Other"},
        {"value":"count_hispanic_uknown", "label":"Hispanic or Latino Uknown"},
        {"value":"count_ethnicity_unknown_female", "label":"Unknown/Not Reported Female"},
        {"value":"count_ethnicity_unknown_male", "label":"Unknown/Not Reported Male"},
        {"value":"count_ethnicity_unknown_other", "label":"Unknown/Not Reported Other"},
        {"value":"count_ethnicity_unknown_unknown", "label":"Unknown/Not Reported Uknown"},
        {"value":"total", "label":"Total"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
