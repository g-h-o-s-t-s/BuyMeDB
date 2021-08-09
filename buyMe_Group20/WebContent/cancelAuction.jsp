<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title>BuyMe</title>
<link rel="stylesheet" href="style.css?v=1.0" />
</head>
<body>
	<% if(session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { %>

	<%@ include file="navbar.jsp"%>

	<div class="content">
		<form action="cancelAuctionHandler.jsp" method="POST">
			<label>Seller</label> <input type="text" name="seller"
				placeholder="Username" required><br> <label>Enter
				Your Password</label> <input type="password" name="your_password"
				placeholder="Enter Password" required> <br> <label>Confirm
				Your Password</label> <input type="password" name="confirm_your_password"
				placeholder="Confirm Password" required> <br> <input
				type="submit" value="Cancel The Auction">
		</form>

	</div>
	<% } %>
</body>
</html>
