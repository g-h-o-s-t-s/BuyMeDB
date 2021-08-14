<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	if (session.getAttribute("user") == null) {
		response.sendRedirect("login.jsp");
	} else {
		String connectionUrl = "jdbc:mysql://localhost:3306/buyMe" +
            "?verifyServerCertificate=false&useSSL=true";
		Connection conn = null;			
		PreparedStatement ps1 = null;
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(connectionUrl, "root", "UN5AW!]x9K{[bP");

			int productId = Integer.parseInt(request.getParameter("productId"));
			String sellerAccount = request.getParameter("sellerAccount");
			
			String delete = "DELETE FROM Product WHERE productId=? AND sellerAccount=?";
			ps1 = conn.prepareStatement(delete);
			ps1.setInt(1, productId);
			ps1.setString(2, sellerAccount);
			
			int insertResult = 0;
			insertResult = ps1.executeUpdate();
			if (insertResult < 1) {
				response.sendRedirect("error.jsp"); // This should never happen	
			} else {
				// Auction was successfully deleted %>
<jsp:include page="auction.jsp" flush="true" />
<div class="content center">
	<h1>Auction was successfully deleted.</h1>
</div>
<%	}
		} catch (Exception e) {
			out.print("<p>Error occurred during mySQL server connection.</p>");
		    e.printStackTrace();
		} finally {
			try { ps1.close(); } catch (Exception ignored) {}
	        try { conn.close(); } catch (Exception ignored) {}
		}
	}
%>
