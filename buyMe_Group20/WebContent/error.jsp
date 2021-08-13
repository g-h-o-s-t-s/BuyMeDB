<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
<title>BuyMe - Error</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<% if(session.getAttribute("userAccount") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<h2>Oops! Something went wrong.</h2>
		<p>
			Sorry,
			<%=session.getAttribute("userAccount")%>, <a href="index.jsp">click here
				to return to the home page.</a>
		</p>
	</div>
	<% } %>
</body>
</html>
