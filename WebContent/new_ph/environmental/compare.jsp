<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<div class="row">
	<div class="col-12 col-lg-6">
		<div class="viz-header-section">
			<div style="display:flex; flex-wrap: nowrap;">
				<h2 class="viz-title">% of All Patients who Experienced Mortality (All Vs. Environmentally Impacted)</h2>
				<div>
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="saveVisualization('${param.block}rate', '% of Mortalities for All N3C Patients Vs. Environmentally Impacted Patients.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}rate', '% of Mortalities for All N3C Patients Vs. Environmentally Impacted Patients.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}rate', '% of Mortalities for All N3C Patients Vs. Environmentally Impacted Patients.svg')">Save as SVG</a>
					</div>
				</div>
			</div>
		</div>
		<div id="${param.block}rate">
			<jsp:include page="../environmental/vizs/mortality_rate.jsp">
				<jsp:param name="block" value="${param.block}rate" />
				<jsp:param name="feed" value="rate" />
			</jsp:include>
		</div>
		<div class="mt-2">
			<small style="color:gray;">The percent of all patients in the N3C Data Enclave who experienced mortality ((# Mortalities/Total Patients)*100) compared to the percent of patients known to be impacted by environmental factors who experienced mortality.</small>
		</div>
	</div>
	<div class="col-12 col-lg-6">
		<div class="viz-header-section">
			<div style="display:flex; flex-wrap: nowrap;">
				<h2 class="viz-title">% of COVID+ Patients who Experienced Mortality (All Vs. Environmentally Impacted)</h2>
				<div>
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '% of Mortalities for All COVID+ N3C Patients Vs. COVID+ Environmentally Impacted Patients.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '% of Mortalities for All COVID+ N3C Patients Vs. COVID+ Environmentally Impacted Patients.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '% of Mortalities for All COVID+ N3C Patients Vs. COVID+ Environmentally Impacted Patients.svg')">Save as SVG</a>
					</div>
				</div>
			</div>
		</div>
		<div id="${param.block}ratecovid">
			<jsp:include page="../environmental/vizs/mortality_rate.jsp">
				<jsp:param name="block" value="${param.block}ratecovid" />
				<jsp:param name="feed" value="ratecovid" />
			</jsp:include>
		</div>
		<div class="mt-2">
			<small style="color:gray;">The percent of all COVID+ patients in the N3C Data Enclave who experienced mortality ((# Mortalities/Total Patients)*100) compared to the percent of COVID+ patients known to be impacted by environmental factors who experienced mortality.</small>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-12 col-lg-6">
		<div class="viz-header-section">
			<div style="display:flex; flex-wrap: nowrap;">
				<h2 class="viz-title">% of COVID+ Patients who Developed Long COVID (All Vs. Environmentally Impacted)</h2>
				<div>
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '% of Long COVID Instances for All COVID+ N3C Patients Vs. COVID+ Environmentally Impacted Patients.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '% of Long COVID Instances for All COVID+ N3C Patients Vs. COVID+ Environmentally Impacted Patients.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '% of Long COVID Instances for All COVID+ N3C Patients Vs. COVID+ Environmentally Impacted Patients.svg')">Save as SVG</a>
					</div>
				</div>
			</div>
		</div>
		<div id="${param.block}ratecovidlong">
			<jsp:include page="../environmental/vizs/mortality_rate.jsp">
				<jsp:param name="block" value="${param.block}ratecovidlong" />
				<jsp:param name="feed" value="longratecovid" />
			</jsp:include>
		</div>
		<div class="mt-2">
			<small style="color:gray;">The percent of all COVID+ patients in the N3C Data Enclave who developed Long COVID ((# Long COVID/Total Patients)*100) compared to the percent of COVID+ patients known to be impacted by environmental factors who developed Long COVID.</small>
		</div>
	</div>
	<div class="col-12 col-lg-6">
		<div class="viz-header-section">
			<div style="display:flex; flex-wrap: nowrap;">
				<h2 class="viz-title">% of COVID+ Patients who were Hospitalized (All Vs. Environmentally Impacted)</h2>
				<div>
					<button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-download"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-right">
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '% of Hospitalization Instances for All COVID+ N3C Patients Vs. COVID+ Environmentally Impacted Patients.jpg');">Save as JPG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '% of Hospitalization Instances for All COVID+ N3C Patients Vs. COVID+ Environmentally Impacted Patients.png');">Save as PNG</a>
						<a class="dropdown-item" onclick="saveVisualization('${param.block}ratecovid', '% of Hospitalization Instances for All COVID+ N3C Patients Vs. COVID+ Environmentally Impacted Patients.svg')">Save as SVG</a>
					</div>
				</div>
			</div>
		</div>
		<div id="${param.block}ratecovidhosp">
			<jsp:include page="../environmental/vizs/mortality_rate.jsp">
				<jsp:param name="block" value="${param.block}ratecovidhosp" />
				<jsp:param name="feed" value="hospratecovid" />
			</jsp:include>
		</div>
		<div class="mt-2">
			<small style="color:gray;">The percent of all COVID+ patients in the N3C Data Enclave who were hospitalized ((# Hospitalizations/Total Patients)*100) compared to the percent of COVID+ patients known to be impacted by environmental factors who were hospitalized.</small>
		</div>
	</div>
</div>




