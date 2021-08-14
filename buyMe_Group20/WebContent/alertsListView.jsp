<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">


<title>View AlertsList</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<% if(session.getAttribute("userAccount") == null) {
    	 	response.sendRedirect("login.jsp");
        } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<%
    		String connectionUrl = "jdbc:mysql://localhost:3306/buyMe" +
            "?verifyServerCertificate=false&useSSL=true";
    		Connection conn = null;
    		PreparedStatement ps = null;
    		ResultSet rs = null;
    		try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(connectionUrl, "root", "UN5AW!]x9K{[bP");
				String query = "SELECT * FROM AlertsList WHERE userAcc=?";
				String user = (session.getAttribute("user")).toString();
				Locale locale = new Locale("en", "US");
				NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
				
				ps = conn.prepareStatement(query);
				ps.setString(1, user);
				rs = ps.executeQuery();
				if (rs.next()) { %>
		<h2>Your AlertsList</h2>
		<table>
			<tr>
				<th>Category</th>
				<th>Brand</th>
				<th>damageCondition</th>
				<th>Color</th>
				<th>Max Price</th>
			</tr>
			<%	do { %>
			<tr>
				<td><%= rs.getString("category") %></td>
				<td><%= rs.getString("brand") %></td>
				<td><%= rs.getString("damageCondition") %></td>
				<td><%= rs.getString("color") %></td>
				<td><%= currency.format(rs.getFloat("maxPrice")) %></td>
			</tr>
			<%	} while (rs.next()); %>
		</table>
		<%	} else { %>
		<h2>You have no items in your AlertsList.</h2>
		<%	}
    		} catch (SQLException e) {
    			out.print("<p>Failure to connect to MYSQL server.</p>");
			    e.printStackTrace();
    		} finally {
    			try { 
    				rs.close(); 
    				} catch (Exception ignored) {}
    			try { 
    				ps.close(); 
    				} catch (Exception ignored) {}
				try { 
					conn.close(); 
					} catch (Exception ignored) {}
    		} %>
	</div>
	<% } %>
</body>
</html>
