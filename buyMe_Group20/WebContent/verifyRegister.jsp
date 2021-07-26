<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC>
<html>
<head>
<title>Registry Verification</title>
</head>
<body>
	<%
		try {
			//Get the database connection, SQL statement
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			Statement stmt = con.createStatement();
			
			//Parsing form input
			String email = request.getParameter("email");
			String username = request.getParameter("username");
			String pass = request.getParameter("password");
			String confirm = request.getParameter("checkpassword");
			String firstName = request.getParameter("fname");
			String lastName = request.getParameter("lname");
			
			if (email.isEmpty() || pass.isEmpty()) {
				out.print("<p>Email and/or Password left blank.</p>");
			} else if (pass.equals(confirm)) {
				String insert1 = "INSERT INTO UserAccount values (?, ?, ?, ?, ?);";
				
				//Statement object to execute the query
				PreparedStatement ps = con.prepareStatement(insert1);

				//Match query params to statement
				ps.setString(1, email);
				ps.setString(2, username);
				ps.setString(3, pass);
				ps.setString(4, firstName);
				ps.setString(5, lastName);

				//Run SQL Query
				ps.executeUpdate();
				out.print("<p>Account creation successful.</p>");
			} else {
				out.print("<p>Account creation failure. Please check input.</p>");
			}
			
			//close the connection
			con.close();
		} catch (Exception ex) {	}
	%>
	<form method="post" action="index.jsp">
		<input type="submit" value="Back to Home"><br>
	</form>
</body>
</html>
