<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="dashboard" uri="http://icts.uiowa.edu/N3CDashboardTagLib"%>

<style>

@media (max-width: 1200px){
	.container-large {
    	max-width: 100% !important;
	}
}

@media (min-width: 1200px){
	.container-large {
    	max-width: 100%;
	}
}

.block_header{
	text-align:center; 
	color:#fff; 
	background: #454F82;
	font-family: Arial, Helvetica, sans-serif;
	font-size:18px; 
	padding: 3px; 
	margin-top:20px;
}

.kpi tr {
	width: auto;
}

.block_header{
	background:none;
}

.kpi_ind{
	text-align:center;
}

.kpi_section .dropdown-item{
	white-space: unset;
}

#${param.block}_btn_hide{
	position: absolute;
    left: 0px;
    top: 0px;
    transform: rotate(-90deg) translate(-20px, -77px);
    border-radius: 0;
}


#${param.block}_btn_show {
    /* position: absolute; */
    left: 0px;
    top: 0px;
    transform: rotate(-90deg) translate(-24px, 54px);
    border-radius: 0;
}

.drop_filter{
	right: 0;
	left: auto;
	width: max-content;
}

.dash_filter_header{
	margin-right: 30px;
    margin-left: 30px;
}

.show_clear{
	display: inline-block;
}

.no_clear{
	display:none;
}

.show_filt:after{
	border-top: 0.3em solid;
    border-right: 0.3em solid transparent;
    border-bottom: 0;
    border-left: 0.3em solid transparent;
}

.hide_filt:after{
	border-top: 0;
    border-right: 0.3em solid transparent;
    border-bottom: 0.3em solid;
    border-left: 0.3em solid transparent;
}

.viz_options_dropdown{
	text-align: left; 
	font-size: 1.2rem;
}


@media (max-width: 768px) {
  .viz_options_dropdown, 
  .filter_button_container{
    text-align: center;
  }
}

.select2-container--default .select2-results__option--disabled{
	display:none;
}

.dash_viz{
	text-align:center;
}

.kpi_border_right{
	border-right: 2px solid #d0e3f6;
    border-radius: 0;
}

.data-as-of {
    margin-top: 0px;
    font-size: 14px;
    font-weight: 300;
    text-align: center;
    margin-bottom: 0px;
}

@media only screen and (max-width: 991px) {
  #related_dashboards {
    display: none; 
  }
}



/* change in dashboard style when all done */
.multiselect-container .multiselect-all:focus, .multiselect-container .multiselect-all:hover, .multiselect-container .multiselect-group:focus, .multiselect-container .multiselect-group:hover, .multiselect-container .multiselect-option:focus, .multiselect-container .multiselect-option:hover {
    background-color: #edf6ff!important;
}

.multiselect-container .multiselect-all.active:not(.multiselect-active-item-fallback), .multiselect-container .multiselect-all:not(.multiselect-active-item-fallback):active, .multiselect-container .multiselect-group.active:not(.multiselect-active-item-fallback), .multiselect-container .multiselect-group:not(.multiselect-active-item-fallback):active, .multiselect-container .multiselect-option.active:not(.multiselect-active-item-fallback), .multiselect-container .multiselect-option:not(.multiselect-active-item-fallback):active {
    background-color: #edf6ff;
    color: #000;
}

.table-hover tbody tr:hover {
    color: #212529;
    background-color: #edf6ff;
}

.viz-header-section {
    margin-top: 0px;
    margin-bottom: 10px;
}


.panel{
	margin-top: 30px;
}

#d3viz .kpi_section {
    text-align: left;
}

.small-viz-panel{
	padding: 10px;
}

/* filter stuff */
#filter_checks .custom-select{
	height: auto;
}

#filter_checks .btn-group{
	width: 100%;
}

#filter_checks .multiselect{
	overflow: visible;
	white-space: normal;
	word-wrap: break-word;
}

#filter_checks .multiselect-container.dropdown-menu.show{
	width: 100%;
}

#related_dashboards .card{
	cursor: pointer;
}


/* from demographics overview dash */
.filter-section {
    margin-top: 20px;
}


/* test of multiselect to list style */

.multiselect-native-select{
	width: 100%
}
.checkbox-list-container .checkbox-list > li > a {
	display: block;
	padding: 3px 0;
}

.checkbox-list-container .checkbox-list > .multiselect-option.active,
.checkbox-list-container .checkbox-list > .multiselect-option.active:hover,
.checkbox-list-container .checkbox-list > .multiselect-option.active:focus {
	color: #333;
}

.checkbox-list-container .checkbox-list > .multiselect-option.disabled,
.checkbox-list-container .checkbox-list > .multiselect-option.disabled:hover,
.checkbox-list-container .checkbox-list > .multiselect-option.disabled:focus {
	color: #777;
}

.checkbox-list-container .checkbox-list > .multiselect-option.disabled:hover,
.checkbox-list-container .checkbox-list > .multiselect-option.disabled:focus {
	text-decoration: none;
	cursor: unset;
	background-color: transparent;
	background-image: none;
	filter: progid:DXImageTransform.Microsoft.gradient(enabled = false);
}

.checkbox-list-container .multiselect-container.checkbox-list {
	position: static;
}


.filter_drop_button{
	width: 100%;
}

.filter_drop_button:focus{
	box-shadow: none;
}

#filter_checks .filter_drop_button:after {
    content: <i class="towerIcon"></i>;
    content: '\f068';
    font-family: FontAwesome;
    font-style: normal;
    font-weight: normal;
    text-decoration: inherit;
    float: right;
}

#filter_checks .filter_drop_button.collapsed:after {
    content: <i class="towerIcon"></i>;
    content: '\f067';
    font-family: FontAwesome;
    font-style: normal;
    font-weight: normal;
    text-decoration: inherit;
    float: right;
}

#filter_checks .card-header{
	padding: 2px;
}

#filter_checks .panel-body{
	border: 2px solid #eeeeee;
    border-radius: 5px;
}

#filter_checks .card{
	border: 0px;
	background-color: unset;
}

#filter_checks .card-header{
	background-color: unset;
}

#related_dashboards .related-img{
	opacity: .7;
}

#related_dashboards .card-title{
	color: #686767;
}

#related_dashboards .card-body{
	padding: 10px;
}

#related_dashboards .card{
	border: 0px;
	box-shadow: 4px 4px 15px -2px rgb(197 222 255);
    -webkit-box-shadow: 4px 4px 15px -2px rgb(197 222 255);
    -moz-box-shadow: 4px 4px 15px -2px rgba(197,222,255,1);
}

.side-col h4{
	font-weight: 300;
}

@media only screen and (max-width: 1400px) {
	.side-col .card-body{
		padding: 0px;
	}
}

.loading{
	text-align:center;
}

/* Should go over the layout to try not to overflow */
#filter_checks label.form-check-label {
    overflow-wrap: anywhere;
}


#legend{
/* 	padding: 10px;  */
/* 	border: 1px solid lightgray; */
}

#filters .filter_col{
	cursor: pointer;
}

/* clip the legend on the viz but keep it there for download */
.dash_viz.clip {
    width: 100%;
    overflow: hidden;
}

.clipsvg{
	background-color: white;
}



/* limitations section */

#question-limits{
	margin-top: 30px;
}

</style>

