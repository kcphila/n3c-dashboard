<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select *
			from (
				(select
					opioids,
					patient_count as patient_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as patient_count
				  from n3c_dashboard_ph.sub_opi_csd
				) as bar0
				natural left outer join
				(select
					opioids,
					patient_count as naltrexone_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as naltrexone_count
				  from n3c_dashboard_ph.sub_alceth_csd
				) as bar1
				natural left outer join 
				(select
					opioids,
					patient_count as methadone_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as methadone_count
				  from n3c_dashboard_ph.sub_alcrac_csd
				) as bar2
				natural left outer join 
				(select
					opioids,
					patient_count as buprenorphine_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as buprenorphine_count
				  from n3c_dashboard_ph.sub_alcsex_csd
				) as bar3
				natural left outer join 
				(select
					opioids,
					patient_count as naloxone_display,
					case
						when (patient_count = '<20' or patient_count is null) then 0
						else patient_count::int
					end as naloxone_count
				  from n3c_dashboard_ph.sub_covopiagemin_csd
				) as bar4
		  	) as foo
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"opioids", "label":"Opioid"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"dummy0"},
        {"value":"naltrexone_display", "label":"Naltrexone"},
        {"value":"naltrexone_count", "label":"dummy1"},
        {"value":"methadone_display", "label":"Methadone"},
        {"value":"methadone_count", "label":"dummy2"},
        {"value":"buprenorphine_display", "label":"Buprenorphine"},
        {"value":"buprenorphine_count", "label":"dummy3"},
        {"value":"naloxone_display", "label":"Naloxone"},
        {"value":"naloxone_count", "label":"dummy4"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}