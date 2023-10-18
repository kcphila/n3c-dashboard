<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<c:choose>
	<c:when test="${fn:startsWith(param.ror,'http')}">
		<img alt="No data" style="width: 100%; object-fit: contain"
			src="<util:applicationRoot/>/overview/collaborating_sites/tiles/${param.type}/${util:regexMatch(param.ror,'.*/([^/]+)$')}.png">
	</c:when>
	<c:otherwise>
		<img alt="No data" style="width: 100%; object-fit: contain"
			src="<util:applicationRoot/>/overview/collaborating_sites/tiles/${param.type}/${param.ror}.png">
	</c:otherwise>
</c:choose>