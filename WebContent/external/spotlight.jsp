<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="dashboard" uri="http://icts.uiowa.edu/N3CDashboardTagLib"%>

<div class="dashboard_main">
	<div id="dashboards" class="dashboard-heading">
		<div class="row container-large m-auto py-2">
			<div class="col-12 col-md-8">
				<h2>Dashboards</h2>
			</div>
			<div class="col-12 col-md-4 m-auto">
				<form autocomplete="off" class="input-group mb-3" action="<util:applicationRoot/>/search">
  					<input id="dashboard-search" type="text" name="search" class="form-control" placeholder="Search All Dashboards" aria-label="Search" aria-describedby="search-addon">
  					<div class="input-group-append">
    					<button id="search-addon" class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
  					</div>
				</form>
			</div>
		</div>
	</div>
	<dashboard:foreachCategory sortCriteria="seqnum" limitCriteria="1" var="catIter">
		<dashboard:category>
			<div id="<dashboard:categoryLabel/>" class="dashboard-section hidden">
				<h3 class="dashboard-heading text-center"><dashboard:categoryLabel/></h3>
				<div class="row featured-slick slick-test">
					<dashboard:foreachBinding sortCriteria="seqnum" var="bindIter">
						<dashboard:binding>
							<jsp:include page="../dashboard_descriptions/displayDashboardTile.jsp?did=${tag_binding.did}" />
						</dashboard:binding>
					</dashboard:foreachBinding>
				</div>
			</div>
		</dashboard:category>
	</dashboard:foreachCategory>
</div>
