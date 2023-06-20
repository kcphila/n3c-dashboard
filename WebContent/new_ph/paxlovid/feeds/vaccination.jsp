<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by vaccination, paxlovid_seq))
	from (
		select CONCAT(vaccination::text, ' Vaccine Doses before COVID Diagnosis') as vaccination, pax_abbrev as paxlovid, patient_display::text, patient_count, CONCAT(vaccination::text, ' Vaccine Doses') as vaccination_abbrev, vaccination as vaccination_seq, pax_abbrev as paxlovid_abbrev, pax_seq as paxlovid_seq
			from (select
				number_of_covid_vaccine_doses_before_or_day_of_covid as vaccination,
				covid_w_pax,
				count as patient_display,
				case
					when (count::text = '<20' or count is null) then 0
					else count::int
					end as patient_count
				from n3c_dashboard_ph.pax_vacc_csd
			) as foo
			join n3c_dashboard.pax_map on covid_w_pax = n3c_dashboard.pax_map.pax
	) as done;
</sql:query>
{
    "headers": [
        {"value":"vaccination", "label":"Vaccination Doses"},
        {"value":"paxlovid", "label":"Paxlovid Status"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"vaccination_abbrev", "label":"dummy1"},
        {"value":"vaccination_seq", "label":"dummy2"},
        {"value":"paxlovid_abbrev", "label":"dummy3"},
        {"value":"paxlovid_seq", "label":"dummy4"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
        ${row.jsonb_pretty}
</c:forEach>
}
