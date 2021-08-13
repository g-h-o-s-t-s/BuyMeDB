<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
<title>BuyMe - Register</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
	<% if (session.getAttribute("userAccount") == null) {
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
				String accountQuery = "SELECT * FROM UserAccount WHERE username=?";
				
				ps = conn.prepareStatement(accountQuery);
				ps.setString(1, user);
				rs = ps.executeQuery();
				rs.next();
				
				if (rs.getString("accessLevel") != "CUSTOMER_REP") {
    				response.sendRedirect("index.jsp");
 	    			return;
    			} 
			} catch (SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception ignored) {}
				try { ps.close(); } catch (Exception ignored) {}
				try { conn.close(); } catch (Exception ignored) {}
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

			<input type="submit" value="Create UserAccount">
		</form>
	</div>
	<% } %>
</body>
</html>
