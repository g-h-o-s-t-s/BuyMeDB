<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
<title>Live Auctions</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>

	<% if (session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<%
	    	String connectionUrl = "jdbc:mysql://localhost:3306/buyMe" +
            "?verifyServerCertificate=false&useSSL=true";
			Connection conn = null;
			Statement s = null;
    		ResultSet rs = null;
    	
    		try {
    			Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(connectionUrl, "root", "UN5AW!]x9K{[bP");
				Locale locale = new Locale("en", "US");
				NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
				String allAuctionsQuery = "SELECT * FROM Product WHERE sold=false";
				s = conn.createStatement();
				rs = s.executeQuery(allAuctionsQuery);
				if (rs.next()) { %>
		<h2>All Live Auctions</h2>
		<table>
			<tr>
				<th>Item</th>
				<th>Seller</th>
				<th>Current Bid</th>
				<th>End Date/Time</th>
			</tr>
			<%	do { %>
			<tr>
				<td><a
					href="auction.jsp?productId=<%= rs.getInt("productId") %>"> <%= rs.getString("brand") + " " + rs.getString("color") + " " + rs.getString("damageCondition")%>
				</a></td>
				<td><%= rs.getString("sellerAccount") %></td>
				<td><%= currency.format(rs.getDouble("price")) %></td>
				<td><%= rs.getString("endDate") %></td>
			</tr>
			<%		} while (rs.next()); %>
		</table>
		<%	} else { %>
		<br>
		<h3>There are currently no live auctions.</h3>
		<%	} %>
		<%	
			
				
				
    		} catch (SQLException e){
    			out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();    			
    		} finally {
				try { rs.close(); } catch (Exception ignored) {}
				try { s.close(); } catch (Exception ignored) {}
				try { conn.close(); } catch (Exception ignored) {}
    		}   	
    	%>
	</div>
	<% } %>
</body>
</html>
