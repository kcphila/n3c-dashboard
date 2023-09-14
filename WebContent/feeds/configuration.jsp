<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>


var ethnicity_range = ["#332380", "#B6AAF3", "#a6a6a6"];
var sex_range = ["#4833B2", "#ffa600", "#8406D1", "#a6a6a6"];
var age_range_min = ["#EADEF7", "#8642CE", "#33298D", "#a6a6a6"];
var age_range_ideal = ["#EADEF7", "#C9A8EB", "#A772DF", "#8642CE", "#762AC6", "#6512BD", "#4C1EA5", "#33298D", "#251a8a", "#a6a6a6"];
var race_range = ["#09405A", "#AD1181", "#8406D1", "#ffa600", "#ff7155", "#a6a6a6", "#8B8B8B"];
var status_range = ["#4833B2", "#AD1181", "#a6a6a6"];
var paxlovid_range = ["#AD1181", "#a6a6a6"];
var cci_range = ["#EBC4E0", "#C24DA1", "#AD1181", "#820D61", "#570941"];
var vaccinated_range = ["#4833B2", "#a6a6a6"];
var severity_range = ["#EBC4E0", "#C24DA1", "#AD1181", "#820D61", "#570941", "#a6a6a6"];

var sequential_1_5 = ["#D6BFD9", "#b88fbd", "#995fa0", "#6c4270", "#4D2F50"];
var categorical = ["#09405A", "#AD1181", "#8406D1", "#ffa600", "#ff7155", "#4833B2", "#a6a6a6"];

var longstatus_range = ["#4833B2", "#a6a6a6"];
var hospstatus_range = ["#4833B2", "#a6a6a6"];
var covidstatus_range = ["#4833B2", "#a6a6a6"];
var mortality_range = ["#4833B2", "#a6a6a6"];
var medicationoccurrence_range = ["#007bff", "#09405A", "#a6a6a6"];
var alcohol_range = ["#007bff", "#09405A", "#a6a6a6"];
var opioid_range = ["#007bff", "#09405A", "#a6a6a6"];
var smoking_range = ["#007bff", "#09405A", "#a6a6a6"];



var sex_range3 = ["#4833B2", "#ffa600", "#8406D1", "#a6a6a6", "#8B8B8B"];
var sex_range_no_other = ["#4833B2", "#ffa600", "#a6a6a6"];
var severity_range2 = ["#F5B1A3", "#EE765E", "#CE3617", "#A02A12", "#5C180A", "#8B8B8B", "#8B8B8B"];
var severity_range3 = ["#FFC1DC", "#F584B5", "#CE4682", "#9D285B", "#6C0934", "#8B8B8B"];
var race_range2 =  ["#3B59C7", "#AD1181", "#7602EB", "#A8F0D8", "#86CBF3", "#a6a6a6", "#8B8B8B"];
var age_range = ["#EADEF7", "#A772DF", "#6512BD", "#a6a6a6"];
var age_range_all = ["#EADEF7", "#C9A8EB", "#A772DF", "#8642CE", "#762AC6", "#6512BD", "#4C1EA5", "#33298D", "#a6a6a6"];
var age_range_all2 = ["#EADEF7", "#C9A8EB", "#A772DF", "#8642CE", "#6512BD", "#33298D", "#a6a6a6", "#8B8B8B"];
var age_range_adult1 = ["#762AC6", "#4C1EA5", "#a6a6a6",  "#8B8B8B", "#762AC6", "#4C1EA5", "#a6a6a6",  "#8B8B8B"];
var age_range_adult2 = ["#762AC6", "#6512BD", "#4C1EA5", "#33298D"];
var age_range_peds1 = ["#EADEF7", "#C9A8EB", "#A772DF", "#8642CE", "#a6a6a6", "#a6a6a6","#a6a6a6","#a6a6a6"];
var age_range_peds2 = ["#EADEF7", "#C9A8EB", "#A772DF", "#8642CE"];
var alcohol_status_range = ["#4833B2", "#a6a6a6"];
var alcohol_status_legend = [ { "secondary": "Positive", "secondary_seq": 1, "secondary_name": "Positive" }, { "secondary": "Unknown", "secondary_seq": 2, "secondary_name": "Unknown" } ];
var smoking_status_range = ["#4833B2", "#a6a6a6"];
var smoking_status_legend = [ { "secondary": "Positive", "secondary_seq": 1, "secondary_name": "Positive" }, { "secondary": "Unknown", "secondary_seq": 2, "secondary_name": "Unknown" } ];
var opioids_status_range = ["#4833B2", "#a6a6a6"];
var opioids_status_legend = [ { "secondary": "Positive", "secondary_seq": 1, "secondary_name": "Positive" }, { "secondary": "Unknown", "secondary_seq": 2, "secondary_name": "Unknown" } ];
var cannabis_status_range = ["#4833B2", "#a6a6a6"];
var cannabis_status_legend = [ { "secondary": "Positive", "secondary_seq": 1, "secondary_name": "Positive" }, { "secondary": "Unknown", "secondary_seq": 2, "secondary_name": "Unknown" } ];
var covid_status_range = ["#4833B2", "#a6a6a6"];
var covid_status_legend = [ { "secondary": "Positive", "secondary_seq": 1, "secondary_name": "Positive" }, { "secondary": "Unknown", "secondary_seq": 2, "secondary_name": "Unknown" } ];
var result_range = ["#4833B2", "#AD1181", "#a6a6a6"];
var diagnosis_range = ["#09405A", "#AD1181", "#8406D1"];

