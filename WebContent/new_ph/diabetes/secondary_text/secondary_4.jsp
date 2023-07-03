<div class="secondary-description">
	<p><strong>Sample:</strong> All Patients under the age of 18 in the N3C Data Enclave who have had a medical visit on or after 1/1/2019 in which Type 2 Diabetes was coded.
	Given that patients do not have a clear date on which they were diagnosed with Diabetes, we assume the date of their first recorded 
	medical visit coded for Type 2 Diabetes is the day they were diagnosed with Diabetes. If a patient with Diabetes has not been 
	diagnosed or has not had a medical visit related to Diabetes within their EHR, they would be missing from this data. 
	Patient counts in relation to COVID-19 diagnosis are calculated using the number of days between their earliest recorded medical visit 
	coded for Diabetes and their 
	<span class="tip">
		<a class="viz_secondary_info" title="COVID-positive Defined As: <a class='close popover_close' data-dismiss='alert'>&times;</a>" data-html="true" data-toggle="popover" data-placement="top" data-content="<ul style='padding-inline-start: 15px;'><li>Laboratory-confirmed positive COVID-19 PCR or Antigen test</li><li>(or) Laboratory-confirmed positive COVID-19 Antibody test</li><li>(or) Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</li></ul>" aria-describedby="tooltip">
  			<u style="white-space:nowrap;">COVID-positive <i class="fa fa-info" aria-hidden="true"></i></u> 
  			<span class="sr-only">, or patients who have had a laboratory-confirmed positive COVID-19 PCR or Antigen test, a laboratory-confirmed positive COVID-19 Antibody test, or a Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</span>
		</a>
	</span>&nbsp; diagnosis.
	This sample may have instances of false negatives when using it to assess the population of 
	<span class="tip">
		<a class="viz_secondary_info" title="COVID-negative Defined As: <a class='close popover_close' data-dismiss='alert'>&times;</a>" data-html="true" data-toggle="popover" data-placement="top" data-content="<ul style='padding-inline-start: 15px;'><li>No laboratory-confirmed positive COVID-19 PCR or Antigen test</li><li>(and) No laboratory-confirmed positive COVID-19 Antibody test</li><li>(and) No medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</li></ul>" aria-describedby="tooltip">
  			<u style="white-space:nowrap;">COVID-negative persons <i class="fa fa-info" aria-hidden="true"></i></u> 
  			<span class="sr-only">, or patients who have not had a laboratory-confirmed positive COVID-19 PCR or Antigen test, a laboratory-confirmed positive COVID-19 Antibody test, or a Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</span>
		</a>
	</span>&nbsp;. 
	This can be caused by a lack of testing, non-reported testing, and reported testing not captured by our data partners 
	(i.e., testing done at an unrelated institution). For additional information, <a onclick="${param.block}limitlink(); return false;" href="#${param.block}limitations-section">see limitations below</a>.</p>
</div>


<script>
$(function () {
  $('[data-toggle="popover"]').popover()
})

$(document).on("click", ".popover .close" , function(){
    $(this).parents(".popover").popover('hide');
});
</script>
