<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="ages" dataSource="jdbc/N3CPublic">
	select jsonb_pretty(jsonb_agg(done order by file))
	from (select
			'Public Health' as category,
			file,
			to_char(updated, 'yyyy-mm-dd HH24:MI TZ') as updated,
			(select regexp_replace(substring(array_agg(column_name)::text from '[{](.*)[}]'), ',', ', ', 'g') as attributes
				from (select column_name::text
						from information_schema.columns
						where table_name = file ORDER BY ordinal_position) as foo
					) as attributes,
			'<a href="feeds/download_json.jsp?schema=n3c_questions&table=' || file || '">download</a>' as json,
			'<a href="feeds/download_csv.jsp?schema=n3c_questions&table=' || file || '">download</a>' as csv
			from palantir.tiger_team_file
		  union
		  select
		  	category,
		  	file,
			to_char(updated, 'yyyy-mm-dd HH24:MI TZ') as updated,
			(select regexp_replace(substring(array_agg(column_name)::text from '[{](.*)[}]'), ',', ', ', 'g') as attributes
				from (select column_name::text
						from information_schema.columns
						where columns.table_schema=other_feed_file.table_schema
						  and table_name = file ORDER BY ordinal_position) as foo
					) as attributes,
			'<a href="feeds/download_json.jsp?schema=' || table_schema || '&table=' || file || '">download</a>' as json,
			'<a href="feeds/download_csv.jsp?schema=' || table_schema || '&table=' || file || '">download</a>' as csv
			from palantir.other_feed_file
		  ) as done;
</sql:query>


{
    "headers": [
        {"value":"category", "label":"Category"},
        {"value":"file", "label":"File"},
        {"value":"updated", "label":"Last Updated"},
        {"value":"attributes", "label":"Attributes"},
        {"value":"json", "label":"JSON"},
        {"value":"csv", "label":"CSV"}
    ],
    "rows" : 
<c:forEach items="${ages.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			