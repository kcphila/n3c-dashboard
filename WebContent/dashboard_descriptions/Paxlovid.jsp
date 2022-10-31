<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<p class="card-text">
	This dashboard provides an overview of the patients prescribed Paxlovid, including demographic information, 
	associated medications, conditions, and outcomes.
</p>

<div class='row card-link'>
	<div class="col col-6">
		<a href='<util:applicationRoot/>/public-health/Paxlovid'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
	</div>
	<div class="col col-6">
		<a tabindex="0" class="btn btn-sm btn-primary" role="button" data-html="true"
			data-toggle="popover" data-trigger="click"
			title="<b>Available Topics</b>"
			data-content="
				<a href='<util:applicationRoot/>/public-health/Paxlovid/4'>Age</a> 
				<br>
				<a href='<util:applicationRoot/>/public-health/Paxlovid/5'>Sex</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/Paxlovid/6'>Race</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/Paxlovid/7'>Ethnicity</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/Paxlovid/8'>Outcomes</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/Paxlovid/1'>Conditions</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/Paxlovid/2'>Medications</a>
				<br>
				<a href='<util:applicationRoot/>/public-health/Paxlovid/3'>Visits</a>
			"> Topics&#8196;<i class="fas fa-bars"></i>
		</a>
	</div>
</div>
