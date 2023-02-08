<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="dashboard" uri="http://icts.uiowa.edu/N3CDashboardTagLib"%>

<c:if test="${dashboard:dashboardHasRelatedDashboard(param.did)}">
	<div class="panel-heading filter-section" id="related_dashboards">
		<h4>Related Dashboards</h4>
		<div class="row">
			<dashboard:dashboard did="${param.did}">
				<dashboard:foreachRelatedDashboard sortCriteria="seqnum" var="x">
					<dashboard:relatedDashboard>
						<dashboard:dashboard did="${tag_relatedDashboard.rid }">
							<div class="col-12 d-flex">
								<div class="card hover-card flex-fill mb-2" onclick="location.href='<util:applicationRoot/>/<dashboard:dashboardPath/>';">
									<img src="<util:applicationRoot/>/new_ph/displayDashboardThumbnail.jsp?did=${tag_relatedDashboard.rid}" class="card-img-top related-img" alt="...">
									<div class="card-body card-body-links">
										<p class="card-title">
											<dashboard:dashboardTitle />
										</p>
									</div>
								</div>
							</div>
						</dashboard:dashboard>
					</dashboard:relatedDashboard>
				</dashboard:foreachRelatedDashboard>
			</dashboard:dashboard>
		</div>
	</div>
</c:if>
