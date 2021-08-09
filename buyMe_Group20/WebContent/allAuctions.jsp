<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title>BuyMe</title>
<link rel="stylesheet" href="css/styles.css" />
</head>
<body>

	<% if (session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<%
	    	String url = "jdbc:mysql://localhost:3306/buyMe";
			Connection conn = null;
			Statement s = null;
    		ResultSet rs = null;
    	
    		try {
    			Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(url, "root", "UN5AW!]x9K{[bP");
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
				try { rs.close(); } catch (Exception e) {} 
				try { s.close(); } catch (Exception e) {} 
				try { conn.close(); } catch (Exception e) {} 
    		}   	
    	%>
	</div>
	<% } %>
</body>
</html>