var categorical2 = ["#09405A", "#AD1181", "#8406D1", "#ffa600", "#ff7155", "#4833B2", "#a6a6a6", "#09405A", "#AD1181", "#8406D1", "#ffa600", "#ff7155", "#4833B2", "#a6a6a6", "#09405A", "#AD1181", "#8406D1", "#ffa600", "#ff7155", "#4833B2", "#a6a6a6"];
var categorical8 = ["#09405A", "#AD1181", "#8406D1", "#ffa600", "#ff7155", "#4833B2", "#007BFF", "#000000", "#a6a6a6"];
var sequential_1_2 = ["#D6BFD9", "#4D2F50"];
var sequential_1_3 = ["#D6BFD9", "#9a5fa0", "#4D2F50"];
var sequential_1_4 = ["#D6BFD9", "#ae7fb3", "#7a4c80", "#4D2F50"];

var sequential_1_6 = ["#D6BFD9", "#be98c2", "#a672ab", "#87548d", "#623d66", "#4D2F50"];
var sequential_1_7 = ["#D6BFD9", "#c29fc6", "#ae7fb3", "#9a5fa0", "#7c4c80", "#5c3960", "#4D2F50"];
var sequential_2_2 = ["#F5B1A3", "#5C180A"];
var sequential_2_3 = ["#F5B1A3", "#e63c19", "#5C180A"];
var sequential_2_4 = ["#F5B1A3", "#eb6347", "#8a240f", "#5C180A"];
var sequential_2_5 = ["#F5B1A3", "#ed765e", "#ce3617", "#a02a12", "#5C180A"];
var sequential_2_6 = ["#F5B1A3", "#eb6347", "#e63c19", "#b83014", "#8a240f", "#5C180A"];
var sequential_2_7 = ["#F5B1A3", "#ee765e", "#e94f2f", "#d03616", "#a12a11", "#8a240f", "#5C180A"];
var divergent = ["#5C180A", "#A02A12", "#CE3617", "#ED765E", "#F5B1A3", "#EFEFEF", "#D6BFD9", "#A36FAA", "#8A5590", "#6C4270", "#4D2F50"];



