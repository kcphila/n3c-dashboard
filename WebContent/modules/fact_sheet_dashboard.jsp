<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
.stat-header{
	color: rgba(100,42,107,1);
}

.stat{
	color: #007bff;
}
</style>

<div class="row mx-auto" style="padding: 10px; padding-bottom:30px; padding-top:30px; width:100%;">
	<div class="row" style="padding: 10px; padding-bottom:30px; padding-top:30px; width:100%;">
		<div class="col-12 col-md-6" style="text-align:center;">
			<h4><strong class="stat-header"><i class="fas fa-clinic-medical"></i> Sites: </strong> <span id="site_count" class="stat">&nbsp;</span></h4>
			<h4><strong class="stat-header"><i class="fas fa-user"></i> Persons: </strong><span id="persons" class="stat">&nbsp;</span></h4>
			<h4><strong class="stat-header"><i class="fas fa-virus"></i> COVID+ Cases: </strong> <span id="positive" class="stat">&nbsp;</span></h4>
			<h4><strong class="stat-header"><i class="fas fa-table"></i> # of Rows: </strong> <span id="rows" class="stat">&nbsp;</span></h4>
			<h4><strong class="stat-header"><i class="fas fa-notes-medical"></i> Clinical Observations: </strong> <span id="observations" class="stat">&nbsp;</span></h4>
		</div>
		<div class="col-12 col-md-6" style="text-align:center;">
			<h4><strong class="stat-header"><i class="fas fa-file-medical-alt"></i> Lab Results: </strong><span id="results" class="stat">&nbsp;</span></h4>
			<h4><strong class="stat-header"><i class="fas fa-pills"></i> Medication Records: </strong><span id="records" class="stat">&nbsp;</span></h4>
			<h4><strong class="stat-header"><i class="fas fa-procedures"></i> Procedures: </strong><span id="procedures" class="stat">&nbsp;</span></h4>
			<h4><strong class="stat-header"><i class="far fa-calendar-alt"></i> Visits: </strong><span id="visits" class="stat"></span></h4>
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