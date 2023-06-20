<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (
		select race, ethnicity, sex, patient_display,
        case
            when (patient_display = '<20') then 0
            else patient_display::int
        end as patient_count,
        race_seq, race_abbrev, ethnicity_seq, ethnicity_abbrev, sex_seq, sex_abbrev
        from(
            select race, 'Not Hispanic or Latino' as ethnicity, sex, count_non_hispanic as patient_display
            from n3c_dashboard_ph.demoirb_demo_csd  
            UNION
            select race, 'Hispanic or Latino' as ethnicity,  sex, count_hispanic as patient_display
            from n3c_dashboard_ph.demoirb_demo_csd      
            UNION
            select race, 'Unknown' as ethnicity, sex, count_ethnicity_unknown as patient_display
            from n3c_dashboard_ph.demoirb_demo_csd
            order by race, ethnicity
        ) as foo
        natural join n3c_dashboard.race_map
        natural join n3c_dashboard.eth_map
        natural join n3c_dashboard.sex_map
	) as done;
</sql:query>
{
    "headers": [
        {"value":"race", "label":"Race"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"sex", "label":"Sex"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient Actual"},
        {"value":"race_seq", "label":"dummy1"},
        {"value":"race_abbrev", "label":"dummy2"},
        {"value":"ethnicity_seq", "label":"dummy3"},
        {"value":"ethnicity_abbrev", "label":"dummy4"},
        {"value":"sex_seq", "label":"dummy5"},
        {"value":"sex_abbrev", "label":"dummy6"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