<!-- A block is comprised of a header bar, an optional left column with KPIs and filters, and a main panel
	 that supports a set of optional sub-panels -->

<div class="row stats block2 mx-auto">
	<div class="col-12">
	
		
<!-- KPIs & related dashboards ----------------------------------------------------------------------------------------------------------- -->	
		<div class="row" style="margin-top: 30px;">
			<div class="col col-12 col-lg-2 side-col">
				<c:if test="${not empty param.toggle}">
					<div id="mode" class="panel-heading filter-section">
						<jsp:include page="barPieToggle_new.jsp">
							<jsp:param name="block" value="${param.block}" />
							<jsp:param name="viz_properties" value="${param.viz_properties}" />
						</jsp:include>
					</div>
				</c:if>
				
				<c:if test="${not empty param.toggle2}">
					<div id="mode" class="panel-heading filter-section">
						<jsp:include page="groupedbarpercentToggle_new.jsp">
							<jsp:param name="block" value="${param.block}" />
							<jsp:param name="viz_properties" value="${param.viz_properties}" />
						</jsp:include>
					</div>
				</c:if>
				
				<c:if test="${not empty param.severity_filter || not empty param.age_filter || not empty param.age_filter2 || not empty param.age_filter4 || not empty param.age_filter5 || not empty param.age_filter6 || not empty param.age_filter7 || not empty param.age_filterpeds || not empty param.age_filterpeds2 || not empty param.race_filter || not empty param.sex_filter || not empty param.ethnicity_filter || not empty param.observation_filter || not empty param.symptom_filter || not empty param.beforeafter_filter || not empty param.result_filter || not empty param.delay_filter || not empty param.diagnosis_filter || not empty param.medication_filter || not empty param.medication_class_filter || not empty param.medications_filter || not empty param.reinfectionbin_filter}">
					<div id="filter_checks" class="panel-primary filter-section">
						<h4>Filters</h4>
						<button id="${param.block}_btn_clear" class="btn button dash-filter-btn2 mt-0 no_clear" onclick="${param.block}_filter_clear()"><i class="fas fa-times-circle"></i> Clear Filters</button>
    					<div id="${param.block}-block-kpi" class="kpi_section">
							<!-- filters are enabled by passing in a boolean parameter -->
							
							<c:if test="${param.severity_filter}">
								<jsp:include page="filters_new/severity.jsp"/>
							</c:if>
							<c:if test="${param.age_filter}">
								<jsp:include page="filters/age.jsp"/>
							</c:if>
							<c:if test="${param.age_filter2}">
								<jsp:include page="filters/age_2.jsp"/>
							</c:if>
							<c:if test="${param.age_filter4}">
								<jsp:include page="filters_new/age_4.jsp"/>
							</c:if>
							<c:if test="${param.age_filter5}">
								<jsp:include page="filters/age_5.jsp"/>
							</c:if>
							<c:if test="${param.age_filter6}">
								<jsp:include page="filters/age_6.jsp"/>
							</c:if>
							<c:if test="${param.age_filter7}">
								<jsp:include page="filters_new/age_7.jsp"/>
							</c:if>
							<c:if test="${param.age_filter10}">
								<jsp:include page="filters_new/age_10.jsp"/>
							</c:if>
							<c:if test="${param.age_filterpeds}">
								<jsp:include page="filters/age_peds.jsp"/>
							</c:if>
							<c:if test="${param.age_filterpeds2}">
								<jsp:include page="filters/age_peds2.jsp"/>
							</c:if>
							<c:if test="${param.age_filterall}">
								<jsp:include page="filters/age_all.jsp"/>
							</c:if>
							<c:if test="${param.age_filterall2}">
								<jsp:include page="filters/age_all2.jsp"/>
							</c:if>
							<c:if test="${param.race_filter}">
								<jsp:include page="filters_new/race.jsp"/>
							</c:if>
							<c:if test="${param.sex_filter}">
								<jsp:include page="filters_new/sex.jsp"/>
							</c:if>
							<c:if test="${param.sex_filter3}">
								<jsp:include page="filters_new/sex3.jsp"/>
							</c:if>
							<c:if test="${param.ethnicity_filter}">
								<jsp:include page="filters_new/ethnicity.jsp"/>
							</c:if>
							<c:if test="${param.observation_filter}">
								<jsp:include page="filters/observation.jsp"/>
							</c:if>
							<c:if test="${param.symptom_filter}">
								<jsp:include page="filters_new/symptom.jsp"/>
							</c:if>
							<c:if test="${param.vaccinated_filter}">
								<jsp:include page="filters/vaccinated.jsp"/>
							</c:if>
							<c:if test="${param.vaccinated_filter2}">
								<jsp:include page="filters_new/vaccinated2.jsp"/>
							</c:if>
							<c:if test="${param.comorbidities_filter}">
								<jsp:include page="filters/comorbidities.jsp"/>
							</c:if>
							<c:if test="${param.beforeafter_filter}">
								<jsp:include page="filters_new/beforeafter.jsp"/>
							</c:if>
							<c:if test="${param.beforeaftersotrovimab_filter}">
								<jsp:include page="filters_new/beforeafter_sotrovimab.jsp"/>
							</c:if>
							<c:if test="${param.result_filter}">
								<jsp:include page="filters/result.jsp"/>
							</c:if>
							<c:if test="${param.delay_filter}">
								<jsp:include page="filters_new/death_delay.jsp"/>
							</c:if>
							<c:if test="${param.diagnosis_filter}">
								<jsp:include page="filters_new/diagnosis.jsp"/>
							</c:if>
							<c:if test="${param.diagnosis_filter2}">
								<jsp:include page="filters_new/diagnosis2.jsp"/>
							</c:if>
							<c:if test="${param.comorbiditynumber_filter}">
								<jsp:include page="filters_new/comorbidity_number.jsp"/>
							</c:if>
							<c:if test="${param.sotrovimabmeds_filter}">
								<jsp:include page="filters_new/sotrovimab_meds.jsp"/>
							</c:if>
							<c:if test="${param.medication_filter}">
								<jsp:include page="filters_new/medication.jsp"/>
							</c:if>
							<c:if test="${param.medication_class_filter}">
								<jsp:include page="filters_new/medication_class.jsp"/>
							</c:if>
							<c:if test="${param.medications_filter}">
								<jsp:include page="filters_new/medication_ts.jsp"/>
							</c:if>
							<c:if test="${param.smoking_filter}">
								<jsp:include page="filters_new/smoking.jsp"/>
							</c:if>
							<c:if test="${param.region_filter}">
								<jsp:include page="filters_new/region.jsp"/>
							</c:if>
							<c:if test="${param.reinfectionbin_filter}">
								<jsp:include page="filters_new/reinfection_interval.jsp"/>
							</c:if>
						</div>
					</div>
				</c:if>
				
				<jsp:include page="../meta/relatedDashboardsByID.jsp?did=${param.did}"/>
				
			</div>
			
			<div class="col col-12 col-lg-10">
				<c:if test="${not empty param.kpis}">
					<div class="row kpi-row">
						<div id="${param.block}-block-kpi-kpi" class="col-12">
							<div class="kpi_containter row">
								<jsp:include page="${param.kpis}?block=${param.block}&kpi_filter=${param.kpi_filter}"/>
							</div>
						</div>
					</div>
				</c:if>
	
	<!-- Panels ------------------------------------------------------------------------------------------------- -->		
				<div id="${param.block}-panel" class="col-12 col-md-12 mx-auto mb-4 panel" >
				
					<!-- Floating Legend -->
						<c:if test="${not empty param.floating_legend}">
							<div class="col-12"> 
								<div id="${param.block}legend"></div>
							</div>
						</c:if>

					<c:if test="${not empty param.simple_panel}">
						<div id="${param.block}-simple" class="" style="display: block;">
							<c:url value="${param.simple_panel}" var="url">
	  							<c:param name="panel" value="${param.simple_panel}" />
	  							<c:param name="block" value="${param.block}" />
	  							<c:param name="datatable_div" value="${param.datatable_div}" />
	  							<c:if test="${not empty param.topic_description}">
	  								<c:param name="topic_description" value="${param.topic_description}" />
	  							</c:if>
	  							<c:if test="${not empty param.topic_title}">
	  								<c:param name="topic_title" value="${param.topic_title}" />
	  							</c:if>
	  							<c:if test="${not empty param.topic_disease}">
		  							<c:param name="topic_disease" value="${param.topic_disease}" />
		  						</c:if>
		  						<c:if test="${not empty param.labelwidth}">
		  							<c:param name="labelwidth" value="${param.labelwidth}" />
		  						</c:if>
		  						<c:if test="${not empty param.viz_height}">
		  							<c:param name="viz_height" value="${param.viz_height}" />
		  						</c:if>
							</c:url>
							<jsp:include page="${url}"/>
						</div>
					</c:if>
					
			<!-- Composite Panels ------------------------------------------------------------------------------------------------- -->
					<div class="row">
						
						
						<c:if test="${not empty param.severity_panel}">
							<c:url value="${param.severity_panel}" var="severity_url">
		 							<c:param name="panel" value="${param.severity_panel}" />
		 							<c:param name="block" value="${param.block}" />
		 							<c:param name="datatable_div" value="${param.datatable_div}" />
		 							<c:if test="${not empty param.topic_description}">
		 								<c:param name="topic_description" value="${param.topic_description}" />
		 							</c:if>
		 							<c:if test="${not empty param.topic_title}">
		 								<c:param name="topic_title" value="${param.topic_title}" />
		 							</c:if>
		 							<c:if test="${not empty param.severity_labelwidth}">
		 								<c:param name="label_width" value="${param.severity_labelwidth}" />
		 							</c:if>
		 							<c:if test="${not empty param.severity_height}">
		 								<c:param name="viz_height" value="${param.severity_height}" />
		 							</c:if>
							</c:url>
							<div class="col-12 col-md-6 small-viz-panel">
								<div id="${param.block}-severity" class="" src="<c:out value='${severity_url}'/>"></div>
							</div>
						</c:if>
						<c:if test="${not empty param.age_panel}">
							<c:url value="${param.age_panel}" var="age_url">
		  						<c:param name="panel" value="${param.age_panel}" />
		  						<c:param name="block" value="${param.block}" />
		  						<c:param name="datatable_div" value="${param.datatable_div}" />
		  						<c:if test="${not empty param.symptom}">
		  							<c:param name="symptom" value="${param.symptom}" />
		  						</c:if>
		  						<c:if test="${not empty param.age_labelwidth}">
		  							<c:param name="labelwidth" value="${param.age_labelwidth}" />
		  						</c:if>
		  						<c:if test="${not empty param.age_height}">
		  							<c:param name="viz_height" value="${param.age_height}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_description}">
		  							<c:param name="topic_description" value="${param.topic_description}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_disease}">
		  							<c:param name="topic_disease" value="${param.topic_disease}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_title}">
		  							<c:param name="topic_title" value="${param.topic_title}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_title2}">
		  							<c:param name="topic_title2" value="${param.topic_title2}" />
		  						</c:if>
							</c:url>
							<div class="col-12 col-md-6 small-viz-panel">
								<div id="${param.block}-age" class="" src="<c:out value='${age_url}'/>"></div>
							</div>
						</c:if>
						<c:if test="${not empty param.sex_panel}">
							<c:url value="${param.sex_panel}" var="sex_url">
		  						<c:param name="panel" value="${param.sex_panel}" />
		  						<c:param name="block" value="${param.block}" />
		  						<c:param name="datatable_div" value="${param.datatable_div}" />
		  						<c:if test="${not empty param.symptom}">
		  							<c:param name="symptom" value="${param.symptom}" />
		  						</c:if>
		  						<c:if test="${not empty param.sex_labelwidth}">
		  							<c:param name="labelwidth" value="${param.sex_labelwidth}" />
		  						</c:if>
		  						<c:if test="${not empty param.sex_height}">
		  							<c:param name="viz_height" value="${param.sex_height}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_description}">
		  							<c:param name="topic_description" value="${param.topic_description}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_disease}">
		  							<c:param name="topic_disease" value="${param.topic_disease}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_title}">
		  							<c:param name="topic_title" value="${param.topic_title}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_title2}">
		  							<c:param name="topic_title2" value="${param.topic_title2}" />
		  						</c:if>
							</c:url>
							<div class="col-12 col-md-6 small-viz-panel">
								<div id="${param.block}-sex" src="<c:out value='${sex_url}'/>"></div>
							</div>
						</c:if>
						<c:if test="${not empty param.race_panel}">
							<c:url value="${param.race_panel}" var="race_url">
		  						<c:param name="panel" value="${param.race_panel}" />
		  						<c:param name="block" value="${param.block}" />
		  						<c:param name="datatable_div" value="${param.datatable_div}" />
		  						<c:if test="${not empty param.symptom}">
		  							<c:param name="symptom" value="${param.symptom}" />
		  						</c:if>
		  						<c:if test="${not empty param.race_labelwidth}">
		  							<c:param name="labelwidth" value="${param.race_labelwidth}" />
		  						</c:if>
		  						<c:if test="${not empty param.race_height}">
		  							<c:param name="viz_height" value="${param.race_height}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_description}">
		  							<c:param name="topic_description" value="${param.topic_description}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_disease}">
		  							<c:param name="topic_disease" value="${param.topic_disease}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_title}">
		  							<c:param name="topic_title" value="${param.topic_title}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_title2}">
		  							<c:param name="topic_title2" value="${param.topic_title2}" />
		  						</c:if>
							</c:url>
							<div class="col-12 col-md-6 small-viz-panel">
								<div id="${param.block}-race" src="<c:out value='${race_url}'/>"></div>
							</div>
						</c:if>
						<c:if test="${not empty param.ethnicity_panel}">
							<c:url value="${param.ethnicity_panel}" var="ethnicity_url">
		  						<c:param name="panel" value="${param.ethnicity_panel}" />
		  						<c:param name="block" value="${param.block}" />
		  						<c:param name="datatable_div" value="${param.datatable_div}" />
		  						<c:if test="${not empty param.symptom}">
		  							<c:param name="symptom" value="${param.symptom}" />
		  						</c:if>
		  						<c:if test="${not empty param.ethnicity_labelwidth}">
		  							<c:param name="labelwidth" value="${param.ethnicity_labelwidth}" />
		  						</c:if>
		  						<c:if test="${not empty param.ethnicity_height}">
		  							<c:param name="viz_height" value="${param.ethnicity_height}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_description}">
		  							<c:param name="topic_description" value="${param.topic_description}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_disease}">
		  							<c:param name="topic_disease" value="${param.topic_disease}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_title}">
		  							<c:param name="topic_title" value="${param.topic_title}" />
		  						</c:if>
		  						<c:if test="${not empty param.topic_title2}">
		  							<c:param name="topic_title2" value="${param.topic_title2}" />
		  						</c:if>
							</c:url>
							<div class="col-12 col-md-6 small-viz-panel">
								<div id="${param.block}-ethnicity" src="<c:out value='${ethnicity_url}'/>"></div>
							</div>
						</c:if>
					</div>
					
					
					<c:if test="${not empty param.raceethncity_panel}">
						<c:url value="${param.raceethncity_panel}" var="raceethncity_url">
	  						<c:param name="panel" value="${param.raceethncity_panel}" />
	  						<c:param name="block" value="${param.block}" />
	  						<c:param name="datatable_div" value="${param.datatable_div}" />
	  						<c:if test="${not empty param.topic_description}">
	  							<c:param name="topic_description" value="${param.topic_description}" />
	  						</c:if>
	  						<c:if test="${not empty param.topic_title}">
	  							<c:param name="topic_title" value="${param.topic_title}" />
	  						</c:if>
						</c:url>
						<div id="${param.block}-raceethnicity" style="display: block;" src="<c:out value='${raceethncity_url}'/>"></div>
					</c:if>
					
					<c:if test="${not empty param.racesex_panel}">
						<c:url value="${param.racesex_panel}" var="racesex_url">
	  						<c:param name="panel" value="${param.racesex_panel}" />
	  						<c:param name="block" value="${param.block}" />
	  						<c:param name="datatable_div" value="${param.datatable_div}" />
	  						<c:if test="${not empty param.topic_description}">
	  							<c:param name="topic_description" value="${param.topic_description}" />
	  						</c:if>
	  						<c:if test="${not empty param.topic_title}">
	  							<c:param name="topic_title" value="${param.topic_title}" />
	  						</c:if>
						</c:url>
						<div id="${param.block}-racesex" style="display: block;" src="<c:out value='${racesex_url}'/>"></div>
					</c:if>
					
					
					
					<div class="row">
						<c:if test="${not empty param.topic_description}">
							<div id="viz_caption">
								<jsp:include page="${param.folder}/secondary_text/${param.topic_description}.jsp"/>
							</div>
						</c:if>
					</div>
	

