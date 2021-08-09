<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title>BuyMe - Register</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<% if (session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { 
			String url = "jdbc:mysql://localhost:3306/buyMe";
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
		   	try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(url, "root", "UN5AW!]x9K{[bP");
				
				String user = (session.getAttribute("user")).toString();
				String accountQuery = "SELECT * FROM Account WHERE username=?";
				
				ps = conn.prepareStatement(accountQuery);
				ps.setString(1, user);
				rs = ps.executeQuery();
				rs.next();
				
				if (rs.getInt("accessLevel") != 3) {
    				response.sendRedirect("index.jsp");
 	    			return;
    			} 
			} catch (SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {} 
				try { ps.close(); } catch (Exception e) {} 
				try { conn.close(); } catch (Exception e) {} 
			} %>
	<%@ include file="navbar.jsp"%>
	<div class="content center">
		<h2>Create a Customer Rep account</h2>
		<form action="customerRepHandler.jsp" method="POST">
			<label for="firstName">First Name</label> <input type="text"
				name="firstName" id="firstName" placeholder="First Name">
			<br> <label>Last Name</label> <input type="text"
				name="lastName" placeholder="Last Name"> <br> <label>Email</label>
			<input type="text" name="email" placeholder="Email"> <br>

			<label for="Address">Address</label> <input type="text"
				name="address" placeholder="Address"> <br> <label
				for="username">Username</label> <input type="text" name="username"
				id="username" placeholder="Username"> <br> <label>Password</label>
			<input type="password" name="password" placeholder="Password">
			<br> <label>Confirm Password</label> <input type="password"
				name="confirm_password" placeholder="Confirm Password"> <br>

			<input type="submit" value="Create Account">
		</form>
	</div>
	<% } %>
</body>
</html>
