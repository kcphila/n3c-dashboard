<div class="secondary-description">
	<p><strong>Sample:</strong> <span class="tip">
					<a class="viz_secondary_info" title="COVID+ Defined As:  <a class='close popover_close' data-dismiss='alert'>&times;</a>" data-html="true" data-toggle="popover" data-placement="top" data-content="<ul style='padding-inline-start: 15px;'><li>Laboratory-confirmed positive COVID-19 PCR or Antigen test</li><li>(or) Laboratory-confirmed positive COVID-19 Antibody test</li><li>(or) Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</li></ul>" aria-describedby="tooltip">
  						<u style="white-space:nowrap;">COVID+ patients <i class="fa fa-info" aria-hidden="true"></i></u> 
  						<span class="sr-only">, or patients who have had, a laboratory-confirmed positive COVID-19 PCR or Antigen test, a laboratory-confirmed positive COVID-19 Antibody test, or a Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</span>
					</a>
				</span>&nbsp;in the N3C Data Enclave who have any <span class="tip">
					<a class="viz_secondary_info" title="Smoking Status Defined As:  <a class='close popover_close' data-dismiss='alert'>&times;</a>" data-html="true" data-toggle="popover" data-placement="top" data-content="<ul style='padding-inline-start: 15px;'>
					<li>Never - patients whose EHR recorded Never Smoked Tobacco</li>
					<li>Current or Former - patients whose EHR recorded any past or current smoking status</li>
					<li>Unknown - patients whose EHR had no data on smoking status</li>
					</ul>" aria-describedby="tooltip">
  						<u style="white-space:nowrap;">smoking status <i class="fa fa-info" aria-hidden="true"></i></u> 
  						<span class="sr-only">, Never - patients whose EHR recorded Never Smoked Tobacco, Current or Former - patients whose EHR recorded any past or current smoking status, Unknown - patients whose EHR had no data on smoking status</span>
					</a>
				</span>&nbsp; indicated in their EHR. Patient EHR records are not always complete. There is no guarantee that the reported smoking status of a patient is accurate.
				 For additional information, <a onclick="${param.block}limitlink(); return false;" href="#limitations-section">see limitations below</a>.</p>
</div>


<script>
$(function () {
  $('[data-toggle="popover"]').popover()
})
</script>