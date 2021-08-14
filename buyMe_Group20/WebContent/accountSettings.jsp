<%--suppress deprecation--%>
<%@ page language="java" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
	<title>Account Settings</title>
	<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<% if (session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<%
			String connectionUrl = "jdbc:mysql://localhost:3306/buyMe" +
                    "?verifyServerCertificate=false&useSSL=true";
    		Connection conn = null;
    		PreparedStatement ps = null;
    		ResultSet rs = null;
			
    		String firstName = null;
    		String lastName = null;
    		String email = null;
    		String address = null;

        try {
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                } catch (InstantiationException
                        | ClassNotFoundException
                        | IllegalAccessException e) {
                    e.printStackTrace();
                }
                conn = DriverManager.getConnection(connectionUrl, "root", "UN5AW!]x9K{[bP");
				String accountQuery = "SELECT * FROM UserAccount WHERE username=?";
				ps = conn.prepareStatement(accountQuery);
				ps.setString(1, (session.getAttribute("user")).toString());
				rs = ps.executeQuery();
				
				if (rs.next()) {
					firstName = rs.getString("firstName");
					lastName = rs.getString("lastName");
					email = rs.getString("email");
					address = rs.getString("address");
                } else {
					// If no record holds current session's username, failsafe
					response.sendRedirect("error.jsp");
					return;
				}
				
    		} catch(SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
		        e.printStackTrace();
			} finally {
				try { //avoid NullPointerException
                    assert rs != null;
                    rs.close(); } catch (Exception ignored) {}
				try { ps.close(); } catch (Exception ignored) {}
				try { conn.close(); } catch (Exception ignored) {}
			}
    	%>

	<div class="content">
		<form action="accountUpdate.jsp" method="POST">
			<label>First Name <input type="text" name="firstName"
				value="<%= firstName %>" placeholder="John"></label>
            <br> <label>Last Name <input type="text" name="lastName"
				value="<%= lastName %>" placeholder="Doe"></label>
            <br> <label>Email <input type="text" name="email"
                value="<%= email %>" placeholder="Email"></label>
            <br> <label>Address <input type="text" name="address"
                value="<%= address %>" placeholder=""></label>
            <br> <label>Current Password <input type="password" name="curr_password"
				placeholder="Current" required> </label>
            <br> <label>New Password <input type="password" name="new_password"
				placeholder="New"></label>
            <br> <label>Confirm New Password <input type="password"
                name="confirm_new_password" placeholder=""></label>
            <br> <input type="submit" value="Update UserAccount Settings">
		</form>
	</div>
	<% } %>
</body>
</html>
