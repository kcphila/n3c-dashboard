<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select jsonb_agg(foo) as foo
from
     (select
     	CASE
			WHEN variable = 'TUBERCULOSIS' THEN 'Tuberculosis' 
			WHEN variable = 'MILDLIVERDISEASE' THEN 'Mild liver disease'
			WHEN variable = 'MODERATESEVERELIVERDISEASE' THEN 'Moderate to severe liver disease'
			WHEN variable = 'THALASSEMIA' THEN 'Thalassemia'
			WHEN variable = 'RHEUMATOLOGICDISEASE' THEN 'Rheumatologic disease'
			WHEN variable = 'DEMENTIA' THEN 'Dementia'
			WHEN variable = 'CONGESTIVEHEARTFAILURE' THEN 'Congestive heart failure'
			WHEN variable = 'SUBSTANCEUSEDISORDER' THEN 'Substance use disorder'
			WHEN variable = 'DOWNSYNDROME' THEN 'Down syndrome'
			WHEN variable = 'KIDNEYDISEASE' THEN 'Kidney disease'
			WHEN variable = 'MALIGNANTCANCER' THEN 'Malignant cancer'
			WHEN variable = 'DIABETESCOMPLICATED' THEN 'Diabetes complicated'
			WHEN variable = 'CEREBROVASCULARDISEASE' THEN 'Cerebrovascular disease'
			WHEN variable = 'PERIPHERALVASCULARDISEASE' THEN 'Peripheral vascular disease'
			WHEN variable = 'PREGNANCY' THEN 'Pregnancy'
			WHEN variable = 'HEARTFAILURE' THEN 'Heart failure'
			WHEN variable = 'HEMIPLEGIAORPARAPLEGIA' THEN 'Hemiplegia or paraplegia'
			WHEN variable = 'PSYCHOSIS' THEN 'Psychosis'
			WHEN variable = 'CORONARYARTERYDISEASE' THEN 'Coronary artery disease'
			WHEN variable = 'SYSTEMICCORTICOSTEROIDS' THEN 'Systemic corticosteroids'
			WHEN variable = 'DEPRESSION' THEN 'Depression'
			WHEN variable = 'METASTATICSOLIDTUMORCANCERS' THEN 'Metastatic solid tumor cancers'
			WHEN variable = 'HIVINFECTION' THEN 'HIV infection'
			WHEN variable = 'CHRONICLUNGDISEASE' THEN 'Chronic lung disease'
			WHEN variable = 'PEPTICULCER' THEN 'Peptic ulcer'
			WHEN variable = 'SICKLECELLDISEASE' THEN 'Sickle cell disease'
			WHEN variable = 'MYOCARDIALINFARCTION' THEN 'Myocardial infarction'
			WHEN variable = 'DIABETESUNCOMPLICATED' THEN 'Diabetes uncomplicated'
			WHEN variable = 'CARDIOMYOPATHIES' THEN 'Cardiomyopathies'
			WHEN variable = 'HYPERTENSION' THEN 'Hypertension'
			WHEN variable = 'OTHERIMMUNOCOMPROMISED' THEN 'Other immunocompromised'
			WHEN variable = 'PULMONARYEMBOLISM' THEN 'Pulmonary embolism'
			WHEN variable = 'TOBACCOSMOKER' THEN 'Tobacco smoker'
			WHEN variable = 'SOLIDORGANORBLOODSTEMCELLTRANSPLANT' THEN 'Solid organ or blood stem cell transplant'
			WHEN variable = 'number_of_COVID_vaccine_doses_before_or_day_of_covid' THEN 'Number of COVID vaccine doses before or day of COVID'
			WHEN variable = 'COVID_associated_hospitalization_indicator' THEN 'COVID associated hospitalization indicator'
			WHEN variable = 'COVID_patient_death_indicator' THEN 'COVID patient death indicator'
			WHEN variable = 'White_Non_Hispanic' THEN 'White, non-Hispanic'
			WHEN variable = 'Hispanic_or_Latino_Any_Race' THEN 'Hispanic or Latino, any race'
			WHEN variable = 'Asian_Non_Hispanic' THEN 'Asian, non-Hispanic'
			WHEN variable = 'Black_or_African_American_Non_Hispanic' THEN 'Black or African American, non-Hispanic'
			WHEN variable = 'Other_Non_Hispanic' THEN 'Other race/ethnicity, non-Hispanic'
			WHEN variable = 'Unknown_race' THEN 'Unknown race/ethnicity'
			WHEN variable = 'age_under45_' THEN 'Age: under 45y '
			WHEN variable = 'age_46to65_' THEN 'Age: 46y to 65y'
			WHEN variable = 'age_66plus' THEN 'Age: 66y+'
			ELSE
			  variable
			END as variable,
     	to_char(shap_abs::float, 'FM99.0000')::float as shap_abs,
     	CASE
     		WHEN cohort = 'COHORT A' THEN 'Cohort A'
     		WHEN cohort = 'COHORT B' THEN 'Cohort B'
     		WHEN cohort = 'COHORT C' THEN 'Cohort C'
     		ELSE cohort
     	END as cohort 
     from phastr_pasc.analysis2_combined_cohort_shap_values order by variable,cohort) as foo;
</sql:query>

{
    "headers": [
    	{"value":"variable", "label":"Variable"},
        {"value":"shap_abs", "label":"shap abs"},
        {"value":"cohort", "label":"Cohort"}
    ],
    "rows" :
    <c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	    ${row.foo}
	</c:forEach>

}
       