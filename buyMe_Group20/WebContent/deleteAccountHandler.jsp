<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String connectionUrl = "jdbc:mysql://localhost:3306/buyMe" +
            "?verifyServerCertificate=false&useSSL=true";
	Connection conn = null;			
	PreparedStatement ps = null;
	PreparedStatement pwPs = null;
	ResultSet rs = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(connectionUrl, "root", "UN5AW!]x9K{[bP");
		
		String user = (session.getAttribute("user")).toString();
		String deactivatedAccount = request.getParameter("deactivated_account");
		String yourPassword = request.getParameter("your_password");
		String confirmYourPassword = request.getParameter("confirmPassword");
	
		// Get the user's row from UserAccount table
		String validation = "SELECT password FROM UserAccount WHERE username=?";
		pwPs = conn.prepareStatement(validation);
		pwPs.setString(1, user);
		rs = pwPs.executeQuery();
		
		// Make sure the user entered the correct current password
		if (rs.next()) {
			String db_password = rs.getString("password");
			//reset the text box
			if (!yourPassword.equals(db_password)) { %>
                <jsp:include page="deleteAccount.jsp" flush="true" />
                <div class="content center">
                    <h1>
                        <br>Password was incorrect, please double-check.
                    </h1>
                </div>
                <%  return;
			}
		} else {
			// No account under this Rep's username, unlikely event
			response.sendRedirect("error.jsp");
			return;
		}
		
		// Make sure the new password is entered correctly in the confirm box
		if (!yourPassword.equals(confirmYourPassword)) { %>
            <jsp:include page="deleteAccount.jsp" flush="true" />
            <div class="content center">
                <h1> Passwords did not match for confirmation. </h1>
            </div>
            <%  return;
		} %>

<%	
	
		String query = "DELETE FROM UserAccount WHERE username=?";
		ps = conn.prepareStatement(query);
		ps.setString(1, deactivatedAccount);

		int updateResult;
		updateResult = ps.executeUpdate();
		if (updateResult < 1) {
			// Failed to execute the update statement
			response.sendRedirect("error.jsp");
			return;
		} else { 
        %>
        <jsp:include page="deleteAccount.jsp" flush="true" />
        <div class="content center">
            <h1>Successfully wiped user's account.</h1>
        </div>
        <% 	}

	} catch (Exception e) {
		out.print("<p>Error occurred during mySQL server connection.</p>");
	    e.printStackTrace();
	} finally {
		try {
            assert rs != null;
            rs.close(); } catch (Exception ignored) {}
		try {
            assert ps != null;
            ps.close(); } catch (Exception ignored) {}
		try { pwPs.close(); } catch (Exception ignored) {}
        try { conn.close(); } catch (Exception ignored) {}
	}
%>
