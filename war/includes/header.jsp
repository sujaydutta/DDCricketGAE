<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.js"></script>
</head>

<body>

	<div data-role="page">

		<div data-role="panel" id="mypanel" data-animate="true" data-display="reveal">
			<!-- panel content goes here -->
			<h4>Menu</h4>
			<!-- 			 <a href="#my-header" data-rel="close">X</a> -->
			<p>
				<a href="/index.jsp">Home</a>
			</p>

			<%
				UserService userService = UserServiceFactory.getUserService();
				User user = userService.getCurrentUser();

				if (user != null) {
			%>
			<p>
				<a href="profile/newsjq.jsp">News</a>
			</p>
			<p>
				<a href="/admin/admin.jsp">Administer</a>
			</p>

			<%
				}
			%>
		</div> <!-- /panel -->


		<!-- header -->
		<div data-role="header" id="#my-header">
			<h1>Dare Devils Cricket Club</h1>
			<a href="#mypanel">Open Menu</a>
			<%
				/* 				UserService userService = UserServiceFactory.getUserService();
				 User user = userService.getCurrentUser();
				 */if (user != null) {
			%>
			<div align="right"><%=user.getNickname()%>
				<a rel="external" href="<%=userService.createLogoutURL(request.getRequestURI())%>">Logout</a>
			</div>

			<%
				} else {
			%>
			<p>
			<div align="right">
				<a rel="external" href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign in!</a>
			</div>
			</p>

			<%
				}
			%>

		</div>

		<!-- content -->
		<div data-role="content">