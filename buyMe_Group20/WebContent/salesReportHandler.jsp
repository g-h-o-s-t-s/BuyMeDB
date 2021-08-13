<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">


<title>BuyMe - Sales Reports</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<% if(session.getAttribute("userAccount") == null) {
    		response.sendRedirect("login.jsp");
       } else { 
    	   	String accessLevel = session.getAttribute("accessLevel").toString();
    	   	if (!accessLevel.equals("ADMIN")) {
				response.sendRedirect("index.jsp");
				return;
    	   	}
    	   	String reportType = request.getParameter("type"); %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<%	
		    String url = "jdbc:mysql://localhost:3306/buyMe";
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			Locale locale = new Locale("en", "US");
			NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
			
			try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(url, "root", "UN5AW!]x9K{[bP");
				
				String query = null;
		    	if (reportType.equals("totalEarnings")) {
		    		query = "SELECT SUM(price) FROM Product WHERE sold=true";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		<h2>Sales Report:</h2>
		<table>
			<tr>
				<th>Total Earnings</th>
			</tr>
			<%	do { %>
			<tr>
				<td><%= currency.format(rs.getDouble("SUM(price)")) %></td>
			</tr>
			<%	} while (rs.next()); %>
		</table>
		<br>
		<a href="salesReports.jsp">Click here to generate more sales
			reports.</a>
		<%	}
		    	} else if (reportType.equals("earningsPerItemType")) {
		    		query = "SELECT category, SUM(price) FROM Product WHERE sold=true GROUP BY category";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		<h2>Sales Report:</h2>
		<table>
			<tr>
				<th>Category</th>
				<th>Earnings</th>
			</tr>
			<%	do { %>
			<tr>
				<td><%= rs.getString("category") %></td>
				<td><%= currency.format(rs.getDouble("SUM(price)")) %></td>
			</tr>
			<%	} while (rs.next()); %>
		</table>
		<br>
		<a href="salesReports.jsp">Click here to generate more sales
			reports.</a>
		<%	}
		    	} else if (reportType.equals("earningsPerEndUser")) {
		    		query = "SELECT sellerAccount, SUM(price) FROM Product WHERE sold=true GROUP BY sellerAccount";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		<h2>Sales Report:</h2>
		<table>
			<tr>
				<th>User</th>
				<th>Earnings</th>
			</tr>
			<%	do { %>
			<tr>
				<td><%= rs.getString("sellerAccount") %></td>
				<td><%= currency.format(rs.getDouble("SUM(price)")) %></td>
			</tr>
			<%	} while (rs.next()); %>
		</table>
		<br>
		<a href="salesReports.jsp">Click here to generate more sales
			reports.</a>
		<%	}
		    	} else if (reportType.equals("bestBuyers")) {
		    		query = "SELECT buyerAccount, COUNT(buyerAccount), SUM(price) FROM BuyingHistory GROUP BY buyerAccount ORDER BY COUNT(buyerAccount) DESC";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		<h2>Sales Report:</h2>
		<table>
			<tr>
				<th>Buyer</th>
				<th>Number of purchases</th>
				<th>Total amount spent</th>
			</tr>
			<%	do { %>
			<tr>
				<td><%= rs.getString("buyerAccount") %></td>
				<td><%= rs.getInt("COUNT(buyerAccount)") %></td>
				<td><%= currency.format(rs.getDouble("SUM(price)")) %></td>
			</tr>
			<%	} while (rs.next()); %>
		</table>
		<br>
		<a href="salesReports.jsp">Click here to generate more sales
			reports.</a>
		<% }
		    	} else {
		    		// Invalid sales report type
		    		response.sendRedirect("error.jsp");
		    		return;
		    	}
			} catch (SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception ignored) {}
				try { ps.close(); } catch (Exception ignored) {}
		        try { conn.close(); } catch (Exception ignored) {}
			}
	    %>
	</div>
	<% } %>
</body>
</html>