<sql:query var="ethnicities" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct ethnicity_abbrev as secondary, ethnicity_seq as secondary_seq, ethnicity as secondary_name
		  from n3c_dashboard.eth_map
		  ) as done;
</sql:query>
<c:forEach items="${ethnicities.rows}" var="row" varStatus="rowCounter">
	var ethnicity_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="sexes" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct gender_abbrev as secondary, gender_seq as secondary_seq, gender_abbrev as secondary_name
		  from n3c_dashboard.gender_map
		  ) as done;
</sql:query>
<c:forEach items="${sexes.rows}" var="row" varStatus="rowCounter">
	var sex_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="ages_ideal" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct age_abbrev as secondary, age_seq as secondary_seq, age as secondary_name
		  from n3c_dashboard.age_map_ideal
		  ) as done;
</sql:query>
<c:forEach items="${ages_ideal.rows}" var="row" varStatus="rowCounter">
	var age_legend_ideal = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="ages_min" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct age_abbrev as secondary, age_seq as secondary_seq, age as secondary_name
		  from n3c_dashboard.age_map_min
		  ) as done;
</sql:query>
<c:forEach items="${ages_min.rows}" var="row" varStatus="rowCounter">
	var age_legend_min = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="races" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct race_abbrev as secondary, race_seq as secondary_seq, race as secondary_name
		  from n3c_dashboard.race_map
		  ) as done;
</sql:query>
<c:forEach items="${races.rows}" var="row" varStatus="rowCounter">
	var race_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="statuses" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select smoking_status as secondary, 
		smoking_status as secondary_name, 
		smoking_status_seq as secondary_seq
		from n3c_dashboard.status_map
		order by smoking_status_seq
	) as done;
</sql:query>
<c:forEach items="${statuses.rows}" var="row" varStatus="rowCounter">
	var status_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="paxlovid" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select pax_abbrev as secondary, 
		pax_abbrev as secondary_name, 
		pax_seq as secondary_seq
		from n3c_dashboard.pax_map
		order by pax_seq
	) as done;
</sql:query>
<c:forEach items="${paxlovid.rows}" var="row" varStatus="rowCounter">
	var paxlovid_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="days" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct pax_covid_delta as secondary, pax_covid_delta as secondary_seq, CONCAT(pax_covid_delta::text, ' Day(s) Between COVID+ Diagnosis and Prescription') as secondary_name
		  from n3c_dashboard_ph.pax_paxadm_csd
		  ) as done;
</sql:query>
<c:forEach items="${days.rows}" var="row" varStatus="rowCounter">
	var days_pax_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="races" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct comorbidity_abbrev as secondary, comorbidity_seq as secondary_seq, comorbidity as secondary_name
		  from n3c_dashboard.cci_map
		  ) as done;
</sql:query>
<c:forEach items="${races.rows}" var="row" varStatus="rowCounter">
	var cci_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="statuses" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select distinct vaccinated_abbrev as secondary, vaccinated_abbrev as secondary_name, vaccinated_seq as secondary_seq
		  from n3c_dashboard.vaccinated_map order by vaccinated_seq
		  ) as done;
</sql:query>
<c:forEach items="${statuses.rows}" var="row" varStatus="rowCounter">
	var vaccinated_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="befores" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct condition_after_covid_positive as secondary, condition_after_covid_positive_seq as secondary_seq, condition_after_covid_positive as secondary_name
		  from n3c_dashboard.before_after_map
		  ) as done;
</sql:query>
<c:forEach items="${befores.rows}" var="row" varStatus="rowCounter">
	var before_after_legend = ${row.jsonb_pretty};
</c:forEach>




<sql:query var="medocc" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct medocc_abbrev as secondary, medocc_seq as secondary_seq, medocc as secondary_name
		  from n3c_dashboard.medocc_map
		  ) as done;
