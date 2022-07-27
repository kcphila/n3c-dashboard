<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<style>
	#paxlovid .dataTables_filter{
		display: unset;
	}
</style>

<div class="paxlovid_1">
<jsp:include page="kpis.jsp"/>

	<div class="row">
		<div class="col-12 mx-auto mt-2 mb-2 text-center">
			<p>All data shown occurred between the first day after the end of the 5-day course of Paxlovid 
			(i.e., day 6 post-Paxlovid) and three weeks following (i.e., day 27 post-Paxlovid).</p>
		</div>

		<div class="col-12 mx-auto mt-2 mb-2 text-center">
			<h4>Top 20 Most Frequent Conditions Seen Between 6 to 27 Days After Paxlovid Treatment</h4>
		</div>
		<div class="col-12 col-lg-6 viz" id="condition_viz_1">
			Category:
			<select id="selectCat">
				<option value="any">Any</option>
				<option value="pulmonary">Pulmonary</option>
				<option value="renal">Renal</option>
			</select>
			
			<div class="panel-body" style="text-align:center;">
				<h6 style="color:#3F50B0;"><i class="fas fa-filter"></i> COVID Status</h6>
				<select id="condition_viz_any-testresult-select" multiple="multiple">
				<sql:query var="cases" dataSource="jdbc/N3CPublic">
					select distinct result_abbrev, result_seq from n3c_dashboard.result_map order by result_seq;
				</sql:query>
				<c:forEach items="${cases.rows}" var="row" varStatus="rowCounter">
					<option value="${row.result_abbrev}">${row.result_abbrev}</option>
				</c:forEach>
				</select>
			</div>
			
			<div id="condition_viz_any" style="display: block;"></div>
			<div id="condition_viz_any_table" style="display: block;"></div>
			<jsp:include page="viz_tables/condition_viz_table.jsp">
				<jsp:param name="domName" value='condition_viz_any' />
				<jsp:param name="feed" value="topten_condition_long.jsp" />
				<jsp:param name="table" value="condition_viz_any_table" />
				<jsp:param name="primary" value="condition" />
				<jsp:param name="secondary" value="result" />
				<jsp:param name="textmargin" value="220" />
			</jsp:include>
			<div id="condition_viz_pulmonary" style="display: none;"></div>
			<jsp:include page="vizs/stacked_bar.jsp">
				<jsp:param name="domName" value='condition_viz_pulmonary' />
				<jsp:param name="feed" value="topten_condition_by_category.jsp?category=pulmonary" />
				<jsp:param name="primary" value="condition" />
				<jsp:param name="secondary" value="result" />
				<jsp:param name="textmargin" value="220" />
			</jsp:include>
			<div id="condition_viz_renal" style="display: none;"></div>
			<jsp:include page="vizs/stacked_bar.jsp">
				<jsp:param name="domName" value='condition_viz_renal' />
				<jsp:param name="feed" value="topten_condition_by_category.jsp?category=renal" />
				<jsp:param name="primary" value="condition" />
				<jsp:param name="secondary" value="result" />
				<jsp:param name="textmargin" value="220" />
			</jsp:include>
		</div>
		<div class="col-12 col-lg-6 viz-table" id="condition_table_1">
			<jsp:include page="tables/top10_table.jsp" flush="true"/>
		</div>
	</div>
	<div class="row">
		<div class="col-12 mx-auto mt-2 mb-2 text-center">
			<h4>All Conditions Seen Between 6 to 27 Days After Paxlovid Treatment </h4>
		</div>
		<div class="col-12 col-lg-6 viz-table" id="condition_table_2">
			<h5 class="text-center">Total Occurrences Greater Than 20</h5>
			<jsp:include page="tables/greater_table.jsp" flush="true"/>
		</div>
		<div class="col-12 col-lg-6 viz-table" id="condition_table_3">
			<h5 class="text-center">Total Occurrences Less Than 20</h5>
			<jsp:include page="tables/less20_table.jsp" flush="true"/>
		</div>
	</div>
</div>

<script>
$(document).ready(function () {
	  $('#selectCat').change(function () {
		  console.log("selected", $(this).val())
		  document.getElementById("condition_viz_any").style.display = "none";
		  document.getElementById("condition_viz_pulmonary").style.display = "none";
		  document.getElementById("condition_viz_renal").style.display = "none";
		  document.getElementById("condition_viz_"+$(this).val()).style.display = "block";
	  });
});

$('#condition_viz_any-testresult-select').multiselect({	
  	onChange: function(option, checked, select) {
  		var options = $('#condition_viz_any-testresult-select');
          var selected = [];
          $(options).each(function(){
              selected.push($(this).val());
          });
  		conditionconstrain("result",  selected[0].join('|'));
      }
  });
</script>