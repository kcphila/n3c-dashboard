<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="conditions" dataSource="jdbc/N3CPublic">
	select condition, lower(replace(condition_abbrev, ' ', '_')) as condition_abbrev, condition_seq from (
		select distinct(UNNEST(STRING_TO_ARRAY(list_of_conditions, ', '))) as condition
		from n3c_dashboard_ph.mh_conditions_more_than_one_csd
	) 
	natural join n3c_dashboard.maternal_map
	order by condition_seq;
</sql:query>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select condition, race, age, sex, cms, status, mortality, patient_display, patient_count,
				age_abbrev, age_seq, race_abbrev, race_seq,
				sex_abbrev, sex_seq, cms_abbrev, cms_seq, status_abbrev, status_seq, mortality_abbrev, mortality_seq,
				<c:forEach items="${conditions.rows}" var="row" varStatus="rowCounter">
					${row.condition_abbrev}<c:if test="${!rowCounter.last}">,</c:if>
				</c:forEach>
			from (select
					list_of_conditions as condition,
					race,
					COALESCE (age_bin, 'Unknown') as age,
					sex,
					case 
						when (cms_type is null) then 'None'
						else cms_type
					end as cms,
					case 
						when (covid_indicator = '1') then 'Positive'
						else 'Unknown'
					end as status,
					case 
						when (death_mortality_indicator = '1') then 'Mortality'
						else 'No Mortality'
					end as mortality,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count,
					<c:forEach items="${conditions.rows}" var="row" varStatus="rowCounter">
					case 
						when position('${row.condition}' in list_of_conditions)>0 then 
							case
								when (patient_count = '<20' or patient_count is null) then 0
							else patient_count::int
							end
						else 0
					end as ${row.condition_abbrev}
					<c:if test="${!rowCounter.last}">,</c:if>
					</c:forEach>
				  from n3c_dashboard_ph.mh_conditions_more_than_one_csd
		  	) as foo
		  	natural join n3c_dashboard.age_map_min
		  	natural join n3c_dashboard.race_map
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.cms_map
		  	natural join n3c_dashboard.covidstatus_map
		  	natural join n3c_dashboard.mortality_map
		  ) as done;
</sql:query>
{
    "headers": [
    	{"value":"condition", "label":"Condition"},
        {"value":"race", "label":"Race"},
        {"value":"age", "label":"Age"},
        {"value":"sex", "label":"Sex"},
        {"value":"cms", "label":"CMS Type"},
        {"value":"status", "label":"COVID Status"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
        {"value":"sex_abbrev", "label":"dummy5"},
        {"value":"sex_seq", "label":"dummy6"},
        {"value":"cms_abbrev", "label":"dummy7"},
        {"value":"cms_seq", "label":"dummy8"},
        {"value":"status_abbrev", "label":"dummy9"},
        {"value":"status_seq", "label":"dummy10"},
        {"value":"mortality_abbrev", "label":"dummy11"},
        {"value":"mortality_seq", "label":"dummy12"},
        <c:forEach items="${conditions.rows}" var="row" varStatus="rowCounter">
			{"value":"${row.condition}", "label":"conditionid.${rowCounter.count}.${row.condition}.${row.condition_abbrev}"}<c:if test="${!rowCounter.last}">,</c:if>
		</c:forEach>
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