</sql:query>
<c:forEach items="${medocc.rows}" var="row" varStatus="rowCounter">
	var medicationoccurrence_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="mortality" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct mortality_abbrev as secondary, mortality_seq as secondary_seq, mortality as secondary_name
		  from n3c_dashboard.mortality_map
		  ) as done;
</sql:query>
<c:forEach items="${mortality.rows}" var="row" varStatus="rowCounter">
	var mortality_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="vaccinated" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct vaccinated_abbrev as secondary, vaccinated_seq as secondary_seq, vaccinated as secondary_name
		  from n3c_dashboard.vaccinated_map
		  ) as done;
</sql:query>
<c:forEach items="${vaccinated.rows}" var="row" varStatus="rowCounter">
	var vaccinated_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="longstatus" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct long_abbrev as secondary, long_seq as secondary_seq, long as secondary_name
		  from n3c_dashboard.longstatus_map
		  ) as done;
</sql:query>
<c:forEach items="${longstatus.rows}" var="row" varStatus="rowCounter">
	var longstatus_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="hospstatus" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct hosp_abbrev as secondary, hosp_seq as secondary_seq, hosp as secondary_name
		  from n3c_dashboard.hospstatus_map
		  ) as done;
</sql:query>
<c:forEach items="${hospstatus.rows}" var="row" varStatus="rowCounter">
	var hospstatus_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="covid" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct status_abbrev as secondary, status_seq as secondary_seq, status as secondary_name
		  from n3c_dashboard.covidstatus_map
		  ) as done;
</sql:query>
<c:forEach items="${covid.rows}" var="row" varStatus="rowCounter">
	var covidstatus_legend = ${row.jsonb_pretty};
</c:forEach>







<sql:query var="sexes3" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct gender_abbrev as secondary, gender_seq as secondary_seq, gender_abbrev as secondary_name
		  from n3c_dashboard.gender_map3
		  ) as done;
</sql:query>
<c:forEach items="${sexes3.rows}" var="row" varStatus="rowCounter">
	var sex_legend3 = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="severities" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct severity_abbrev as secondary, severity_seq as secondary_seq, severity_abbrev as secondary_name
		  from n3c_dashboard.severity_map
		  ) as done;
</sql:query>
<c:forEach items="${severities.rows}" var="row" varStatus="rowCounter">
	var severity_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="severities" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct severity_abbrev as secondary, severity_seq as secondary_seq, severity_abbrev as secondary_name
		  from n3c_dashboard.severity_map2
		  ) as done;
</sql:query>
<c:forEach items="${severities.rows}" var="row" varStatus="rowCounter">
	var severity_legend2 = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct age_bin as secondary, age_seq as secondary_seq, age_bin as secondary_name
		  from n3c_dashboard.age_map
		  ) as done;
</sql:query>
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	var age_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="ages2" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct age_bin as secondary, age_seq as secondary_seq, age_bin as secondary_name
		  from n3c_dashboard.age_map2
		  ) as done;
</sql:query>
<c:forEach items="${ages2.rows}" var="row" varStatus="rowCounter">
	var age_legend_2 = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="ages3" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct age_bin as secondary, age_seq as secondary_seq, age_bin as secondary_name
		  from n3c_dashboard.age_map3
		  ) as done;
</sql:query>
<c:forEach items="${ages3.rows}" var="row" varStatus="rowCounter">
	var age_legend_3 = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="ages3" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct age_bin as secondary, age_seq as secondary_seq, age_bin as secondary_name
		  from n3c_dashboard.age_map3
		  UNION
		  select 'Null' as secondary, 7 as secondary_seq, 'null' as seconary_name
		  ) as done;
</sql:query>
<c:forEach items="${ages3.rows}" var="row" varStatus="rowCounter">
	var age_legend_peds = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="ages4" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct age_bin as secondary, age_seq as secondary_seq, age_bin as secondary_name
		  from n3c_dashboard.age_map4
		  ) as done;
