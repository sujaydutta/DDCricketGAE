<%@include file="/includes/header.jsp"%>

<%
	String newsName = "defaultNews";
	if (user != null) {

		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key newsKey = KeyFactory.createKey("News", newsName);
		// Run an ancestor query to ensure we see the most up-to-date view of the News
		Query query = new Query("News", newsKey).addSort("date", Query.SortDirection.DESCENDING);
		List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(15));
		if (greetings.isEmpty()) {
%>
<p>No news is good news!</p>
<%
	} else {
%>

<p>Latest News!</p>
<div data-role="collapsible-set" data-theme="c" data-content-theme="d">

	<%
		for (Entity greeting : greetings) {
					if (greeting.getProperty("user") != null) {
	%>

	<div data-role="collapsible" data-collapsed="true">
		<h3><%=greeting.getProperty("title")%></h3>
		<p>
			<i>Posted by <%=((User) greeting.getProperty("user")).getNickname()%> on <%=greeting.getProperty("date")%>
		</p>
		<p><%=greeting.getProperty("content")%></p>
	</div>

	<%
		}
				}
	%>
</div>
<!-- accordion -->
<%
	}
	}
%>

<%@include file="/includes/footer.jsp"%>