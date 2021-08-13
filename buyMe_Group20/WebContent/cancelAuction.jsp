<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
<title>BuyMe</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<% if(session.getAttribute("userAccount") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>

	<%@ include file="navbar.jsp"%>

	<div class="content">
		<form action="cancelAuctionHandler.jsp" method="POST">
			<label>Seller</label> <input type="text" name="sellerAccount"
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
