<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">


<title>BuyMe - View Wishlist</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<% if(session.getAttribute("user") == null) {
    	 	response.sendRedirect("login.jsp");
        } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<%
    		String url = "jdbc:mysql://localhost:3306/buyMe";
    		Connection conn = null;
    		PreparedStatement ps = null;
    		ResultSet rs = null;
    		try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(url, "root", "UN5AW!]x9K{[bP");
				String query = "SELECT * FROM WishList WHERE user=?";
				String user = (session.getAttribute("user")).toString();
				Locale locale = new Locale("en", "US");
				NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
				
				ps = conn.prepareStatement(query);
				ps.setString(1, user);
				rs = ps.executeQuery();
				if (rs.next()) { %>
		<h2>Your Wishlist</h2>
		<table>
			<tr>
				<th>Category</th>
				<th>Brand</th>
				<th>Model</th>
				<th>Gender</th>
				<th>Size</th>
				<th>Color</th>
				<th>Max Price</th>
			</tr>
			<%	do { %>
			<tr>
				<td><%= rs.getString("category") %></td>
				<td><%= rs.getString("brand") %></td>
				<td><%= rs.getString("model") %></td>
				<td><%= rs.getString("gender") %></td>
				<td><%= rs.getString("size") %></td>
				<td><%= rs.getString("color") %></td>
				<td><%= currency.format(rs.getFloat("max_price")) %></td>
			</tr>
			<%	} while (rs.next()); %>
		</table>
		<%	} else { %>
		<h2>You have no items in your wishlist.</h2>
		<%	}
    		} catch (SQLException e) {
    			out.print("<p>Failure to connect to MYSQL server.</p>");
			    e.printStackTrace();
    		} finally {
    			try { 
    				rs.close(); 
    				} catch (Exception e) {} 
    			try { 
    				ps.close(); 
    				} catch (Exception e) {} 
				try { 
					conn.close(); 
					} catch (Exception e) {}
    		} %>
	</div>
	<% } %>
</body>
</html>
