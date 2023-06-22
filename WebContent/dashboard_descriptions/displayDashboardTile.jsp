<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dashboard" uri="http://icts.uiowa.edu/N3CDashboardTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<dashboard:dashboard did="${param.did}">
	<div class="col-12 col-md-6 col-lg-4 d-flex">
		<c:choose>
			<c:when test="${param.type == 'spotlight'}">
				<c:set var="class_value" value="card hover-card_noshadow mb-2" />
			</c:when>
			<c:otherwise>
				<c:set var="class_value" value="card hover-card mb-2" />
			</c:otherwise>
		</c:choose>
		<div class="${class_value}" onclick="location.href='<util:applicationRoot/>/<dashboard:dashboardPath/>';">
			<img src="<util:applicationRoot/>/dashboard_descriptions/displayDashboardThumbnail.jsp?did=<dashboard:dashboardDid/>" class="card-img-top" alt="...">
			<div class="card-body card-body-links">
				<p class="card-title">
					<strong><dashboard:dashboardTitle /></strong>
				</p>
				<dashboard:dashboardBlurb />
				<div class='row card-link'>
					<div class="col col-6">
						<a href='<util:applicationRoot/>/<dashboard:dashboardPath/>'>Explore&#8196;<i class="fas fa-angle-right"></i></a>
					</div>
						<div class="col col-6">
					<c:if test="${dashboard:dashboardHasTopic(param.did)}">
							<a tabindex="0" class="btn btn-sm btn-primary" role="button" data-html="true" data-toggle="popover" data-trigger="click" title="<b>Available Topics</b>" data-content="
						<dashboard:foreachTopic sortCriteria="seqnum" var="topicIter">
							<c:if test='${!topicIter.isFirst()}'>
								<br>
							</c:if>
							<dashboard:topic>
								<a href='<util:applicationRoot/>/<dashboard:topicPath/>'><dashboard:topicTitle/></a> 							
							</dashboard:topic>
						</dashboard:foreachTopic>
							">Topics&#8196;<i class="fas fa-bars"></i></a>
					</c:if>
						</div>
				</div>
			</div>
		</div>
	</div>
</dashboard:dashboard>
