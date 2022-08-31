<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<p class="card-text">
	This dashboard provides a snapshot of the demographics and symptoms associated with Long COVID.  
</p>

<div class='row card-link'>
	<div class="col col-6">
		<a href='<util:applicationRoot/>/public-health/long-covid'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
	</div>
	<div class="col col-6">
		<a tabindex="0" class="btn btn-sm btn-primary" role="button" data-html="true"
			data-toggle="popover" data-trigger="click"
			title="<b>Available Topics</b>"
			data-content="
				<a href='<util:applicationRoot/>/public-health/long-covid/1'>Overview</a> 
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/13'>ICD-10 Code (U09.9)</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/2'>Clinic Visits</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/3'>Cumulative Symptoms Summary</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/4'>Grouped ICD-10 Symptom Counts</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/5'>Ungrouped ICD-10 Symptom Counts</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/6'>ICD-10 Symptom Counts Before/After COVID+</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/7'>Cognitive Impairment</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/8'>Fatigue</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/9'>Mental Health Condition</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/10'>Postural Orthostatic Tachycardia Syndrome (POTS)</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/11'>Shortness of Breath</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/long-covid/12'>Patients That Have Not Tested Positive For COVID</a>
			"> Topics&#8196;<i class="fas fa-bars"></i>
		</a>
	</div>
</div>
