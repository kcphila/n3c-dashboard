<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="conditions" dataSource="jdbc/N3CPublic">
	select condition, lower(replace(condition_abbrev, ' ', '_')) as condition_abbrev, condition_seq from (
		select distinct(UNNEST(STRING_TO_ARRAY(list_of_conditions, ', '))) as condition
		from n3c_dashboard_ph.enclave_cms_cnt_csd
	) 
	natural join n3c_dashboard.maternal_map
	order by condition_seq;
</sql:query>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select condition, sex, severity, vaccinated, status, long, mortality, patient_display, patient_count,
				sex_abbrev, sex_seq, severity_abbrev, severity_seq, vaccinated_abbrev, vaccinated_seq, status_abbrev, 
				status_seq, long_abbrev, long_seq, mortality_abbrev, mortality_seq, 
				<c:forEach items="${conditions.rows}" var="row" varStatus="rowCounter">
					${row.condition_abbrev}<c:if test="${!rowCounter.last}">,</c:if>
				</c:forEach>
			from (select
					list_of_conditions as condition,
					sex_altered as sex,
					severity,
					case 
						when (vaccinated = '1') then 'Vaccinated'
						else 'Unknown'
					end as vaccinated,
					case 
						when (covid_indicator = '1') then 'Positive'
						else 'Unknown'
					end as status,
					case 
						when (long_covid_indicator = '1') then 'Long COVID'
						else 'Unknown'
					end as long,
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
				  from n3c_dashboard_ph.enclave_cms_cnt_csd
		  	) as foo
		  	natural join n3c_dashboard.sex_map
		  	natural join n3c_dashboard.sev_map
		  	natural join n3c_dashboard.vaccinated_map
		  	natural join n3c_dashboard.covidstatus_map
		  	natural join n3c_dashboard.longstatus_map
		  	natural join n3c_dashboard.mortality_map
		  ) as done;
</sql:query>
{
    "headers": [
    	{"value":"condition", "label":"Condition"},
        {"value":"sex", "label":"Sex"},
        {"value":"severity", "label":"Severity"},
        {"value":"vaccinated", "label":"Vaccinated"},
        {"value":"status", "label":"COVID Status"},
        {"value":"long", "label":"Long COVID Status"},
        {"value":"mortality", "label":"Mortality"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"sex_abbrev", "label":"dummy5"},
        {"value":"sex_seq", "label":"dummy6"},
        {"value":"severity_abbrev", "label":"dummy7"},
        {"value":"severity_seq", "label":"dummy8"},
        {"value":"vaccinated_abbrev", "label":"dummy9"},
        {"value":"vqccinated_seq", "label":"dummy10"},
        {"value":"status_abbrev", "label":"dummy11"},
        {"value":"status_seq", "label":"dummy12"},
        {"value":"long_abbrev", "label":"dummy13"},
        {"value":"long_seq", "label":"dummy14"},
        {"value":"mortality_abbrev", "label":"dummy15"},
        {"value":"mortality_seq", "label":"dummy16"},
        <c:forEach items="${conditions.rows}" var="row" varStatus="rowCounter">
			{"value":"${row.condition}", "label":"conditionid.${rowCounter.count}.${row.condition}.${row.condition_abbrev}"}<c:if test="${!rowCounter.last}">,</c:if>
		</c:forEach>
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
