<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by var, paxlovid_seq))
	from (
		
		select 'age' as cat, age as var, pax_abbrev as paxlovid, patient_display::text, patient_count, age_abbrev as var_abbrev, age_seq as var_seq, pax_abbrev as paxlovid_abbrev, pax_seq as paxlovid_seq, group_total
			from (select
				age_at_covid_binned as age,
				covid_w_pax,
				count as patient_display,
				case
					when (count::text = '<20' or count is null) then 0
					else count::int
					end as patient_count
				from n3c_questions_new.age
			) as foo
			natural join n3c_dashboard.age_map_pax
			join n3c_dashboard.pax_map on covid_w_pax = n3c_dashboard.pax_map.pax
			natural join (
				select age_at_covid_binned as age, sum(case
					when (count::text = '<20' or count is null) then 0
					else count::int
					end) as group_total
				from n3c_questions_new.age group by age_at_covid_binned
			) as far
		
		union 
		
		select 'sex' as cat, sex_abbrev as var, pax_abbrev as paxlovid, patient_display, patient_count, sex_abbrev as var_abbrev, sex_seq as var_seq, pax_abbrev as paxlovid_abbrev, pax_seq as paxlovid_seq, group_total
			from (
				select 
					sex_map_pax.sex_abbrev as sex,
					sex_map_pax.sex_abbrev, 
					sex_map_pax.sex_seq as sex_seq, 
					covid_w_pax, 
					sum(patient_count) as patient_count, 
					case
						when (sum(patient_count) = 0) then '<20'
						else sum(patient_count)::text
					end as patient_display 
				from(
					select
						sex,
						covid_w_pax,
						count as patient_display,
						case
							when (count::text = '<20' or count is null) then 0
							else count::int
							end as patient_count
					from n3c_questions_new.sex_1
				) as foo 
				natural join n3c_dashboard.sex_map_pax
				group by n3c_dashboard.sex_map_pax.sex_abbrev, covid_w_pax, sex_map_pax.sex_seq
			) as foo
			join n3c_dashboard.pax_map on covid_w_pax = n3c_dashboard.pax_map.pax
			natural join (
				select sex_abbrev, sum(case
					when (count::text = '<20' or count is null) then 0
					else count::int
					end) as group_total
				from n3c_questions_new.sex_1 
				natural join n3c_dashboard.sex_map_pax
				group by n3c_dashboard.sex_map_pax.sex_abbrev
			) as bar
			
		union 
		
		select 'race' as cat, race_ethnicity as var, pax_abbrev as paxlovid, patient_display::text, patient_count, race_abbrev as var_abbrev, race_seq as var_seq, pax_abbrev as paxlovid_abbrev, pax_seq as paxlovid_seq, group_total
			from (select
				race_ethnicity,
				covid_w_pax,
				count as patient_display,
				case
					when (count::text = '<20' or count is null) then 0
					else count::int
					end as patient_count
				from n3c_questions_new.ethnicity
			) as foo
			join n3c_dashboard.race_map_pax on n3c_dashboard.race_map_pax.race = race_ethnicity
			join n3c_dashboard.pax_map on covid_w_pax = n3c_dashboard.pax_map.pax
			natural join (
				select race_ethnicity as race, sum(case
					when (count::text = '<20' or count is null) then 0
					else count::int
					end) as group_total
				from n3c_questions_new.ethnicity group by race_ethnicity
			) as far
	
	) as done;
</sql:query>
{
    "headers": [
    	{"value":"cat", "label":"Category"},
        {"value":"var", "label":"Variable"},
        {"value":"paxlovid", "label":"Paxlovid"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"var_abbrev", "label":"dummy1"},
        {"value":"var_seq", "label":"dummy2"},
        {"value":"paxlovid_abbrev", "label":"dummy3"},
        {"value":"paxlovid_seq", "label":"dummy4"},
        {"value":"group_total", "label":"dummy4"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
</c:forEach>
}
