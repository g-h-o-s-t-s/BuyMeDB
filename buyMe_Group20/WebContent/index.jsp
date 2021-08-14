<!-- Sagnik Mukherjee, Rishab Das, Sami Munir 
	 Group 20 CS336 -->
<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html><head>
    <!-- This meta tag allows the CSS file to link properly. -->
    <meta charset="utf-8">
	<title>BuyMe Home</title>
	<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<% if (session.getAttribute("userAccount") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<h1>
			Hello,
			<%=session.getAttribute("firstName")%></h1>
		<%
	    		String connectionUrl = "jdbc:mysql://localhost:3306/buyMe" +
                        "?verifyServerCertificate=false&useSSL=true";
	    		Connection conn = null;
	    		PreparedStatement ps = null;
	    		PreparedStatement accountPs = null;
	    		PreparedStatement alertPs = null;
	    		ResultSet rs = null;
	    		ResultSet accountRs = null;
	    		ResultSet alertRs = null;
	    		
	    		try {
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					conn = DriverManager.getConnection(connectionUrl, "root", "UN5AW!]x9K{[bP");
				
	    		
		    		Locale locale = new Locale("en", "US");
					NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
					String user = (session.getAttribute("user")).toString();
					
					String alertQuery = "SELECT * FROM Alerts WHERE userAcc=? AND seen=false";
		    		String auctionQuery = "SELECT * FROM Product WHERE sellerAccount=?";
		    		String accountQuery = "SELECT * FROM UserAccount WHERE username=?";
		    		
		    		alertPs = conn.prepareStatement(alertQuery);
		    		alertPs.setString(1, user);
		    		alertRs = alertPs.executeQuery();
		    		if (alertRs.next()) { %>
		<h2>Unread Alerts</h2>
		<table>
			<tr>
				<th>Message</th>
			</tr>
			<%	do { %>
			<tr>
				<td><%= alertRs.getString("message") %> <a
					href="markAsRead.jsp?messageId=<%= alertRs.getInt("messageId") %>">
						<input type="submit" value="Mark as read">
				</a></td>
			</tr>
			<%	} while (alertRs.next()); %>
		</table>
		<%	}   		
		    		
		    		accountPs = conn.prepareStatement(accountQuery);
		    		accountPs.setString(1, user);
		    		accountRs = accountPs.executeQuery();
		    		accountRs.next();
		    		// Display admin commands
		    		if (accountRs.getString("accessLevel").equals("ADMIN")) { %>
		<jsp:include page="adminDashboard.jsp" />

		<%	} 
		    		if (accountRs.getString("accessLevel").equals("CUSTOMER_REP")) { %>
		<jsp:include page="customerRepDashboard.jsp" />
		<%  }
		    		
		    		ps = conn.prepareStatement(auctionQuery);
		    		ps.setString(1, user);
		    		rs = ps.executeQuery();
		    		
		   			
		   			if (rs.next() && accountRs.getString("accessLevel").equals("END_USER")) {
		   		%>
		<h2>Your created auctions:</h2>
		<table>
			<tr>
				<th>Item</th>
				<th>Current Bid</th>
				<th>End Date/Time</th>
			</tr>
			<%	do { %>
			<tr>
				<td><a
					href="auction.jsp?productId=<%= rs.getInt("productId") %>"> <%= rs.getString("brand") + rs.getString("damageCondition")%>
				</a></td>
				<td><%= currency.format(rs.getDouble("price")) %></td>
				<td><%= rs.getString("endDate") %></td>
			</tr>
			<%	} while (rs.next()); %>
		</table>
		<%	} else if (accountRs.getString("accessLevel").equals("END_USER")){ %>
		<h2>You currently have no items for auction.</h2>
		<%	}
    		} catch (SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception ignored) {}
				try { accountRs.close(); } catch (Exception ignored) {}
				try { accountPs.close(); } catch (Exception ignored) {}
				try { ps.close(); } catch (Exception ignored) {}
				try { conn.close(); } catch (Exception ignored) {}
			}	
			%>
	</div>
	<% } %>
</body>
</html>
