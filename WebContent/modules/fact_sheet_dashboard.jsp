<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
.stat-header i{
	font-size: 1.1em;
    width: 1.8em;
    text-align: center;
    line-height: 1.8em;
    color: white;
    border-radius: 1em;
    margin-bottom: 2px;
    margin-top: 2px;
    background: rgba(100,42,107,1);
	background: -moz-linear-gradient(-45deg, rgba(100,42,107,1) 0%, rgba(99,53,112,1) 47%, rgba(70,71,119,1) 100%);
	background: -webkit-gradient(left top, right bottom, color-stop(0%, rgba(100,42,107,1)), color-stop(47%, rgba(99,53,112,1)), color-stop(100%, rgba(70,71,119,1)));
	background: -webkit-linear-gradient(-45deg, rgba(100,42,107,1) 0%, rgba(99,53,112,1) 47%, rgba(70,71,119,1) 100%);
	background: -o-linear-gradient(-45deg, rgba(100,42,107,1) 0%, rgba(99,53,112,1) 47%, rgba(70,71,119,1) 100%);
	background: -ms-linear-gradient(-45deg, rgba(100,42,107,1) 0%, rgba(99,53,112,1) 47%, rgba(70,71,119,1) 100%);
	background: linear-gradient(135deg, rgba(100,42,107,1) 0%, rgba(99,53,112,1) 47%, rgba(70,71,119,1) 100%);
}

.stats_section p{
	margin-bottom: 0px;
}

.intro_desc{
	margin-bottom: 30px!important;
}

.stat{
	white-space: nowrap;
}

.stat-icon{
	margin-top:auto;
	margin-bottom: auto;
}

</style>

<div class="row m-auto stats_section">
	<div class="">
		<p class="intro_desc heading-text">The N3C Data Enclave represents one of the largest secure collections of harmonized clinical health data in the United States.</p>
	</div>
	<div class="row large-p">
		<div class="col-12 col-md-6">
			<div class="d-flex stat-header">
				<div class="pr-2 stat-icon">
					<p><i class="fas fa-clinic-medical"></i></p>
				</div>
				<div class="mt-auto mb-auto">
					<p><strong> Sites: </strong> <span id="site_count" class="stat">&nbsp;</span></p>
				</div>
			</div>
			<div class="d-flex stat-header">
				<div class="pr-2 stat-icon">
					<p><i class="fas fa-user"></i></p>
				</div>
				<div class="mt-auto mb-auto">
					<p><strong> Persons: </strong> <span id="persons" class="stat">&nbsp;</span></p>
				</div>
			</div>
			<div class="d-flex stat-header">
				<div class="pr-2 stat-icon">
					<p><i class="fas fa-virus"></i></p>
				</div>
				<div class="mt-auto mb-auto">
					<p><strong> COVID+ Cases: </strong> <span id="positive" class="stat">&nbsp;</span></p>
				</div>
			</div>
			<div class="d-flex stat-header">
				<div class="pr-2 stat-icon">
					<p><i class="fas fa-table"></i></p>
				</div>
				<div class="mt-auto mb-auto">
					<p><strong> # of Rows: </strong> <span id="rows" class="stat">&nbsp;</span></p>
				</div>
			</div>
			<div class="d-flex stat-header">
				<div class="pr-2 stat-icon">
					<p><i class="fas fa-notes-medical"></i></p>
				</div>
				<div class="mt-auto mb-auto">
					<p><strong>  Clinical Observations: </strong> <span id="observations" class="stat">&nbsp;</span></p>
				</div>
			</div>
		</div>
		<div class="col-12 col-md-6">
			<div class="d-flex stat-header">
				<div class="pr-2 stat-icon">
					<p><i class="fas fa-file-medical-alt"></i></p>
				</div>
				<div class="mt-auto mb-auto">
					<p><strong>  Lab Results: </strong> <span id="results" class="stat">&nbsp;</span></p>
				</div>
			</div>
			<div class="d-flex stat-header">
				<div class="pr-2 stat-icon">
					<p><i class="fas fa-pills"></i></p>
				</div>
				<div class="mt-auto mb-auto">
					<p><strong>  Medication Records: </strong> <span id="records" class="stat">&nbsp;</span></p>
				</div>
			</div>
			<div class="d-flex stat-header">
				<div class="pr-2 stat-icon">
					<p><i class="fas fa-procedures"></i></p>
				</div>
				<div class="mt-auto mb-auto">
					<p><strong>  Procedures: </strong> <span id="procedures" class="stat">&nbsp;</span></p>
				</div>
			</div>
			<div class="d-flex stat-header">
				<div class="pr-2 stat-icon">
					<p><i class="far fa-calendar-alt"></i></p>
				</div>
				<div class="mt-auto mb-auto">
					<p><strong>  Visits: </strong> <span id="visits" class="stat">&nbsp;</span></p>
				</div>
			</div>
		</div>
		<div class="col-12" style="margin-top:20px;">
			<em style="margin-top:10px; font-size:14px;">Data as of	<span id="date"></span></em>
		</div>
	</div>
</div>
	

<script>
	$.getJSON("<util:applicationRoot/>/feeds/embedded_fact_sheet.jsp", function(json){
		var data = $.parseJSON(JSON.stringify(json));

		$('#date').text(data['release_date']); 


		$('#site_count').text(data['sites_ingested']); 	
		$('#persons').text(data['person_rows']); 
		$('#positive').text(data['covid_positive_patients']); 
		$('#rows').text(data['total_rows']);
		$('#observations').text(data['observation_rows']);
		$('#results').text(data['measurement_rows']);
		$('#records').text(data['drug_exposure_rows']);
		$('#procedures').text(data['procedure_rows']);
		$('#visits').text(data['visit_rows']);  	
	});

</script>