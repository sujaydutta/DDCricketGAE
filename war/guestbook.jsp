<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<html>
<head>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
</head>

<body>

	<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if (user != null) {
	%>
	<p>
		Hello,
		<%=user.getNickname()%>! (You can <a href="<%=userService.createLogoutURL(request.getRequestURI())%>">sign out</a>.)
	</p>
	<%
		} else {
	%>
	<p>
		Hello!!! <a href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign in</a>
	</p>
	<%
		}
	%>

</body>
</html>