<!-- other panel logic	--------------------------------->
					<c:if test="${not empty param.sotrovimab_panel1}">
						<c:url value="${param.sotrovimab_panel1}" var="sotrovimab1_url">
	  						<c:param name="panel" value="${param.sotrovimab_panel1}" />
	  						<c:param name="block" value="${param.block}" />
	  						<c:param name="datatable_div" value="${param.datatable_div}" />
	  						<c:if test="${not empty param.topic_description}">
	  							<c:param name="topic_description" value="${param.topic_description}" />
	  						</c:if>
	  						<c:if test="${not empty param.topic_title}">
	  							<c:param name="topic_title" value="${param.topic_title}" />
	  						</c:if>
						</c:url>
						<div id="${param.block}-sotrovimab1" style="display: none;" src="<c:out value='${sotrovimab1_url}'/>"></div>
					</c:if>
					
					<c:if test="${not empty param.sotrovimab_panel2}">
						<c:url value="${param.sotrovimab_panel2}" var="sotrovimab2_url">
	  						<c:param name="panel" value="${param.sotrovimab_panel2}" />
	  						<c:param name="block" value="${param.block}" />
	  						<c:param name="datatable_div" value="${param.datatable_div}" />
	  						<c:if test="${not empty param.topic_description}">
	  							<c:param name="topic_description" value="${param.topic_description}" />
	  						</c:if>
	  						<c:if test="${not empty param.topic_title}">
	  							<c:param name="topic_title" value="${param.topic_title}" />
	  						</c:if>
						</c:url>
						<div id="${param.block}-sotrovimab2" style="display: none;" src="<c:out value='${sotrovimab2_url}'/>"></div>
					</c:if>
					
					
					
				</div>
			
		<!-- DataTable --------------------------------------------------------------------------------------- -->	
				<div class="row">
					<c:if test="${not empty param.datatable}">
							<div class="col-12 ">
								<div class="block_header"></div>
								<div class="row">
									<div class="col-12 dash-dt-section" id="${param.datatable_div}"></div>
									<jsp:include page="${param.datatable}">
										<jsp:param name="feed" value="${param.datatable_feed}"/>
										<jsp:param name="target_div" value="${param.datatable_div}"/>
										<jsp:param name="target_kpis" value="${param.datatable_kpis}"/>
										<jsp:param name="target_kpis2" value="${param.datatable_kpis2}"/>
										<jsp:param name="target_filtered_kpis" value="${param.datatable_filtered_kpis}"/>
										<jsp:param name="block" value="${param.block}"/>
									</jsp:include>
								</div>
							</div>
						</c:if>
				</div>
				
				<c:if test="${not empty param.did}">
					<div class="row" id="question-limits">
						<sql:query var="questions" dataSource="jdbc/N3CPublic">
							select limitations from n3c_dashboard.dashboard where did = ?::INTEGER
							 <sql:param>${param.did}</sql:param>
	 					</sql:query>
						<c:forEach items="${questions.rows}" var="row" varStatus="rowCounter">
							<div id="limitations-section" class="col col-12">
								<div class="accordion" id="limitations_drop">
									<div class="card">
										<a Title="expand/collapse limitations section" href="" class="accordion-toggle" data-toggle="collapse" data-target="#limitcollapseOne" aria-expanded="false" aria-controls="collapseOne">
											<div class="card-header" id="limitheadingOne">
												<h4 class="mb-0"><span class="accordion_text">Limitations</span>
													<span style="display:inline; float:right;" class="btn btn-link btn-block text-left collapsed icon-btn p-0 accordion-toggle"></span>
												</h4>
											</div>
										</a>
										<div id="limitcollapseOne" class="collapse" aria-labelledby="limitheadingOne" data-parent="#limitations_drop">
											<div class="card-body">
												${row.limitations}
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:if>
				
				
			</div>
		</div>
	</div>
