<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!-- <p class="card-text"> -->
<!-- 	This dashboard provides an overview of the demographics, severity, vaccination status, and  -->
<!-- 	comorbidities of COVID+ patients <strong>under the age of 18</strong> within the Enclave.  -->
<!-- </p> -->

<div class='row card-link'>
	<div class="col col-6">
		<a href='<util:applicationRoot/>/public-health/pediatrics'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
	</div>
	<div class="col col-6">
		<a tabindex="0" class="btn btn-sm btn-primary" role="button" data-html="true"
			data-toggle="popover" data-trigger="click"
			title="<b>Available Topics</b>"
			data-content="
				<a href='<util:applicationRoot/>/public-health/pediatrics/1'>Demographics</a> 
				<br>
				<a href='<util:applicationRoot/>/public-health/pediatrics/2'>Vaccination Status</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/pediatrics/3'>Vaccination Status and Grouped Comorbidities</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/pediatrics/4'>Grouped Comorbidities</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/pediatrics/5'>Ungrouped Comorbidities</a>
			"> Topics&#8196;<i class="fas fa-bars"></i>
		</a>
	</div>
</div>
