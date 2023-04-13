<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="secondary-description">
	<p><strong>Sample:</strong> <span class="tip">
		<a class="viz_secondary_info" title="COVID+ Defined As: <a class='close popover_close' data-dismiss='alert'>&times;</a>" data-html="true" data-toggle="popover" data-placement="top" data-content="<ul style='padding-inline-start: 15px;'><li>Laboratory-confirmed positive COVID-19 PCR or Antigen test</li><li>(or) Laboratory-confirmed positive COVID-19 Antibody test</li><li>(or) Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</li></ul>" aria-describedby="tooltip">
			<u style="white-space:nowrap;">COVID+ patients <i class="fa fa-info" aria-hidden="true"></i></u> 
			<span class="sr-only">, or patients who have had, a laboratory-confirmed positive COVID-19 PCR or Antigen test, a laboratory-confirmed positive COVID-19 Antibody test, or a Medical visit in which the ICD-10 code for COVID-19 (U07.1) was recorded</span>
		</a>
		</span>&nbsp;in the N3C Data Enclave with diagnosis dates on or after December 22, 2021 (the date that Paxlovid was authorized for use by the FDA). 
		 Vaccination data comes only from EHR vaccination events recorded by N3C partner sites. This means that if a patient received their 
		 vaccination from a site that does not automatically link to their EHR (ex. local pharmacy, doctor's office, or state/federal 
		 vaccination site), their vaccination will not be represented in the data. As most vaccination events are not occurring at N3C sites, 
		 the data shown here may not be fully representative. Note that N3C data may not be representative of the entire US population. 
		For additional information, <a onclick="limitlink(); return false;" href="#limitations-section">see limitations below</a>.
	</p>
</div>