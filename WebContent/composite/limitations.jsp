<div id="limitations-section">
	<div class="accordion" id="limitations_drop">
		<div class="card">
			<a title="expand/collapse limitations section" href="" class="accordion-toggle" data-toggle="collapse" data-target="#limitcollapseOne" aria-expanded="false" aria-controls="collapseOne">
				<div class="card-header" id="limitheadingOne">
					<h4 class="mb-0">
						<span class="accordion_text">Limitations</span>
						<span style="display:inline; float:right;" class="btn btn-link btn-block text-left collapsed icon-btn p-0 accordion-toggle"></span>  							
					</h4>						
				</div>				
			</a>
			<div id="limitcollapseOne" class="collapse hide" aria-labelledby="limitheadingOne" data-parent="#limitations_drop" style="">  						
				<div class="card-body">
					<h5><strong>This data contains patients within the Enclave who have been diagnosed with COVID-19 at any time before today's date.</strong></h5>
					<p>For all visualizations, a COVID-positive patient is defined as any patient having one of the following within their EHR records:</p>
						<ol>
							<li>Laboratory confirmed positive COVID-19 PCR or Antigen test</li>
							<li>Laboratory confirmed positive COVID-19 Antibody test</li>
							<li>Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded
								<ul>
									<li>Condition diagnosis patients have no record of a positive PCR/Antigen or Antibody test within their EHR, however, they were diagnosed with COVID due to symptoms displayed.</li>
								</ul>
							</li>
						</ol>
					<h5><strong>The five graphs are as follows:</strong></h5>
						<ol>
							<li>Graph 1 contains all COVID-positive patients aggregated by Age, Race, Ethnicity, Gender, and Severity.</li>
							<li>Graph 2 contains all COVID-positive patients aggregated by Age, Race, Gender, Severity, and COVID-19 Vaccination status.</li>
							<li>Graph 3 contains all COVID-positive patients aggregated by Age, Race, Gender, Severity, COVID-19 Vaccination status, and Individual Comorbidities.</li>
							<li>Graph 4 contains all COVID-positive patients aggregated by Age, Race, Gender, Severity, and Combined Comorbidities.</li>
							<li>Graph 5 contains all COVID-positive patients aggregated by Age, Race, Gender, Severity, and Individual Comorbidities.</li>
						</ol>
					<h5><strong>Limitations/Assumptions:</strong></h5>
						<p><strong>&#8226; Severity</strong> of COVID-19 is a calculation based on multiple events recorded in a patient’s EHR during their medical visit. The severity score for each patient may be inaccurate due to missing information within the EHR. A patient will only be graded on Severity if they have a laboratory-confirmed positive PCR or Antigen test. Below are the definitions of each Severity Category.</p>
							<ul>
								<li>Mild - Patient has no record of Emergency Room visit or hospitalization for COVID-19</li>
								<li>ED Visit (not admitted) - Patient had an Emergency Room (ER) visit for COVID-19 but we have no record of hospitalization(Inpatient) for COVID-19</li>
								<li>Moderate Hospitalized - Patient was hospitalized (Inpatient visit) for COVID-19 AND did not receive ECMO OR Invasive Ventilation</li>
								<li>Mortality - Patient records show a date of death</li>
								<li>Severe Ventilation/ECMO/AKI - Patient was hospitalized for COVID-19 AND received Extracorporeal membrane oxygen (ECMO) OR received Invasive Ventilation</li>
								<li>Unavailable - Patients who did not have a lab-confirmed positive PCR or Antigen COVID test</li>
							</ul>
						<p><strong>&#8226; Comorbidities</strong> for each patient are linked to EHR medical visits coded for any of the 17 different conditions defined by the Charlson Comorbidity Index. A patient may have undiagnosed conditions which would not be recorded in their EHR and therefore would not be represented here. A patient may also have one of these conditions for which they have not required a medical visit and that would not be represented here.</p>
						<p><strong>&#8226; Vaccination</strong> data shown here is coming from EHR-recorded vaccination events at the sites which deposit data to N3C. If a patient was vaccinated at their local pharmacy, doctor's office, or state/federal vaccination site, that data will not be included here because these systems do not automatically link to a patient's EHR. Given that most vaccination events are not occurring at N3C sites, patients shown here as "Unknown" may be vaccinated, however, we do not have the records to verify this.</p>
						<p>Vaccinated patient counts shown here does not mean the patient is fully vaccinated. We consider a vaccinated patient to have at least one dose of Pfizer, Moderna, or Johnson &amp; Johnson COVID-19 vaccines. Given that Pfizer and Moderna require 2 vaccine doses to be considered fully vaccinated, patients shown here may be partially vaccinated. This same assumption applies to booster shots as we do not consider shots beyond the first one recorded within the patient's EHR.</p>
				</div>
			</div>
		</div>
	</div>
</div>