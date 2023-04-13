<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by cci_seq, paxlovid_seq))
	from (
		select cci_as_of_index_binned as cci, pax_abbrev as paxlovid, patient_display::text, patient_count, cci_abbrev, cci_seq, pax_abbrev as paxlovid_abbrev, pax_seq as paxlovid_seq
			from (select
				cci_as_of_index_binned,
				covid_w_pax,
				count as patient_display,
				case
					when (count::text = '<20' or count is null) then 0
					else count::int
					end as patient_count
				from n3c_questions_new.cci
			) as foo
			join n3c_dashboard.pax_map on covid_w_pax = n3c_dashboard.pax_map.pax
			join n3c_dashboard.cci_map_pax on cci_as_of_index_binned = n3c_dashboard.cci_map_pax.cci
	) as done;
</sql:query>
{
    "headers": [
        {"value":"cci", "label":"CCI"},
        {"value":"paxlovid", "label":"Paxlovid Status"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"cci_abbrev", "label":"dummy1"},
        {"value":"cci_seq", "label":"dummy2"},
        {"value":"paxlovid_abbrev", "label":"dummy3"},
        {"value":"paxlovid_seq", "label":"dummy4"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
</c:forEach>
}
