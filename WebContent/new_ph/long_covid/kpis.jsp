<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<c:choose>
	<c:when test="${param.block == 'long_covid_13'}">
		<div class="col col-12 col-md-6 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_icd.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'long_covid_2'}">
		<div class="col col-12 col-md-6 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_concept.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'long_covid_3'}">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_icd_summary.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_tested_positive.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_in_record.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'long_covid_4'}">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_total_grouped.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_tested_positive_grouped.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_in_record_grouped.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'long_covid_5'}">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_total_ungrouped.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_tested_positive_ungrouped.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_in_record_ungrouped.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'long_covid_6'}">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_total_before_after.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_total_before.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_total_after.jsp">
				<jsp:param name="block" value="${param.block}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'long_covid_7'}">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_individual_symptom_clean.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_tested_positive_individual_symptom.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_in_record_individual_symptom.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'long_covid_8'}">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_individual_symptom_clean.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_tested_positive_individual_symptom.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_in_record_individual_symptom.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'long_covid_9'}">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_individual_symptom_clean.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_tested_positive_individual_symptom.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_in_record_individual_symptom.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'long_covid_10'}">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_individual_symptom_clean.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_tested_positive_individual_symptom.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_in_record_individual_symptom.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'long_covid_11'}">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_individual_symptom_clean.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_tested_positive_individual_symptom.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/long_in_record_individual_symptom.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>		
	</c:when>
	<c:when test="${param.block == 'long_covid_12'}">
		<div class="col col-12 col-md-3 my-auto kpi_border_right">
			<jsp:include page="../kpis/block3_kpis/covid_positive.jsp" >
				<jsp:param name="block" value="${param.block}"/>
			</jsp:include>
		</div>
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/not_positive_total.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/total_w_symptoms_clean.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>	
		<div class="col col-12 col-md-3 my-auto">
			<jsp:include page="../kpis/block3_kpis/not_positive.jsp">
				<jsp:param name="block" value="${param.block}" />
				<jsp:param name="symptom" value="${param.kpi_filter}" />
			</jsp:include>
		</div>		
	</c:when>
</c:choose>
