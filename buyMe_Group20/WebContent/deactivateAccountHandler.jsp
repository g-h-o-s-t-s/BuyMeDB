<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String url = "jdbc:mysql://localhost:3306/buyMe";
	Connection conn = null;			
	PreparedStatement ps = null;
	PreparedStatement pwPs = null;
	ResultSet rs = null;
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(url, "root", "UN5AW!]x9K{[bP");
		
		String user = (session.getAttribute("user")).toString();
		String deactivatedAccount = request.getParameter("deactivated_account");
		String yourPassword = request.getParameter("your_password");
		String confirmYourPassword = request.getParameter("confirm_your_password");
	
		// Get the user's row from UserAccount table
		String validation = "SELECT password FROM UserAccount WHERE username=?";
		pwPs = conn.prepareStatement(validation);
		pwPs.setString(1, user);
		rs = pwPs.executeQuery();
		
		// Make sure the user entered the correct current password
		if (rs.next()) {
			String db_password = rs.getString("password");
			if (!yourPassword.equals(db_password)) { %>
<jsp:include page="deactivateAccount.jsp" flush="true" />
<div class="content center">
	<h1>
		<br>Error: Current password is incorrect.<br> You must enter
		your correct password to make these changes.
	</h1>
</div>
<%    	return;
			}
		} else {
			// No account found with the current user's username
			// Should never happen
			response.sendRedirect("error.jsp");
			return;
		}
		
		// Make sure the new password is entered correctly in the confirm box
		if (!yourPassword.equals(confirmYourPassword)) { %>
<jsp:include page="deactivateAccount.jsp" flush="true" />
<div class="content center">
	<h1>
		Error: Failed to confirm new password. <br> Make sure you enter
		it correctly in both fields.
	</h1>
</div>
<%		return;
		} %>

<%	
	
		String query = "UPDATE UserAccount SET active=false WHERE username=?";
		ps = conn.prepareStatement(query);
		ps.setString(1, deactivatedAccount);

		int updateResult = 0;
		updateResult = ps.executeUpdate();
		if (updateResult < 1) {
			// Failed to execute the update statement
			response.sendRedirect("error.jsp");
			return;
		} else { 
	%>
<jsp:include page="deactivateAccount.jsp" flush="true" />
<div class="content center">
	<h1>Successfully deactivated user's account.</h1>
</div>
<% 	}
		
		
	} catch(Exception e) {
		out.print("<p>Error connecting to MYSQL server.</p>");
	    e.printStackTrace();
	} finally {
		try { rs.close(); } catch (Exception ignored) {}
		try { ps.close(); } catch (Exception ignored) {}
		try { pwPs.close(); } catch (Exception ignored) {}
        try { conn.close(); } catch (Exception ignored) {}
	}
%>
