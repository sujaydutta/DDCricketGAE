<%@include file="/includes/header.jsp"%>

<%
	String guestbookName = request.getParameter("guestbookName");
	if (guestbookName == null) {
		guestbookName = "default";
	}
	if (user != null) {
%>
<p>
	Hello,
	<%=user.getNickname()%>! (You can <a rel="external" href="<%=userService.createLogoutURL(request.getRequestURI())%>">sign out</a>.)
</p>

<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);
		// Run an ancestor query to ensure we see the most up-to-date
		// view of the Greetings belonging to the selected Guestbook.
		Query query = new Query("Greeting", guestbookKey).addSort("date", Query.SortDirection.DESCENDING);
		List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(15));
		if (greetings.isEmpty()) {
%>
<p>
	Guestbook '<%=guestbookName%>' has no messages.
</p>
<%
	} else {
%>
<div data-role="collapsible-set" data-theme="c" data-content-theme="d">

	<p>
		Messages in Guestbook '<%=guestbookName%>'.
	</p>
	<%
		for (Entity greeting : greetings) {
					if (greeting.getProperty("user") != null) {
	%>

	<div data-role="collapsible">
		<h3><%=((User) greeting.getProperty("user")).getNickname()%></h3>
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
%>


<form action="/sign" method="post">
	<div>
		<textarea name="content" rows="3" cols="60"></textarea>
	</div>
	<div>
		<input type="submit" value="Post Greeting" />
	</div>
	<input type="hidden" name="guestbookName" value="<%=guestbookName%>" />
</form>


<%
	} else {
%>
<p>
	Hello!!! <a rel="external" href="<%=userService.createLoginURL(request.getRequestURI())%>">Please Sign in!</a>
</p>
<%
	}
%>

<%@include file="/includes/footer.jsp"%>