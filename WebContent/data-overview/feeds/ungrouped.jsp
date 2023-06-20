<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="severity" dataSource="jdbc/N3CPublic">
SELECT jsonb_pretty(jsonb_agg(done.*)) AS jsonb_pretty
   FROM ( SELECT severity_abbrev as severity,
            sex_map.sex_abbrev AS sex,
            age_map_ideal.age AS age,
            race_map.race_abbrev as race,
            ethnicity,
            foo.comorbidity,
            foo.patient_display,
            foo.patient_count,
            age_map_ideal.age_abbrev,
            age_map_ideal.age_seq,
            race_map.race_abbrev,
            race_map.race_seq,
            eth_map.ethnicity_abbrev,
            eth_map.ethnicity_seq,
            sex_abbrev,
            sex_seq,
            sev_map.severity_abbrev,
            sev_map.severity_seq
           FROM ( SELECT n3c_dashboard_ph.demo_ungrouped_cci_cov_csd.severity AS severity,
                    race,
                    ethnicity,
                    regexp_replace( n3c_dashboard_ph.demo_ungrouped_cci_cov_csd.comorbidity_name, 'Charlson - '::text, ''::text, 'g'::text) AS comorbidity,
                    COALESCE(n3c_dashboard_ph.demo_ungrouped_cci_cov_csd.age, 'Unknown'::text) AS age,
                    n3c_dashboard_ph.demo_ungrouped_cci_cov_csd.sex,
                    n3c_dashboard_ph.demo_ungrouped_cci_cov_csd.patient_count AS patient_display,
                        CASE
                            WHEN n3c_dashboard_ph.demo_ungrouped_cci_cov_csd.patient_count = '<20'::text OR n3c_dashboard_ph.demo_ungrouped_cci_cov_csd.patient_count IS NULL THEN 0
                            ELSE n3c_dashboard_ph.demo_ungrouped_cci_cov_csd.patient_count::integer
                        END AS patient_count
                   FROM n3c_dashboard_ph.demo_ungrouped_cci_cov_csd ) foo
             JOIN n3c_dashboard.age_map_ideal USING (age)
             JOIN n3c_dashboard.race_map USING (race)
             JOIN n3c_dashboard.eth_map USING (ethnicity)
             JOIN n3c_dashboard.sex_map USING (sex)
             JOIN n3c_dashboard.sev_map USING (severity)) done;
</sql:query>
{
    "headers": [
        {"value":"severity", "label":"Severity"},
        {"value":"sex", "label":"Sex"},
        {"value":"age", "label":"Age"},
        {"value":"race", "label":"Race"},
        {"value":"ethnicity", "label":"Ethnicity"},
        {"value":"comorbidity", "label":"Comorbidity"},
        {"value":"patient_display", "label":"Patient Count"},
        {"value":"patient_count", "label":"Patient actual"},
        {"value":"age_abbrev", "label":"dummy1"},
        {"value":"age_seq", "label":"dummy2"},
        {"value":"race_abbrev", "label":"dummy3"},
        {"value":"race_seq", "label":"dummy4"},
        {"value":"ethnicity_abbrev", "label":"dummy5"},
        {"value":"ethnicity_seq", "label":"dummy6"},
        {"value":"sex_abbrev", "label":"dummy7"},
        {"value":"sex_seq", "label":"dummy8"},
        {"value":"severity_abbrev", "label":"dummy9"},
        {"value":"severity_seq", "label":"dummy0"}
    ],
    "rows" : 
<c:forEach items="${severity.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
