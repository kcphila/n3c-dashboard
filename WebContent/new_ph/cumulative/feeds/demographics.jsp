<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select race, ethnicity, gender_abbrev as gender, patient_display,
        case
            when (patient_display = '<20') then 0
            else patient_display::int
        end as patient_count,
        race_seq, race_abbrev, ethnicity_seq, ethnicity_abbrev, gender_seq, gender_abbrev
        from(
            select race, 'Not Hispanic or Latino' as ethnicity, gender_concept_name as gender, COALESCE(count_non_hispanic, '<20') as patient_display
            from n3c_questions.person_agg_demographic_censored
            UNION
            select race, 'Hispanic or Latino' as ethnicity, gender_concept_name as gender, COALESCE(count_hispanic, '<20') as patient_display
            from n3c_questions.person_agg_demographic_censored    
            UNION
            select race, 'Missing/Unknown' as ethnicity, gender_concept_name as gender, COALESCE(count_ethnicity_unknown, '<20') as patient_display
            from n3c_questions.person_agg_demographic_censored
            order by race, ethnicity
        ) as foo
        natural join n3c_dashboard.race_map
        natural join n3c_dashboard.ethnicity_map
        natural join n3c_dashboard.gender_map2
	) as done;
</sql:query>
{
    "headers": [
        {"value":"race", "label":"Race"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"gender", "label":"Gender"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient Actual"},
        {"value":"race_seq", "label":"dummy1"},
        {"value":"race_abbrev", "label":"dummy2"},
        {"value":"ethnicity_seq", "label":"dummy3"},
        {"value":"ethnicity_abbrev", "label":"dummy4"},
        {"value":"gender_seq", "label":"dummy5"},
        {"value":"gender_abbrev", "label":"dummy6"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
