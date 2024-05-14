<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sql:query var="team" dataSource="jdbc/N3CPublic">
select json_agg(foo) as bar from (
	select false_positive_rate as timeline,
	json_object_agg(CASE WHEN cohort = 'COHORT A' THEN 'Cohort A'WHEN cohort = 'COHORT B' THEN 'Cohort B'
     		WHEN cohort = 'COHORT C' THEN 'Cohort C'
     		ELSE cohort
     	END , Concat(to_char(true_positive_rate, 'FM99.0000')::float, ',', lowerlimit_trueposrate, ',', upperlimit_trueposrate))  as elements
	from phastr_pasc.combined_cohort_roc group by 1 order by 1) as foo;
</sql:query>
<c:forEach items="${team.rows}" var="row" varStatus="rowCounter">
	${row.bar}
</c:forEach>
       