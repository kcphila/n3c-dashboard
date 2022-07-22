<div class="secondary-description">
	<p>Sample: <span class="tip">
					<a class="viz_secondary_info" title="COVID+ Defined As:" data-html="true" data-toggle="popover" data-placement="top" data-content="<ul style='padding-inline-start: 15px;'><li>Laboratory-confirmed positive COVID-19 PCR or Antigen test</li><li>(or) Laboratory-confirmed positive COVID-19 Antibody test</li><li>(or) Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</li></ul>" aria-describedby="tooltip">
  						<u style="white-space:nowrap;">COVID+ patients <i class="fa fa-info" aria-hidden="true"></i></u> 
  						<span class="sr-only">, or patients who have had, a laboratory-confirmed positive COVID-19 PCR or Antigen test, a laboratory-confirmed positive COVID-19 Antibody test, or a Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</span>
					</a>
				</span>&nbsp;in the N3C Data Enclave. Patient EHR records are not always complete. 
				<span class="tip">
					<a class="viz_secondary_info" title="Smoking Status Defined As:" data-html="true" data-toggle="popover" data-placement="top" data-content="<ul style='padding-inline-start: 15px;'>
					<li>Never - patients whose EHR recorded Never Smoked Tobacco</li>
					<li>Current or Former - patients whose EHR recorded any past or current smoking status</li>
					<li>Unknown - patients whose EHR had no data on smoking status</li>
					</ul>" aria-describedby="tooltip">
  						<u style="white-space:nowrap;">Smoking Status <i class="fa fa-info" aria-hidden="true"></i></u> 
  						<span class="sr-only">, Never - patients whose EHR recorded Never Smoked Tobacco, Current or Former - patients whose EHR recorded any past or current smoking status, Unknown - patients whose EHR had no data on smoking status</span>
					</a>
				</span>&nbsp; for this patient population was obtained from EHR records. There is no guarantee that the reported smoking status of a patient is accurate. 
				<span class="tip">
					<a class="viz_secondary_info" title="Severity Defined As:" data-html="true" data-toggle="popover" data-placement="top" data-content="<ul style='padding-inline-start: 15px;'>
					<li>Mild - Patient has no record of Emergency Room visit or hospitalization for COVID-19</li>
					<li>ED Visit (not admitted) - Patient had an Emergency Room (ER) visit for COVID-19 but we have no record of hospitalization(Inpatient) for COVID-19</li>
					<li>Moderate Hospitalized - Patient was hospitalized (Inpatient visit) for COVID-19 AND did not receive ECMO OR Invasive Ventilation</li>
					<li>Mortality - Patient records show a date of death</li>
					<li>Severe Ventilation/ECMO/AKI - Patient was hospitalized for COVID-19 AND received Extracorporeal membrane oxygen (ECMO) OR received Invasive Ventilation</li>
					<li>Unavailable - Patients who did not have a lab-confirmed positive PCR or Antigen COVID test</li>
					</ul>" aria-describedby="tooltip">
  						<u style="white-space:nowrap;">Severity <i class="fa fa-info" aria-hidden="true"></i></u> 
  						<span class="sr-only">, Mild - Patient has no record of Emergency Room visit or hospitalization for COVID-19, ED Visit (not admitted) - Patient had an Emergency Room (ER) visit for COVID-19 but we have no record of hospitalization(Inpatient) for COVID-19, Moderate Hospitalized - Patient was hospitalized (Inpatient visit) for COVID-19 AND did not receive ECMO OR Invasive Ventilation, Mortality - Patient records show a date of death, Severe Ventilation/ECMO/AKI - Patient was hospitalized for COVID-19 AND received Extracorporeal membrane oxygen (ECMO) OR received Invasive Ventilation, Unavailable - Patients who did not have a lab-confirmed positive PCR or Antigen COVID test</span>
					</a>
				</span>&nbsp; of COVID-19 is a calculation based on multiple events recorded in a patients EHR during their medical visit. 
				The severity score for each patient may be inaccurate due to missing information within the EHR. A patient will only 
				be graded on Severity if they have a laboratory-confirmed positive PCR or Antigen test.</p>
</div>


<script>
$(function () {
  $('[data-toggle="popover"]').popover()
})
</script>