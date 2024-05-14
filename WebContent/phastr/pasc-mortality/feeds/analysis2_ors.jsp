<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
     (select
     	CASE
			WHEN term = 'TUBERCULOSIS' THEN 'Tuberculosis' 
			WHEN term = 'MILDLIVERDISEASE' THEN 'Mild liver disease'
			WHEN term = 'MODERATESEVERELIVERDISEASE' THEN 'Moderate to severe liver disease'
			WHEN term = 'THALASSEMIA' THEN 'Thalassemia'
			WHEN term = 'RHEUMATOLOGICDISEASE' THEN 'Rheumatologic disease'
			WHEN term = 'DEMENTIA' THEN 'Dementia'
			WHEN term = 'CONGESTIVEHEARTFAILURE' THEN 'Congestive heart failure'
			WHEN term = 'SUBSTANCEUSEDISORDER' THEN 'Substance use disorder'
			WHEN term = 'DOWNSYNDROME' THEN 'Down syndrome'
			WHEN term = 'KIDNEYDISEASE' THEN 'Kidney disease'
			WHEN term = 'MALIGNANTCANCER' THEN 'Malignant cancer'
			WHEN term = 'DIABETESCOMPLICATED' THEN 'Diabetes complicated'
			WHEN term = 'CEREBROVASCULARDISEASE' THEN 'Cerebrovascular disease'
			WHEN term = 'PERIPHERALVASCULARDISEASE' THEN 'Peripheral vascular disease'
			WHEN term = 'PREGNANCY' THEN 'Pregnancy'
			WHEN term = 'HEARTFAILURE' THEN 'Heart failure'
			WHEN term = 'HEMIPLEGIAORPARAPLEGIA' THEN 'Hemiplegia or paraplegia'
			WHEN term = 'PSYCHOSIS' THEN 'Psychosis'
			WHEN term = 'CORONARYARTERYDISEASE' THEN 'Coronary artery disease'
			WHEN term = 'SYSTEMICCORTICOSTEROIDS' THEN 'Systemic corticosteroids'
			WHEN term = 'DEPRESSION' THEN 'Depression'
			WHEN term = 'METASTATICSOLIDTUMORCANCERS' THEN 'Metastatic solid tumor cancers'
			WHEN term = 'HIVINFECTION' THEN 'HIV infection'
			WHEN term = 'CHRONICLUNGDISEASE' THEN 'Chronic lung disease'
			WHEN term = 'PEPTICULCER' THEN 'Peptic ulcer'
			WHEN term = 'SICKLECELLDISEASE' THEN 'Sickle cell disease'
			WHEN term = 'MYOCARDIALINFARCTION' THEN 'Myocardial infarction'
			WHEN term = 'DIABETESUNCOMPLICATED' THEN 'Diabetes uncomplicated'
			WHEN term = 'CARDIOMYOPATHIES' THEN 'Cardiomyopathies'
			WHEN term = 'HYPERTENSION' THEN 'Hypertension'
			WHEN term = 'OTHERIMMUNOCOMPROMISED' THEN 'Other immunocompromised'
			WHEN term = 'PULMONARYEMBOLISM' THEN 'Pulmonary embolism'
			WHEN term = 'TOBACCOSMOKER' THEN 'Tobacco smoker'
			WHEN term = 'SOLIDORGANORBLOODSTEMCELLTRANSPLANT' THEN 'Solid organ or blood stem cell transplant'
			WHEN term = 'number_of_COVID_vaccine_doses_before_or_day_of_covid' THEN 'Number of COVID vaccine doses before or day of COVID'
			WHEN term = 'COVID_associated_hospitalization_indicator' THEN 'COVID associated hospitalization indicator'
			WHEN term = 'COVID_patient_death_indicator' THEN 'COVID patient death indicator'
			WHEN term = 'White_Non_Hispanic' THEN 'White, non-Hispanic'
			WHEN term = 'Hispanic_or_Latino_Any_Race' THEN 'Hispanic or Latino, any race'
			WHEN term = 'Asian_Non_Hispanic' THEN 'Asian, non-Hispanic'
			WHEN term = 'Black_or_African_American_Non_Hispanic' THEN 'Black or African American, non-Hispanic'
			WHEN term = 'Other_Non_Hispanic' THEN 'Other race/ethnicity, non-Hispanic'
			WHEN term = 'Unknown_race' THEN 'Unknown race/ethnicity'
			WHEN term = 'age_under45_' THEN 'Age: under 45y '
			WHEN term = 'age_46to65_' THEN 'Age: 46y to 65y'
			WHEN term = 'age_66plus' THEN 'Age: 66y+'
			ELSE
			  term
			END as term,
     	to_char(estimate, 'FM99.0000')::float as estimate,
     	to_char(statistic, 'FM99.0000')::float as statistic,
     	to_char(std_error, 'FM99.0000')::float as std_error,
     	p_value,
     	to_char(conf_low, 'FM99.0000')::float as conf_low,
     	to_char(conf_high, 'FM99.0000')::float as conf_high,
     	CASE
     		WHEN cohort = 'COHORT A' THEN 'Cohort A'
     		WHEN cohort = 'COHORT B' THEN 'Cohort B'
     		WHEN cohort = 'COHORT C' THEN 'Cohort C'
     		ELSE cohort
     	END as cohort 
     from phastr_pasc.analysis2_combined_cohorts_logreg_ors order by term,cohort) as foo;
</sql:query>

{
    "headers": [
    	{"value":"term", "label":"Term"},
        {"value":"estimate", "label":"Estimate"},
        {"value":"std_error", "label":"Std Error"},
        {"value":"statistic", "label":"Statistic"},
        {"value":"p_value", "label":"p Value"},
        {"value":"conf_low", "label":"Confidence Low"},
        {"value":"conf_high", "label":"Confidence High"},
        {"value":"cohort", "label":"Cohort"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       