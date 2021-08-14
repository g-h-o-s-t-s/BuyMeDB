<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
<title>Creating Auction Error</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
	<% if (session.getAttribute("user") == null) {
    	 	response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<h2>Error: Failed to create auction.</h2>
		<p>
			Be sure to fill out the fields correctly, adhering to the following
			guidelines: <br> Minimum Bid Price must be greater than 0 <br>
			Start Date must be earlier than the End Date <br>
		</p>
		<a href="createAuction.jsp">Click here to try again.</a>
	</div>

	<% } %>
</body>
</html>
