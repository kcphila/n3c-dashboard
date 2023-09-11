<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<jsp:include page="../../resources/dash_style.css" flush="true" />


<style>
.summary table.dataTable.compact tbody th, 
.summary table.dataTable.compact tbody td{
	padding-top: 0px;
	padding-bottom: 0px;
}

.summary .table th, .table td, 
.summary table.dataTable thead th, table.dataTable thead td{
	border-bottom: 2px solid #e9e9e9;
	border-top: 0px;
}

.feature_sub_heading{
	font-weight: 400;
	color: #3f3f3f;
}

.summary .viz_footer {
    color: #616161;
    font-size: 0.9rem;
    margin-top: 10px;
}

.summary_heading{
	padding-bottom: 10px; 
	padding-top: 10px; 
	display: inline-block;
}

.color_header2{
	font-weight: 600;
	font-size: 1.2rem;
}

.limitation_link{
    text-decoration: underline;
}

.summary_description{
	padding: 20px;
	background: #edf6ff;
}
</style>


<div class="row stats block2 mx-auto summary">
	<div class="col-12">
		<div class="row mt-4">
			<div class="col-12 col-lg-6 text-center summary_description" >
				<h4 class="text-center mt-2 color_header2">What is PPRL?</h4>
				<p style="text-align: left;">Privacy-Preserving Record Linkage (PPRL) enables N3C to ingest and link supplemental 
				datasets against the OMOP-formatted EHR data in the Enclave. PPRL currently supports linking EHR records to CMS 
				(Medicare & Medicaid), mortality information from government agencies, and viral variant information from sequencing centers.</p>
				<a class="btn btn-dash" href="https://covid.cd2h.org/PPRL" target="_blank">Learn More <i class="fas fa-external-link-alt"></i></a>
			</div>
			<div class="col-12 col-lg-6">
				<h4 class="text-center mb-2 color_header2">How Much Data is Associated with PPRL?</h4>
				<div class="row feature_viz_section">
					<div class="col-12 mx-auto" id="pprl">
						<h5 class="text-center mb-2 feature_sub_heading">Total Number of Patients from Each Supplemental Source</h5>
						<div id="pprl_viz"></div>
						<jsp:include page="pprl_summary_block_vizs/pprl_bar.jsp">
							<jsp:param name="graph_element" value="pprl_viz" />
							<jsp:param name="container" value="pprl" />
							<jsp:param name="feed" value="cms_bar_feed.jsp" />
							<jsp:param name="color_left" value="#33298D" />
							<jsp:param name="color_right" value="#3F50B0" />
							<jsp:param name="min_height" value="150" />
						</jsp:include>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="col-12 mt-5">
		<div class="row mb-4">
			<div class="col-12" id="medicare">
				<h4 class="text-center mt-2 color_header2 mx-auto">How Much Data Has Medicare Added?</h4>
				<h5 class="text-center mb-2 feature_sub_heading">Average Number of Records Added Per Patient Linked to Medicare Through PPRL</h5>
				<div id="medicare_viz"></div>
				<jsp:include page="pprl_summary_block_vizs/medicare_table.jsp">
					<jsp:param name="target_div" value="medicare_viz" />
				</jsp:include>
				<p class="viz_footer"><strong>Sample:</strong> Patients in the N3C Data Enclave who have been linked to Medicare data through PPRL. <br>
				An * indicates that these numbers have the possibility of changing based on new data generated in planned future raw data analysis.</p>
			</div>
		</div>
			
		<div class="row mb-4">
			<div class="col-12" id="medicaid">
				<h4 class="text-center mt-2 color_header2 mx-auto">How Much Data Has Medicaid Added?</h4>
				<h5 class="text-center mb-2 feature_sub_heading">Average Number of Records Added Per Patient Linked to Medicaid Through PPRL</h5>
				<div id="medicaid_viz"></div>
				<jsp:include page="pprl_summary_block_vizs/medicaid_table.jsp">
					<jsp:param name="target_div" value="medicaid_viz" />
				</jsp:include>
				<p class="viz_footer"><strong>Sample:</strong> Patients in the N3C Data Enclave who have been linked to Medicaid data through PPRL. <br>
				An * indicates that these numbers have the possibility of changing based on new data generated in planned future raw data analysis.</p>
			</div>
		</div>
		
		<div class="row mb-4">
			<div class="col-12" id="mortality">
				<h4 class="text-center mt-2 color_header2 mx-auto">How Much Data Has Mortality Added?</h4>
				<h5 class="text-center mb-2 feature_sub_heading">Number of Mortality Records Added Through PPRL</h5>
				<div id="mortality_viz"></div>
				<jsp:include page="pprl_summary_block_vizs/mortality_table.jsp">
					<jsp:param name="target_div" value="mortality_viz" />
				</jsp:include>
				<p class="viz_footer"><strong>Sample:</strong> Patients in the N3C Data Enclave who have been linked to Mortality data through PPRL.</p>
			</div>
		</div>
		
		<div class="row mb-4">
			<div class="col-12" id="viral">
				<h4 class="text-center mt-2 color_header2 mx-auto">How Much Data Data Has Viral Variants Added?</h4>
				<h5 class="text-center mb-2 feature_sub_heading">Number of Enclave Patients Mapped into PPRL Viral Variant Data</h5>
			</div>
			<div class="col-12" id="viral_table">
				<div id="viral_viz_table"></div>
				<jsp:include page="pprl_summary_block_vizs/viral_table.jsp">
					<jsp:param name="target_div" value="viral_viz_table" />
				</jsp:include>
				<p class="viz_footer"><strong>Sample:</strong> Patients in the N3C Data Enclave who have been linked to Viral Variant data through PPRL.</p>
			</div>
		</div>
			
		
	</div>
</div>		
<c:if test="${not empty param.did}">
	<div class="row" id="question-limits">
		<sql:query var="questions" dataSource="jdbc/N3CPublic">
			select limitations from n3c_dashboard.dashboard where did = ?::INTEGER
			 <sql:param>${param.did}</sql:param>
			</sql:query>
		<c:forEach items="${questions.rows}" var="row" varStatus="rowCounter">
			<div id="${param.block}limitations-section" class="col col-12">
				<div class="accordion limitations_drop" id="${param.block}limitations_drop">
					<div class="card">
						<a Title="expand/collapse limitations section" href="" class="accordion-toggle" data-toggle="collapse" data-target="#${param.block}limitcollapseOne" aria-expanded="false" aria-controls="${param.block}collapseOne">
							<div class="card-header" id="${param.block}limitheadingOne">
								<h4 class="mb-0"><span class="accordion_text">Limitations</span>
									<span style="display:inline; float:right;" class="btn btn-link btn-block text-left collapsed icon-btn p-0 accordion-toggle"></span>
								</h4>
							</div>
						</a>
						<div id="${param.block}limitcollapseOne" class="collapse" aria-labelledby="${param.block}limitheadingOne" data-parent="#${param.block}limitations_drop">
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

<script>

	// manage incremental loading of panels on inner nav bar clicks
	var ${param.block}_crumbs = '';
	
	function ${param.block}_load(selection) {
		var $this = $("#${param.block}-"+selection);
		var which = $this.attr('src');

		if (!${param.block}_crumbs.includes(selection)) {
			$this.load("<util:applicationRoot/>/new_ph/"+which);
			${param.block}_crumbs = ${param.block}_crumbs + selection;
		}
	};
	
	function ${param.block}_loaded(selection) {
		return ${param.block}_crumbs.includes(selection);
	}
</script>


