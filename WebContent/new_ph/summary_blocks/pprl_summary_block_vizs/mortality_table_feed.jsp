<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
		from (select
			'Mortalities' as variable_type,
			ehr_death_table,
			(pprl_3_source_mortality_and_death + aditional_cms_not_in_mort_death) as pprl_3_source_mortality_and_death,
			total_mort - (additional_in_pprl + aditional_cms_not_in_mort_death) as common_cnt,
			(additional_in_pprl + aditional_cms_not_in_mort_death) as additional_in_pprl,
			(additional_in_pprl + aditional_cms_not_in_mort_death) as additional_in_pprl_download,
			total_mort as viz_total,
			total_mort as total,
			round((((additional_in_pprl + aditional_cms_not_in_mort_death)/total_mort::numeric)*100),2) as percentage_increase
		  from n3c_dashboard_ph.mor_all_cnt
		  where type = 'All Patient in EHR'
	) as done;
</sql:query>
{
    "headers": [
        {"value":"variable_type", "label":"Record Type"},
        {"value":"ehr_death_table", "label":"<i class='fas fa-square'>&nbsp;</i> Total EHR"},
        {"value":"pprl_3_source_mortality_and_death", "label":"Total PPRL Mortalities"},
        {"value":"common_cnt", "label":"Duplicates"},
        {"value":"additional_in_pprl", "label":"<i class='fas fa-square'>&nbsp;</i> PPRL Mortality Enhancement"},
        {"value":"additional_in_pprl_download", "label":"PPRL Mortality Enhancement"},
        {"value":"viz_total", "label":"Total Data"},
        {"value":"total", "label":"Total (#)"},
        {"value":"percentage_increase", "label":"% Total"}
    ],
    "rows" : 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
 