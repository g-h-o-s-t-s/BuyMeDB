<%@ page language="java"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
<title>Error</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<% if (session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<h2>Please input a question</h2>
		<p><%=session.getAttribute("userAccount")%>, <a href="questions.jsp">click
				here to ask a question.</a>
		</p>
		<p>
			Otherwise, <a href="index.jsp">click here to return to the home
				page.</a>
		</p>
	</div>
	<% } %>
</body>
</html>
