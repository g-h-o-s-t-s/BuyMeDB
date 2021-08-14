<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String connectionUrl = "jdbc:mysql://localhost:3306/buyMe" +
            "?verifyServerCertificate=false&useSSL=true";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(connectionUrl, "root", "UN5AW!]x9K{[bP");
		
		// Get the parameters from the createAuction request
		String category = request.getParameter("category");
		String brand = request.getParameter("brand");
		String damageCondition = request.getParameter("damageCondition");
		String color = request.getParameter("color");
		String user = (session.getAttribute("user")).toString();
		float maxPrice = Float.parseFloat(request.getParameter("maxPrice"));
		
		// Make sure all the fields are entered
		if(category != null  && !category.isEmpty()
				&& brand != null && !brand.isEmpty() 
				&& color != null && !color.isEmpty()
				&& maxPrice >= 0.0f) {
			
		// Build the SQL query with placeholders for parameters
			String insert = "INSERT INTO AlertsList (userAcc, category, brand, damageCondition, color, maxPrice)"
					+ "VALUES(?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(insert);
		
			// Add parameters to query
			//ps.setString(1, name);
			ps.setString(1, user);
			ps.setString(2, category);
			ps.setString(3, brand);
			ps.setString(4, damageCondition);
			ps.setString(5, color);
			ps.setFloat(6, maxPrice);
			
			int result = 0;
	        result = ps.executeUpdate();
	        if (result < 1) {
	        	out.println("Error: Failed to add item to AlertsList.");
	        } else { %>
<jsp:include page="alertsListView.jsp" />
<div class="content">
	<h2>Successfully added item to AlertsList.</h2>
</div>
<% }
		} else {
			response.sendRedirect("createAuctionError.jsp"); //error
			return;
		}
	} catch(Exception e) {
        response.sendRedirect("createAuctionError.jsp"); // MySql error such as Start Date before End Date
        e.printStackTrace();
    } finally {
        try { ps.close(); } catch (Exception ignored) {}
        try { conn.close(); } catch (Exception ignored) {}
    }

%>
