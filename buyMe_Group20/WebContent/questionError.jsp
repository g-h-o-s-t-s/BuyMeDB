<%@ page language="java"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
    <title>Question Error</title>
    <link rel="stylesheet" href="style.css"/>
</head>
<body>
	<% if (session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<h2>Please input a question.</h2>
        <p><a href="questions.jsp">Return to Q&A</a></p>
		<p><a href="index.jsp">Return to Home Page</a></p>
	</div>
	<% } %>
</body>
</html>
