<%@include file="/includes/header.jsp"%>

<h1>Post News</h1>
<form action="/news" method="post">
	<div>
		Title: <input type="text" name="title" id="title" /> Contents:
		<textarea name="content" rows="3" cols="60"></textarea>
	</div>
	<div>
		<input type="submit" width="50%" value="Post news" data-role="button" data-mini="true" data-inline="true" data-icon="check" data-theme="b" />

	</div>
</form>

<%@include file="/includes/footer.jsp"%>