</div>			

<script>

function limitlink(){
	$('#limitcollapseOne').collapse('show');
	$('html, body').animate({
        scrollTop: $("#limitations-section").offset().top
    }, 500);
}


	$(document).ready(function() {
	    
	    setTimeout(function() {
			if ('${param.block}' === 'peds_summary_2' || '${param.block}' === 'adult_summary_2' || '${param.block}' === 'all_summary_2') {
				$('#${param.block}-vaccinated-select').multiselect('select', 'True', true);
				${param.block}_refreshHistograms();
				${param.block}_constrain_table();
				$(".viz_info_box .filter_info" ).append('<small class="vaccine_search_indicator"><i class="fas fa-info-circle"></i> Vaccination Status is defaulted to True. Clear filters to reset.</small>');
				$(".viz_info_box").removeClass('no_clear');
				$(".viz_info_box .close" ).on('click', function() {
					$(".viz_info_box").addClass('no_clear');
				});
				
			};
			if ('${param.block}' === 'reinfection_ts_1') {
				update(new Date('Feb 1 2022 1:00:00 CST'));
				sliderTime.value(new Date('Feb 1 2022').valueOf());
			};
	    }, 1000);
	    
	    
// initiate the filters /////////////////////////////////////////
	
		$('#${param.block}-severity-select').multiselect({	
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-severity-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
		        
				${param.block}_constrain("severity",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		$('#${param.block}-age-select').multiselect({
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-age-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
		        
				${param.block}_constrain("age",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		
		$('#${param.block}-race-select').multiselect({
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-race-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
		        
				${param.block}_constrain("race",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		$('#${param.block}-sex-select').multiselect({
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-sex-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
		        
				${param.block}_constrain("sex",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();

            }
		});
		$('#${param.block}-ethnicity-select').multiselect({	
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-ethnicity-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
		        
				${param.block}_constrain("ethnicity",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		$('#${param.block}-smokingstatus-select').multiselect({
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-smokingstatus-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
		        
		        ${param.block}_constrain("smokingstatus",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-medications-select').multiselect({	
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-medications-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("medication",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-region-select').multiselect({
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-region-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("region",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-intervalbin-select').multiselect({
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			maxHeight: 300,
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-intervalbin-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("intervalbin",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-medication-class-select').multiselect({	
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			maxHeight: 300,
			numberDisplayed: 1,
			enableCaseInsensitiveFiltering: true,
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-medication-class-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("drug_domain",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-medication-select').multiselect({	
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			maxHeight: 300,
			numberDisplayed: 1,
			enableCaseInsensitiveFiltering: true,
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-medication-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("concept_set_name",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-delay-select').multiselect({	
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			maxHeight: 300,
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-delay-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("delay",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-diagnosis-select').multiselect({	
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-diagnosis-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("diagnosis_type",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-numberofcomorbidities-select').multiselect({	
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			maxHeight: 300,
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-numberofcomorbidities-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("comorbidity_number",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-vaccinationstatus-select').multiselect({
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-vaccinationstatus-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
		        
				${param.block}_constrain("vaccinated", selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-sotrovimaboccurrence-select').multiselect({	
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-sotrovimaboccurrence-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("sotrovimaboccurrence",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-othermeds-select').multiselect({	
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			maxHeight: 300,
			numberDisplayed: 1,
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-othermeds-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("medications",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-symptom-select').multiselect({
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-symptom-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
		        
				${param.block}_constrain("symptom",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
		$('#${param.block}-symptomoccurrence-select').multiselect({	
			buttonContainer: '<div class="checkbox-list-container"></div>',
            buttonClass: '',
            templates: {
                button: '',
                popupContainer: '<div class="multiselect-container checkbox-list"></div>',
                li: '<a class="multiselect-option text-dark text-decoration-none"></a>'
            },
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-symptomoccurrence-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("beforeafter",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		
// old multiselects //////////////////////////////////////////////
		$('#${param.block}-vaccinated-select').multiselect({
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-vaccinated-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
		        
				${param.block}_constrain("vaccinated", selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		$('#${param.block}-comorbidities-select').multiselect({	
			maxHeight: 300,
			enableCaseInsensitiveFiltering: true,
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-comorbidities-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("comorbidities",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
		$('#${param.block}-testresult-select').multiselect({	
			onChange: function(option, checked, select) {
				var options = $('#${param.block}-testresult-select');
		        var selected = [];
		        $(options).each(function(){
		            selected.push($(this).val());
		        });
				${param.block}_constrain("result",  selected[0].join('|'));
			    ${param.block}_refreshHistograms();
            }
		});
	
		
		
		
		
		
// show/hide clear filters button //////////////////////////////////////////////
		var mut = new MutationObserver(function(mutations, mut){
			if($('#${param.block}-block-kpi').find('.dropdown-item.active').length !== 0){
				$('#${param.block}_btn_clear').removeClass("no_clear");
				$('#${param.block}_btn_clear').addClass("show_clear");
			} else if ($('#${param.datatable_div}-table').DataTable().search().length > 0){
				// leave things alone, there's an active search
				// console.log("active search box", $('#${param.datatable_div}-table').DataTable().search())
			} else {
				$('#${param.block}_btn_clear').removeClass("show_clear");
				$('#${param.block}_btn_clear').addClass("no_clear");
			}
		});
		$( "#${param.block}-block-kpi .checkbox-list button").each(function() {
			mut.observe(this,{
				'attributes': true,
				attributeFilter: ['class']
			});
		}); 
	
	});
	// end of doc ready
	
	
	
	
// FILTER FUNCTIONS /////////////////////////////
	function deselect(checkid){
		$('#' + checkid + ' input[type="checkbox"]:checked').prop('checked',false).trigger('change');
	};
		
	function selectall(checkid){
		$('#' + checkid + ' input[type="checkbox"]').prop('checked',true).trigger('change');
	};

	
	
	function ${param.block}_viz_constrain(element, elementParent) {
		var options = $("#${param.block}-"+elementParent.toLowerCase()+"-select");
        var selected = [];
        
        $(options).each(function(){
            selected.push($(this).val());
        });
	       
		if (selected[0].includes( element.secondary_name)){
			$("#${param.block}-"+elementParent.toLowerCase()+"-select").multiselect('deselect', $("#${param.block}-"+elementParent.toLowerCase()+"-select option[value='" + element.secondary_name + "']").val(), true);
		} else {
			$("#${param.block}-"+elementParent.toLowerCase()+"-select").multiselect('select', $("#${param.block}-"+elementParent.toLowerCase()+"-select option[value='" + element.secondary_name + "']").val(), true);
		}
	}

	function ${param.block}_constrain(filter, selection) {
		var selected = selection;
		if (selected != undefined && selected.length > 0){
			var values = selected.split("|");
			var text = "";
			for (let i = 0; i < values.length; ++i) {
				var clean_text = values[i].replace("+", "\\+");

				if (i < (values.length-1)){
		    		search = "^" + clean_text + "$|";
				} else {
					search = "^" + clean_text + "$";
				}
		    	text = text.concat(search);
			}
			selected = text;
		}else{
			selected = '';
		}
		${param.block}_constrain_table(filter, selected);
	}

	function ${param.block}_filter_clear() {
		
		$('#${param.block}_btn_clear').removeClass("show_clear");
		$('#${param.block}_btn_clear').addClass("no_clear");

		<c:if test="${param.severity_filter}">
			$('#${param.block}-severity-select').multiselect('clearSelection');
			${param.block}_constrain("severity", '');
		</c:if>
		<c:if test="${param.age_filter || param.age_filter2 || param.age_filter4 || param.age_filter5 || param.age_filter6 || param.age_filter7 || param.age_filter10 || param.age_filterpeds || param.age_filterpeds2 || param.age_filterall || param.age_filterall2}">
			$('#${param.block}-age-select').multiselect('clearSelection');
			${param.block}_constrain("age", '');
		</c:if>
		<c:if test="${param.race_filter}">
			$('#${param.block}-race-select').multiselect('clearSelection');
			${param.block}_constrain("race", '');
		</c:if>
		<c:if test="${param.sex_filter3 || param.sex_filter}">
			$('#${param.block}-sex-select').multiselect('clearSelection');
			${param.block}_constrain("sex", '');
		</c:if>
		<c:if test="${param.ethnicity_filter}">
			$('#${param.block}-ethnicity-select').multiselect('clearSelection');
			${param.block}_constrain("ethnicity", '');
		</c:if>
		<c:if test="${param.symptom_filter}">
			$('#${param.block}-symptom-select').multiselect('clearSelection');
			${param.block}_constrain("symptom", '');
		</c:if>
		<c:if test="${param.vaccinated_filter}">
			$('#${param.block}-vaccinated-select').multiselect('clearSelection');
			${param.block}_constrain("vaccinated", '');
		</c:if>
		<c:if test="${param.vaccinated_filter2}">
			$('#${param.block}-vaccinationstatus-select').multiselect('clearSelection');
			${param.block}_constrain("vaccinated", '');
		</c:if>
		<c:if test="${param.comorbidities_filter}">
			$('#${param.block}-comorbidities-select').multiselect('clearSelection');
			${param.block}_constrain("comorbidities", '');
		</c:if>
		<c:if test="${param.beforeafter_filter}">
			$('#${param.block}-symptomoccurrence-select').multiselect('clearSelection');
			${param.block}_constrain("beforeafter", '');
		</c:if>
		<c:if test="${param.beforeaftersotrovimab_filter}">
			$('#${param.block}-sotrovimaboccurrence-select').multiselect('clearSelection');
			${param.block}_constrain("sotrovimaboccurrence", '');
		</c:if>
		<c:if test="${param.result_filter}">
			$('#${param.block}-testresult-select').multiselect('clearSelection');
			${param.block}_constrain("result", '');
		</c:if>
		<c:if test="${param.delay_filter}">
			$('#${param.block}-delay-select').multiselect('clearSelection');
			${param.block}_constrain("delay", '');
		</c:if>
		<c:if test="${param.diagnosis_filter}">
			$('#${param.block}-diagnosis-select').multiselect('clearSelection');
			${param.block}_constrain("diagnosis_type", '');
		</c:if>
		<c:if test="${param.diagnosis_filter2}">
		$('#${param.block}-diagnosis-select').multiselect('clearSelection');
		${param.block}_constrain("diagnosis_type", '');
	</c:if>
		<c:if test="${param.comorbiditynumber_filter}">
			$('#${param.block}-numberofcomorbidities-select').multiselect('clearSelection');
			${param.block}_constrain("comorbidity_number", '');
		</c:if>
		<c:if test="${param.sotrovimabmeds_filter}">
			$('#${param.block}-othermeds-select').multiselect('clearSelection');
			${param.block}_constrain("medications", '');
		</c:if>
		<c:if test="${param.medication_filter}">
			$('#${param.block}-medication-select').multiselect('clearSelection');
			${param.block}_constrain("concept_set_name", '');
		</c:if>
		<c:if test="${param.medication_class_filter}">
			$('#${param.block}-medication-class-select').multiselect('clearSelection');
			${param.block}_constrain("drug_domain", '');
		</c:if>
		<c:if test="${param.medications_filter}">
			$('#${param.block}-medications-select').multiselect('clearSelection');
			${param.block}_constrain("medication", '');
		</c:if>
		<c:if test="${param.smoking_filter}">
			$('#${param.block}-smokingstatus-select').multiselect('clearSelection');
			${param.block}_constrain("smokingstatus", '');
		</c:if>
		<c:if test="${param.region_filter}">
			$('#${param.block}-region-select').multiselect('clearSelection');
			${param.block}_constrain("region", '');
		</c:if>
		<c:if test="${param.reinfectionbin_filter}">
			$('#${param.block}-intervalbin-select').multiselect('clearSelection');
			${param.block}_constrain("intervalbin", '');
		</c:if>

		
		
		$("#${param.datatable_div}-table").DataTable().search('');
		$("#${param.datatable_div}-table").DataTable().columns().search('').draw();
	    ${param.block}_refreshHistograms();
	}
	
	
	
	
	
	// initialize all possible data arrays
	var ${param.block}_AgeArray = new Array();
	var ${param.block}_RaceArray = new Array();
	var ${param.block}_EthnicityArray = new Array();
	var ${param.block}_SexArray = new Array();
	var ${param.block}_SeverityArray = new Array();
	var ${param.block}_DelayArray = new Array();
	
	var ${param.block}_raceSeverityArray = new Array();
	var ${param.block}_diagnosisSeverityArray = new Array();
	var ${param.block}_comorbiditySeverityArray = new Array();
	var ${param.block}_vaccinatedSeverityArray = new Array();
	var ${param.block}_medsSeverityArray = new Array();
	var ${param.block}_sotrovimabMedsArray = new Array();
	var ${param.block}_raceEthnicityArray = new Array();
	var ${param.block}_raceSexArray = new Array();
	
	var ${param.block}_comorbidityArray = new Array();
	
	var ${param.block}_ObservationArray = new Array();
	
	var ${param.block}_BeforeAfterArray = new Array();

	var ${param.block}_SexSeverityArray = new Array();
	var ${param.block}_SeveritySexArray = new Array();
	

	var ${param.block}_SeverityRegionArray = new Array();
	
	var ${param.block}_ObservationAgeArray = new Array();
	var ${param.block}_ObservationSexArray = new Array();
	var ${param.block}_ObservationRaceArray = new Array();
	var ${param.block}_IbservationEthnicityArray = new Array();
	
	var ${param.block}_SymptomAgeArray = new Array();
	var ${param.block}_SymptomSexArray = new Array();
	var ${param.block}_SymptomRaceArray = new Array();
	var ${param.block}_SymptomEthnicityArray = new Array();
	var ${param.block}_SymptomObservationArray = new Array();
	

	var ${param.block}_MedicationArray = new Array();
	var ${param.block}_MedicationAgeArray = new Array();
	var ${param.block}_ClassAgeArray = new Array();
	var ${param.block}_DiabetesArray = new Array();

	var ${param.block}_AgeSexArray = new Array();
	var ${param.block}_SexAgeArray = new Array();

	var ${param.block}_SeverityStatusArray = new Array();
	var ${param.block}_AgeStatusArray = new Array();
	var ${param.block}_RaceStatusArray = new Array();
	var ${param.block}_SexStatusArray = new Array();

	var ${param.block}_AgeResultArray = new Array();
	var ${param.block}_SexResultArray = new Array();
	var ${param.block}_RaceResultArray = new Array();
	var ${param.block}_EthnicityResultArray = new Array();
	var ${param.block}_CategoryResultArray = new Array();

	var ${param.block}_InitialCountSevenArray = new Array();
	var ${param.block}_IntervalBinArray = new Array();
	
	var ${param.block}_MedicationTSArray = new Array();
	var ${param.block}_MedicationOverallArray = new Array();

	function ${param.block}_refreshHistograms(just_viz) {
	    if (typeof just_viz === 'undefined'){
	    	var data = $("#${param.datatable_div}-table").DataTable().rows({search:'applied'}).data().toArray();
	 	    var data2 = $("#${param.datatable_div}-table").DataTable().rows({search:'applied'}).data();
	 	    
	    	${param.block}_refreshAgeArray(data);
	    	${param.block}_refreshRaceArray(data);
	    	${param.block}_refreshEthnicityArray(data);
	    	${param.block}_refreshSexArray(data);
	    	${param.block}_refreshSeverityArray(data);
	    	${param.block}_refreshDelayArray(data);
	    
	    	${param.block}_refreshraceSeverityArray(data);
	    	${param.block}_refreshdiagnosisSeverityArray(data);
	    	${param.block}_refreshcomorbiditySeverityArray(data);
	    	${param.block}_refreshvaccinatedSeverityArray(data);
	    	${param.block}_refreshmedsSeverityArray(data);
	    	${param.block}_refreshsotrovimabMedsArray(data);
	    	${param.block}_refreshraceEthnicityArray(data);
	    	${param.block}_refreshraceSexArray(data);

	    	${param.block}_refreshcomorbidityArray(data);
	    
	    	${param.block}_refreshObservationArray(data);
		    
	    	${param.block}_refreshBeforeAfterArray(data);
	    
	    	${param.block}_refreshSexSeverityArray(data);
	    	${param.block}_refreshSeveritySexArray(data);
	    	${param.block}_refreshObservationAgeArray(data);
	    	${param.block}_refreshObservationSexArray(data);
	    	${param.block}_refreshObservationRaceArray(data);
	    	${param.block}_refreshObservationEthnicityArray(data);
	    	
	    	${param.block}_refreshSeverityRegionArray(data);

	    	${param.block}_refreshSymptomAgeArray(data);
	    	${param.block}_refreshSymptomSexArray(data);
	    	${param.block}_refreshSymptomRaceArray(data);
	    	${param.block}_refreshSymptomEthnicityArray(data);
	    	${param.block}_refreshSymptomObservationArray(data);
	    
	    	${param.block}_refreshMedicationArray(data2);
	    	${param.block}_refreshMedicationAgeArray(data);
	    	${param.block}_refreshClassAgeArray(data);
	    	${param.block}_refreshDiabetesArray(data2);
	    
	    	${param.block}_refreshAgeSexArray(data2);
	    	${param.block}_refreshSexAgeArray(data2);
	    
	    	${param.block}_refreshSeverityStatusArray(data);
	    	${param.block}_refreshstatusArray(data);
	    
	    	${param.block}_refreshAgeResultArray(data);
	    	${param.block}_refreshSexResultArray(data);
	    	${param.block}_refreshRaceResultArray(data);
	    	${param.block}_refreshEthnicityResultArray(data);
	    	${param.block}_refreshCategoryResultArray(data);

	    	${param.block}_refreshInitialCountSevenArray(data);
	    	${param.block}_refreshIntervalBinArray(data);

	    	${param.block}_refreshMedicationTSArray(data);
	    	${param.block}_refreshMedicationOverallArray(data);
	    };
    	
	    
	    if ('${param.block}' === 'long_covid_6') {
	    	${param.block}_before_refresh();
	    }
	    if (${param.block}_loaded("observation")) {
	    	${param.block}_observation_refresh();
	    }
	    if (${param.block}_loaded("severity")) {
	    	${param.block}_severity_refresh();
	    }
	    if (${param.block}_loaded("age")) {
	    	console.log('loaded age');
	    	${param.block}_age_refresh();
	    }
	    if (${param.block}_loaded("race")) {
	    	${param.block}_race_refresh();
	    }
	    if (${param.block}_loaded("sex")) {
	    	${param.block}_sex_refresh();
	    }
	    if (${param.block}_loaded("ethnicity")) {
	    	${param.block}_ethnicity_refresh();
	    }
	    if ('${param.block}' === "medications_1") {
	    	${param.block}_medication_refresh();
	    }
	    if ('${param.block}' === "medications_2") {
	    	${param.block}_class_refresh();
	    }
	    if ('${param.block}' === "medications_3") {
	    	${param.block}_medication_refresh();
	    }
	    if (${param.block}_loaded("raceseverity")) {
	    	${param.block}_raceseverity_refresh();
	    }
	    if (${param.block}_loaded("comorbidity")) {
	    	${param.block}_comorbidity_refresh();
	    }  
	    if (${param.block}_loaded("raceethnicity")) {
	    	${param.block}_raceethnicity_refresh();
	    }  
	    if (${param.block}_loaded("racesex")) {
	    	${param.block}_racesex_refresh();
	    }  
	    if (${param.block}_loaded("result")) {
	    	${param.block}_result_refresh();
	    }  
	    if ('${param.block}' === 'paxlovid_3') {
	    	${param.block}_visits_refresh();
	    }
	    if ('${param.block}' === 'mortality_2') {
	    	${param.block}_delay_refresh();
	    }
	    if ('${param.block}' === 'med_snap_2') {
	    	${param.block}_severitydiagnosis_refresh();
	    }
	    if ('${param.block}' === 'med_snap_4') {
	    	${param.block}_severitycomorbidity_refresh();
	    }
	    if ('${param.block}' === 'med_snap_5') {
	    	${param.block}_severityvaccinated_refresh();
	    }
	    if ('${param.block}' === 'med_snap_3') {
	    	${param.block}_sotrovimab1_refresh();
	    	${param.block}_sotrovimab2_refresh();
	    }
	    if ('${param.block}' === "diabetes_1" || '${param.block}' === "diabetes_2") {
	    	${param.block}_refresh();
	    }
	    if ('${param.block}' === "severity_region_1") {
	    	${param.block}_region_refresh();
	    }
	    if ('${param.block}'.includes('hlh')) {
	    	${param.block}_age_refresh();
	    	${param.block}_sex_refresh();
	    }
	    if ('${param.block}' === "long_covid_2" || '${param.block}' === "long_covid_13") {
	    	${param.block}_severity_refresh();
	    	${param.block}_sex_refresh();
	    }
	    if (["long_covid_3", "long_covid_4", "long_covid_5", "long_covid_7", "long_covid_8", "long_covid_9", "long_covid_10", "long_covid_11"].includes('${param.block}')) {
	    	${param.block}_age_refresh();
	    	${param.block}_race_refresh();
	    	${param.block}_sex_refresh();
	    	${param.block}_ethnicity_refresh();
	    }
	  }
	
	// new load function for composite views
	function ${param.block}_panel(selection) {
		for (i in selection){
			${param.block}_load(selection[i]);
		}
	};


	// manage incremental loading of panels on inner nav bar clicks
	var ${param.block}_crumbs = [];
	
	function ${param.block}_load(selection) {
		var $this = $("#${param.block}-"+selection);
		var which = $this.attr('src');

		//// console.log("in main click", "${param.block}-"+selection, "which", which)
		if (!${param.block}_crumbs.includes(selection)) {
			$this.load("<util:applicationRoot/>/new_ph/"+which);
			${param.block}_crumbs.push(selection);
		}
	};
	
	function ${param.block}_loaded(selection) {
		return ${param.block}_crumbs.includes(selection);
	}
</script>

<jsp:include page="singleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="AgeArray"/>
	<jsp:param name="primary" value="age"/>
	<jsp:param name="count" value="patient_count"/>
</jsp:include>

<jsp:include page="singleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="RaceArray"/>
	<jsp:param name="primary" value="race"/>
	<jsp:param name="count" value="patient_count"/>
</jsp:include>

<jsp:include page="singleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SexArray"/>
	<jsp:param name="primary" value="sex"/>
	<jsp:param name="count" value="patient_count"/>
</jsp:include>

<jsp:include page="singleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="EthnicityArray"/>
	<jsp:param name="primary" value="ethnicity"/>
	<jsp:param name="count" value="patient_count"/>
</jsp:include>

<jsp:include page="singleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SeverityArray"/>
	<jsp:param name="primary" value="severity"/>
	<jsp:param name="count" value="patient_count"/>
</jsp:include>

<jsp:include page="singleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="DelayArray"/>
	<jsp:param name="primary" value="datediff_bw_death_and_hos"/>
	<jsp:param name="count" value="patient_count"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="BeforeAfterArray"/>
	<jsp:param name="primary" value="symptom"/>
	<jsp:param name="secondary" value="condition_after_covid_positive"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="raceSeverityArray"/>
	<jsp:param name="primary" value="race"/>
	<jsp:param name="secondary" value="severity"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="raceEthnicityArray"/>
	<jsp:param name="primary" value="race"/>
	<jsp:param name="secondary" value="ethnicity"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="raceSexArray"/>
	<jsp:param name="primary" value="race"/>
	<jsp:param name="secondary" value="sex"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="diagnosisSeverityArray"/>
	<jsp:param name="primary" value="severity"/>
	<jsp:param name="secondary" value="diagnosis"/>
</jsp:include>


<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="comorbiditySeverityArray"/>
	<jsp:param name="primary" value="severity"/>
	<jsp:param name="secondary" value="numberofcomorbidities"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="medsSeverityArray"/>
	<jsp:param name="primary" value="severity"/>
	<jsp:param name="secondary" value="sotrovimaboccurrence"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="sotrovimabMedsArray"/>
	<jsp:param name="primary" value="medications"/>
	<jsp:param name="secondary" value="sotrovimaboccurrence"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="vaccinatedSeverityArray"/>
	<jsp:param name="primary" value="severity"/>
	<jsp:param name="secondary" value="vaccinated"/>
</jsp:include>

<jsp:include page="singleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="comorbidityArray"/>
	<jsp:param name="primary" value="comorbidity"/>
	<jsp:param name="count" value="patient_count"/>
</jsp:include>

<jsp:include page="singleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="ObservationArray"/>
	<jsp:param name="primary" value="observation"/>
	<jsp:param name="count" value="patient_count"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SexSeverityArray"/>
	<jsp:param name="primary" value="sex"/>
	<jsp:param name="primary_abbrev" value="sex_abbrev"/>
	<jsp:param name="secondary" value="severity"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SeveritySexArray"/>
	<jsp:param name="primary" value="severity"/>
	<jsp:param name="primary_abbrev" value="severity_abbrev"/>
	<jsp:param name="secondary" value="sex"/>
</jsp:include>

<jsp:include page="singleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SeverityRegionArray"/>
	<jsp:param name="primary" value="region"/>
	<jsp:param name="count" value="patient_count"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="ObservationAgeArray"/>
	<jsp:param name="primary" value="observation"/>
	<jsp:param name="secondary" value="age"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="ObservationSexArray"/>
	<jsp:param name="primary" value="observation"/>
	<jsp:param name="secondary" value="sex"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="ObservationRaceArray"/>
	<jsp:param name="primary" value="observation"/>
	<jsp:param name="secondary" value="race"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="ObservationEthnicityArray"/>
	<jsp:param name="primary" value="observation"/>
	<jsp:param name="secondary" value="ethnicity"/>
</jsp:include>


<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SymptomAgeArray"/>
	<jsp:param name="primary" value="symptom"/>
	<jsp:param name="secondary" value="age"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SymptomSexArray"/>
	<jsp:param name="primary" value="symptom"/>
	<jsp:param name="secondary" value="sex"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SymptomRaceArray"/>
	<jsp:param name="primary" value="symptom"/>
	<jsp:param name="secondary" value="race"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SymptomEthnicityArray"/>
	<jsp:param name="primary" value="symptom"/>
	<jsp:param name="secondary" value="ethnicity"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SymptomObservationArray"/>
	<jsp:param name="primary" value="symptom"/>
	<jsp:param name="secondary" value="observation"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="AgeResultArray"/>
	<jsp:param name="primary" value="age"/>
	<jsp:param name="secondary" value="result"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SexResultArray"/>
	<jsp:param name="primary" value="sex"/>
	<jsp:param name="secondary" value="result"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="RaceResultArray"/>
	<jsp:param name="primary" value="race"/>
	<jsp:param name="secondary" value="result"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="EthnicityResultArray"/>
	<jsp:param name="primary" value="ethnicity"/>
	<jsp:param name="secondary" value="result"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="CategoryResultArray"/>
	<jsp:param name="primary" value="category"/>
	<jsp:param name="secondary" value="result"/>
</jsp:include>

<jsp:include page="tripleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="MedicationArray"/>
	<jsp:param name="wrap" value="no"/>
	<jsp:param name="primary" value="drug_domain"/>
	<jsp:param name="secondary" value="concept_set_name"/>
	<jsp:param name="tertiary" value="age"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="MedicationAgeArray"/>
	<jsp:param name="primary" value="concept_set_name"/>
	<jsp:param name="secondary" value="age"/>
	<jsp:param name="sort_desc" value="count"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="ClassAgeArray"/>
	<jsp:param name="primary" value="drug_domain"/>
	<jsp:param name="secondary" value="age"/>
	<jsp:param name="sort_desc" value="count"/>
</jsp:include>

<jsp:include page="tripleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="DiabetesArray"/>
	<jsp:param name="primary" value="observation"/>
	<jsp:param name="secondary" value="sex"/>
	<jsp:param name="tertiary" value="age"/>
</jsp:include>

<jsp:include page="tripleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="AgeSexArray"/>
	<jsp:param name="wrap" value="no"/>
	<jsp:param name="primary" value="observation"/>
	<jsp:param name="secondary" value="age"/>
	<jsp:param name="tertiary" value="sex"/>
</jsp:include>

<jsp:include page="tripleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SexAgeArray"/>
	<jsp:param name="wrap" value="no"/>
	<jsp:param name="primary" value="observation"/>
	<jsp:param name="secondary" value="sex"/>
	<jsp:param name="tertiary" value="age"/>
</jsp:include>

<jsp:include page="doubleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="SeverityStatusArray"/>
	<jsp:param name="primary" value="severity"/>
	<jsp:param name="secondary" value="smoking_status"/>
</jsp:include>

<jsp:include page="tripleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="statusArray"/>
	<jsp:param name="wrap" value="no"/>
	<jsp:param name="primary" value="observation"/>
	<jsp:param name="secondary" value="sex"/>
	<jsp:param name="tertiary" value="age"/>
</jsp:include>

<jsp:include page="timeline2Histogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="InitialCountSevenArray"/>
</jsp:include>

<jsp:include page="singleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="IntervalBinArray"/>
	<jsp:param name="primary" value="interval_bin"/>
	<jsp:param name="count" value="actual_count"/>
</jsp:include>

<jsp:include page="timelineNHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="MedicationTSArray"/>
</jsp:include>

<jsp:include page="singleHistogram.jsp">
	<jsp:param name="block" value="${param.block}"/>
	<jsp:param name="datatable_div" value="${param.datatable_div}"/>
	<jsp:param name="array" value="MedicationOverallArray"/>
	<jsp:param name="primary" value="medication"/>
	<jsp:param name="count" value="count"/>
</jsp:include>
