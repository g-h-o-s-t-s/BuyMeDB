<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String url = "jdbc:mysql://localhost:3306/buyMe";
	Connection conn = null;
	PreparedStatement ps = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(url, "root", "UN5AW!]x9K{[bP");
		
		// Get the parameters from the register request
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		int accessLevel = 1;
		
		// Check if username already exists in the Account table
		// if it exists, redirect to registerError.jsp, adding some code to let them know the username is taken already
		// if it does not exist, proceed
		
		// Make sure all the fields are entered
		if(firstName != null  && !firstName.isEmpty()
				&& lastName != null && !lastName.isEmpty() 
				&& email != null && !email.isEmpty()
				&& address != null && !address.isEmpty()
				&& username != null && !username.isEmpty()
				&& password != null && !password.isEmpty()) {
			
			// Build the SQL query with placeholders for parameters
			String insert = "INSERT INTO Account (username, password, email, first_name, last_name, address, active, access_level)"
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(insert);
			
			// Add parameters to query
			ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3, email);
			ps.setString(4, firstName);
			ps.setString(5, lastName);
			ps.setString(6, address);
			ps.setBoolean(7, true);
			ps.setInt(8, accessLevel);
			
			int result = 0;
	        result = ps.executeUpdate();
	        if (result < 1) {
	        	out.println("Error: Registration failed.");
	        } else {
	        	response.sendRedirect("registerSuccess.jsp");
	        	return;
	        }
		} else {
			response.sendRedirect("registerError.jsp");
			return;
		}
	} catch(Exception e) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        e.printStackTrace();
    } finally {
        try { ps.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
    }

%>
