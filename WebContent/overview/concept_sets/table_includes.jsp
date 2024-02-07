<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<p>N3C Recommended published concept sets are available in the N3C Enclave Concept Set Browser. To view the N3C Recommended concept sets, log into
the N3C Enclave Concept Set Browser and check the “N3C Recommended” filter box in the upper left-hand corner of the screen.</p>

<h2>WHAT IS AN N3C RECOMMENDED CONCEPT SET?</h2>

<p>The N3C Data Liaisons and Logic Liaisons, in partnership with the Domain Teams, have selected common medical features often required for broad use
in research that support the analytics pipelines. The original N3C Recommended concept sets were selected based on 1) the comorbid conditions identified
by the US Centers for Disease Control (CDC) definitions for COVID-19 as increasing risk of severe COVID-19, 2) the comorbid conditions identified in the
Charlson Comorbidity Index, and 3) others as requested by N3C leadership for use in the Logic Liaison templates.</p>
<p>The N3C Recommended concept sets have been vetted by clinical experts (typically N3C Domain Team leads) and the Data and Logic Liaison teams according
to the below refinement and finalization process. The latest version of the listed concept sets should always be used as earlier versions represent iterations
and have not passed the final review.</p>

<div id="concept_set_table_section">
	<div id="concept-set-list" class="mx-auto"></div>
	<c:import url="/modules/concept_sets.jsp" />
</div>

<h2>REFINEMENT PROCESS</h2>
<p>The clinical experts and the N3C Data Liaisons and Logic Liaisons perform the following steps in establishing an intentional N3C Recommended concept set:</p>
<ol>
<li>Select relevant parent concepts and their descendants from OMOP standard codes, using Charlson Comorbidity description or the relevant section the referenced CDC page to establish intention.
<li>Utilize the OHDSI Atlas tool to explore the OMOP hierarchy to look for other potential parent codes and also to remove child codes that are non-specific to the intended scope of the concept set.
<li>Compare the draft concept set to other related concept sets, using the Concept Set Overlap feature of the Concept Set Editor. This facilitates review of any codes that do not overlap with those in value sets from reputable stewards such as the National Library of Medicine’s Value Set Authority Center (VSAC) and the Healthcare Cost and Utilization Project (HCUP) and from existing similar concept sets within the Concept Set Browser. Add and remove concepts (and their descendants) as per recommendations from the clinical experts.
<li>Reduce the intentional concept set expression as parsimonious as possible, retaining all the approved concepts collected in prior steps.
<li>Iterate as needed.
<li>Document metadata (properties) in the Concept Set Editor for each created concept set to include: Intention, Limitations, Provenance, and at least one vocabulary and one clinical review.
<li>Present for final vetting at the Data Liaison meeting for N3C Recommended designation.
</ol>
<p>These concept sets are in queue to be published as pdf (Properties) and json (concept ids) in Zenodo, to be available to researchers outside the Enclave.
Once published, their Zenodo DOI will be posted to the Zenodo Property of the version that was published.</p>

<h2>QUESTIONS?</h2>
<p>For questions about N3C Recommended concept sets, please contact the N3C Data Liaisons through the N3C Support Desk either by opening a support request or
attending one of the Support Desk office hours.</p>
<p>An extensive tutorial for using Enclave tools to create concept sets is available:
<a href="https://unite.nih.gov/workspace/notepad/view/ri.notepad.main.notepad.33fa969f-cc18-401f-ab69-538146c343c0">How to Work with Concept Sets in the Enclave.</a></p>