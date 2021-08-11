<%@ page language="java" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
	<title>BuyMe</title>
	<link rel="stylesheet" href="css/styles.css" />
</head>
<body>
	<% if(session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<%
			String url = "jdbc:mysql://localhost:3306/buyMe";
    		Connection conn = null;
    		PreparedStatement ps = null;
    		ResultSet rs = null;
			
    		String firstName = null;
    		String lastName = null;
    		String email = null;
    		String address = null;
    		String oldPassword = null;
    		
    		try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(url, "root", "UN5AW!]x9K{[bP");
				String accountQuery = "SELECT * FROM Account WHERE username=?";
				ps = conn.prepareStatement(accountQuery);
				ps.setString(1, (session.getAttribute("user")).toString());
				rs = ps.executeQuery();
				
				if (rs.next()) {
					firstName = rs.getString("firstName");
					lastName = rs.getString("lastName");
					email = rs.getString("email");
					address = rs.getString("address");
					oldPassword = rs.getString("password");
				} else {
					// Occurs if no row has username = current session's username
					// Should never happen, but just in case
					response.sendRedirect("error.jsp");
					return;
				}
				
    		} catch(SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
		        e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {}
				try { ps.close(); } catch (Exception e) {}
				try { conn.close(); } catch (Exception e) {}
			}
    	%>


	<div class="content">
		<form action="accountUpdate.jsp" method="POST">
			<label>First Name</label> <input type="text" name="firstName"
				value="<%= firstName %>" placeholder="First Name"> <br>

			<label>Last Name</label> <input type="text" name="lastName"
				value="<%= lastName %>" placeholder="Last Name"> <br> <label>Email</label>
			<input type="text" name="email" value="<%= email %>"
				placeholder="Email"> <br> <label>Address</label> <input
				type="text" name="address" value="<%= address %>"
				placeholder="Address"> <br> <label>Current
				Password</label> <input type="password" name="curr_password"
				placeholder="Current Password" required> <br> <label>New
				Password</label> <input type="password" name="new_password"
				placeholder="New Password"> <br> <label>Confirm
				New Password</label> <input type="password" name="confirm_new_password"
				placeholder="Confirm Password"> <br> <input
				type="submit" value="Update Account Settings">
		</form>


	</div>
	<% } %>
</body>
</html>