</sql:query>
<c:forEach items="${ages4.rows}" var="row" varStatus="rowCounter">
	var age_legend_4 = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="ages5" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct age as secondary, age_seq as secondary_seq, age as secondary_name
		  from n3c_dashboard.age_map8
		  ) as done;
</sql:query>
<c:forEach items="${ages5.rows}" var="row" varStatus="rowCounter">
	var age_legend_5 = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="ages6" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct age_bin as secondary, age_seq as secondary_seq, age_bin as secondary_name
		  from n3c_dashboard.age_map6 where age_bin in ('18-64', '65+', 'null', 'Unknown')
		  ) as done;
</sql:query>
<c:forEach items="${ages6.rows}" var="row" varStatus="rowCounter">
	var age_legend_6 = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="ages7" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct age_bin as secondary, age_seq as secondary_seq, age_bin as secondary_name
		  from n3c_dashboard.age_map6
		  ) as done;
</sql:query>
<c:forEach items="${ages7.rows}" var="row" varStatus="rowCounter">
	var age_legend_7 = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="ages10" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by secondary_seq))
	from (select distinct age as secondary, age_seq as secondary_seq, age as secondary_name
		  from n3c_dashboard.age_map10
		  ) as done;
</sql:query>
<c:forEach items="${ages10.rows}" var="row" varStatus="rowCounter">
	var age_legend_10 = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="statuses" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select distinct test_result as secondary, test_result as secondary_name
		  from n3c_questions.table1_union order by test_result
		  ) as done;
</sql:query>
<c:forEach items="${statuses.rows}" var="row" varStatus="rowCounter">
	var result_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="statuses" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select distinct result_abbrev as secondary, result_abbrev as secondary_name, result_seq
		  from n3c_dashboard.result_map order by result_seq
		  ) as done;
</sql:query>
<c:forEach items="${statuses.rows}" var="row" varStatus="rowCounter">
	var result_legend2 = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="statuses" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select distinct diagnosis_abbrev as secondary, diagnosis_abbrev as secondary_name, diagnosis_seq
		  from n3c_dashboard.diagnosis_map order by diagnosis_seq
		  ) as done;
</sql:query>
<c:forEach items="${statuses.rows}" var="row" varStatus="rowCounter">
	var diagnosis_legend = ${row.jsonb_pretty};
</c:forEach>

<sql:query var="statuses" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select distinct diagnosis_abbrev as secondary, diagnosis_abbrev as secondary_name, diagnosis_seq
		  from n3c_dashboard.diagnosis_map2 order by diagnosis_seq
		  ) as done;
</sql:query>
<c:forEach items="${statuses.rows}" var="row" varStatus="rowCounter">
	var diagnosis_legend2 = ${row.jsonb_pretty};
</c:forEach>



var medication_legend = new Array()
<sql:query var="statuses" dataSource="jdbc/N3CPublic">
	select distinct drug_name
		  from n3c_dashboard_ph.medtimeser_drug_cnt_smry_csd order by drug_name
</sql:query>
<c:forEach items="${statuses.rows}" var="row" varStatus="rowCounter">
	medication_legend.push("${row.drug_name}");
</c:forEach>

<sql:query var="statuses" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done))
	from (select distinct drug_name as secondary, ROW_NUMBER() OVER (ORDER BY drug_name) as secondary_seq, drug_name as secondary_name
		from n3c_dashboard_ph.medtimeser_drug_cnt_smry_csd
		order by drug_name
	) as done;
</sql:query>
<c:forEach items="${statuses.rows}" var="row" varStatus="rowCounter">
	var medication_legend2 = ${row.jsonb_pretty};
</c:forEach>




var sotrovimaboccurrence_legend = [ { "secondary": "Before Other Med", "secondary_name": "Before Other Med", "sotrovimaboccurrence_seq": 1 }, { "secondary": "After Other Med", "secondary_name": "After Other Med", "sotrovimaboccurrence_seq": 2 } ];
