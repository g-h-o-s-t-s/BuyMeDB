<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>BuyMe - Error</title>
<link rel="stylesheet" href="style.css?v=1.0" />
</head>
<body>
	<% if(session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<h2>Oops! Something went wrong.</h2>
		<p>
			Sorry,
			<%=session.getAttribute("user")%>, <a href="index.jsp">click here
				to return to the home page.</a>
		</p>
	</div>
	<% } %>
</body>
</html>
