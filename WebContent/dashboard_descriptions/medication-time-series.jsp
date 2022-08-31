<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<p class="card-text">
	This dashboard provides the monthly counts of COVID+ patients prescribed select medications.
</p>

<div class='row card-link'>
	<div class="col col-6">
		<a href='<util:applicationRoot/>/public-health/medication-time-series'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
	</div>
	<div class="col col-6">
		<a tabindex="0" class="btn btn-sm btn-primary" role="button" data-html="true"
			data-toggle="popover" data-trigger="click"
			title="<b>Available Topics</b>"
			data-content="
				<a href='<util:applicationRoot/>/public-health/medication-time-series/1'>Time Series</a> 
				<br>
				<a href='<util:applicationRoot/>/public-health/medication-time-series/2'>Overall Counts</a>
			"> Topics&#8196;<i class="fas fa-bars"></i>
		</a>
	</div>
</div>
