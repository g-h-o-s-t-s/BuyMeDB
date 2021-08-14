<%--suppress deprecation --%>
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
	
		// Get the parameters from the login request
		String username = request.getParameter("username");
		System.out.println(username);
		String password = request.getParameter("password");
        System.out.println(password);
		
		if (username != null && password != null) {
			String validation = "SELECT * FROM UserAccount WHERE username=?";
			ps = conn.prepareStatement(validation);
			ps.setString(1, username);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				String db_password = rs.getString("password");
				if (password.equals(db_password)) {
					session.setAttribute("user", username);
					session.setAttribute("accessLevel", rs.getString("accessLevel"));
					session.setAttribute("firstName", rs.getString("firstName"));
					response.sendRedirect("index.jsp");
					System.out.println("redirect to index from loginHandler");
                } else response.sendRedirect("loginError.jsp");
            } else response.sendRedirect("loginError.jsp");
        } else response.sendRedirect("loginError.jsp");
        return;

    } catch (Exception e) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        e.printStackTrace();
    } finally {
    	try {
            assert rs != null;
            rs.close(); } catch (Exception ignored) {}
        try { ps.close(); } catch (Exception ignored) {}
        try { conn.close(); } catch (Exception ignored) {}
    }

%>
