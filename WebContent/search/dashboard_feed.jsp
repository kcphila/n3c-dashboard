<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select
			did as dashboard_id,
			title as dashboard_name,
			blurb as dashboard_short_desc,
			path as dashboard_url,
			thumbnail_path as image,
			coalesce((select string_agg(tag, ', ') from n3c_dashboard.tag_definition natural join n3c_dashboard.dashboard_tag where dashboard_tag.did = dashboard.did),'') as tags,
			coalesce((select string_agg(type, ', ') from n3c_dashboard.type_definition natural join n3c_dashboard.dashboard_type where dashboard_type.did = dashboard.did),'') as type
		  from n3c_dashboard.dashboard
		  where did != 53 and did !=54
		    and active
		  order by did
		  ) as done;
</sql:query>
{
	"headers": [ 
	  {"value":"dashboard_id", "label":"dummy1"}, 
	  {"value":"tags", "label":"dummy2"}, 
	  {"value":"dashboard_name", "label":"Dashboard"}, 
	  {"value":"dashboard_url", "label":"dummy3"},
	  {"value":"dashboard_short_desc", "label":"About"},
	  {"value":"image", "label":"dummy3"},
	  {"value":"type", "label":"dummy4"}
	],
    "rows" : 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			