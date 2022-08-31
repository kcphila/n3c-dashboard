<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<p class="card-text">
	This dashboard breaks down the counts of patients with select comorbidities by COVID status, 
	the incidence in relation to COVID+ diagnosis, and demographics.
</p>

<div class='row card-link'>
	<div class="col col-6">
		<a href='<util:applicationRoot/>/public-health/hlh'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
	</div>
	<div class="col col-6">
		<a tabindex="0" class="btn btn-sm btn-primary" role="button" data-html="true"
			data-toggle="popover" data-trigger="click"
			title="<b>Available Topics</b>"
			data-content="
				<a href='<util:applicationRoot/>/public-health/hlh/1'>Cancer</a> 
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/2'>Congestive Heart Failure</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/3'>Dementia</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/4'>Diabetes Mellitus</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/5'>Diabetes Mellitus with Complications</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/6'>HIV</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/7'>HLH</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/8'>Liver Disease Mild</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/9'>Liver Disease Severe</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/10'>Metastasis</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/11'>Myocardial Infarction</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/12'>Paralysis</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/13'>Peptic Ulcer Disease</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/14'>Peripheral Vascular Disease</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/15'>Pulmonary</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/16'>Renal Disease</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/17'>Rheumatologic Disease</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/hlh/18'>Stroke</a>
			"> Topics&#8196;<i class="fas fa-bars"></i>
		</a>
	</div>
</div>
