<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<p class="card-text">
	This dashboard provides the daily, cumulative, and 7-day average COVID+ patient counts within the Enclave.
</p>

<div class='row card-link'>
	<div class="col col-6">
		<a href='<util:applicationRoot/>/public-health/timeline'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
	</div>
	<div class="col col-6">
		<a tabindex="0" class="btn btn-sm btn-primary" role="button" data-html="true"
			data-toggle="popover" data-trigger="click"
			title="<b>Available Topics</b>"
			data-content="
				<a href='<util:applicationRoot/>/public-health/timeline/1'>Daily Patient Count &amp; 7-Day Rolling Average</a> 
				<br>
				<a href='<util:applicationRoot/>/public-health/timeline/2'>Cumlative Patient Count &amp; 7-Day Rolling Average</a>
			"> Topics&#8196;<i class="fas fa-bars"></i>
		</a>
	</div>
</div>
