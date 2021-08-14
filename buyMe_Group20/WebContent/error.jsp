<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
    <title>Generic Error</title>
    <link rel="stylesheet" href="style.css"/>
</head>
<body>
	<% if (session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<h2>Yikes. Something went wrong, our bad.</h2>
		<p>
			Sorry
			<%=session.getAttribute("user")%>, <a href="index.jsp">click here
				to return to the home page.</a>
		</p>
	</div>
	<% } %>
</body>
</html>
