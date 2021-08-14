<%@ page pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
    <title>Delete Account</title>
    <link rel="stylesheet" href="style.css"/>
</head>
<body>
	<% if (session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>

	<%@ include file="navbar.jsp"%>

	<div class="content">
		<form action="deleteAccountHandler.jsp" method="POST">
			<label>Account to Be Deleted <input type="text"
				name="deactivated_account" placeholder="Username" required></label>
			<br> <label>Enter Your Password <input type="password"
				name="your_password" placeholder="Enter Password" required></label>
			<br> <label>Confirm Your Password <input type="password"
				name="confirmPassword"
                placeholder="Confirm Password" required></label>
            <br> <input type="submit" value="Delete User">
		</form>
	</div>
	<% } %>
</body>
</html>
