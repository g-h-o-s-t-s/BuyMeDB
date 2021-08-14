<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
    <title>Customer Rep Register</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
	<% if (session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
    		System.out.println("redirected to login");
       } else { 
		String connectionUrl = "jdbc:mysql://localhost:3306/buyMe" +
                "?verifyServerCertificate=false&useSSL=true";
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
		   	try {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                conn = DriverManager.getConnection(connectionUrl, "root", "UN5AW!]x9K{[bP");
				
				String user = (session.getAttribute("user")).toString();
				String accountQuery = "SELECT * FROM UserAccount WHERE username=?";
				
				ps = conn.prepareStatement(accountQuery);
				ps.setString(1, user);
				rs = ps.executeQuery();
				rs.next();
				
				if (!rs.getString("accessLevel").equals("ADMIN")) {
    				response.sendRedirect("index.jsp");
                    System.out.println("redirected to index");
 	    			return;
    			} 
			} catch (SQLException e) {
				out.print("<p>Error occurred during mySQL server connection.</p>");
			    e.printStackTrace();
			} finally {
				try {
                    assert rs != null;
                    rs.close(); } catch (Exception ignored) {}
				try { ps.close(); } catch (Exception ignored) {}
				try { conn.close(); } catch (Exception ignored) {}
			} %>
	<%@ include file="navbar.jsp"%>
	<div class="content center">
		<h2>Create a Customer Rep account</h2>
		<form action="customerRepHandler.jsp" method="POST">
			<label for="firstName">First Name</label> <input type="text"
				name="firstName" id="firstName" placeholder="First Name">
			<br> <label>Last Name <input type="text"
				name="lastName" placeholder="Last Name"></label>
            <br> <label>Email <input type="text" name="email" placeholder="Email"></label>
            <br> <label for="address">Address <input type="text"
				name="address" placeholder="Address" id="address"></label>
            <br> <label for="username">Username <input type="text" name="username"
				id="username" placeholder="Username"></label>
            <br> <label>Password
			<input type="password" name="password" placeholder="Password"></label>
			<br> <label>Confirm Password <input type="password"
				name="confirm_password" placeholder="Confirm Password"></label> <br>

			<input type="submit" value="Create Customer Rep Account">
		</form>
	</div>
	<% } %>
</body>
</html>
