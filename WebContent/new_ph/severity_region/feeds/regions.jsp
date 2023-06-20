<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cases" dataSource="jdbc/N3CPublic">
select json_agg(json)
from (select divisions as region, severity, patient_count, site_count as region_seq
     from n3c_dashboard_ph.regcovcase_sev_csd
     left join(
          select count(site) as site_count, n3c_dashboard.state_map.division_name from n3c_maps.sites 
               left join ror.address on n3c_maps.sites.id = ror.address.id
               left join n3c_dashboard.state_map on n3c_dashboard.state_map.state = ror.address.state
               where status = 'available'
               group by n3c_dashboard.state_map.division_name
     ) foo 
     on n3c_dashboard_ph.regcovcase_sev_csd.divisions = foo.division_name
     where divisions != 'Multiple States'
     and divisions is not null
     order by divisions)
as json;	
</sql:query>


{
    "headers": [
        {"value":"region", "label":"Region"},
		{"value":"severity", "label":"Severity"},
        {"value":"patient_count", "label":"Count"},
        {"value":"region_seq", "label":"Providers"}
    ],
    "rows" : 
<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
	${row.json_agg}
</c:forEach>

}

