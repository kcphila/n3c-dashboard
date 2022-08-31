<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<p class="card-text">
	This dashboard breaks down the counts of patients with diabetes (types 1 and 2) by COVID status, 
	the incidence in relation to COVID diagnosis, and demographics.
</p>

<div class='row card-link'>
	<div class="col col-6">
		<a href='<util:applicationRoot/>/public-health/diabetes-mellitus'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
	</div>
	<div class="col col-6">
		<a tabindex="0" class="btn btn-sm btn-primary" role="button" data-html="true"
			data-toggle="popover" data-trigger="click"
			title="<b>Available Topics</b>"
			data-content="
				<a href='<util:applicationRoot/>/public-health/diabetes-mellitus/1'>Diabetes Mellitus Type 2</a> 
				<br>
				<a href='<util:applicationRoot/>/public-health/diabetes-mellitus/2'>Diabetes Mellitus Type 1</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/diabetes-mellitus/3'>Type 1 Under the Age of 18</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/diabetes-mellitus/4'>Type 2 Under the Age of 18</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/diabetes-mellitus/5'>Type 1 Over the Age of 18</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/diabetes-mellitus/6'>Type 2 Over the Age of 18</a>
			"> Topics&#8196;<i class="fas fa-bars"></i>
		</a>
	</div>
</div>
