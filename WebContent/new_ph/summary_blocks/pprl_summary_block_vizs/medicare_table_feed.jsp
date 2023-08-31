<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
		from (select
			variable_type,
			avg_in_ehr,
			avg_cms,
			common_cnt,
			additional_in_cms,
			additional_in_cms as additional_in_cms_download,
			total_avg as viz_total_avg,
			total_avg,
			(select max(total_avg) from n3c_dashboard_ph.cms_avg_counts_all where cms_type = 'Medicare') as max_total_avg,
			round(percentage_increase::numeric,2) as percentage_increase
		  from n3c_dashboard_ph.cms_avg_counts_all
		  where cms_type = 'Medicare'
	) as done;
</sql:query>
{
    "headers": [
        {"value":"variable_type", "label":"Record Type"},
        {"value":"avg_in_ehr", "label":"<i class='fas fa-square'>&nbsp;</i> Avg EHR"},
        {"value":"avg_cms", "label":"Avg Medicare"},
        {"value":"common_cnt", "label":"Avg Duplicates"},
        {"value":"additional_in_cms", "label":"<i class='fas fa-square'>&nbsp;</i> Avg Medicare Enhancement"},
        {"value":"additional_in_cms_download", "label":"Avg Medicare Enhancement"},
        {"value":"viz_total_avg", "label":"Total Data"},
        {"value":"total_avg", "label":"Total (#)"},
        {"value":"max_total_avg", "label":"dummy"},
        {"value":"percentage_increase", "label":"% Total"}
    ],
    "rows" : 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
 