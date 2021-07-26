<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>buyMe - Login</title>
<link rel="stylesheet" href="css/styles.css" />
</head>

<body>
	<%
	    String userid = request.getParameter("username");   
	    String pwd = request.getParameter("password");
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection(
	    		"jdbc:mysql://localhost:3306/database20","root", "UN5AW!]x9K{[bP");
	    Statement st = con.createStatement();
	    ResultSet rs;
	    rs = st.executeQuery("select * from UserAccount where username='" + userid +
	    		"' and pass='" + pwd + "'");
	    if (rs.next()) {
	        session.setAttribute("user", userid);
	        out.println("welcome " + userid);
	        out.println("<a href='logout.jsp'>Log out</a>");
	        response.sendRedirect("success.jsp");
	    } else {
	        out.println("Invalid password <a href='index.jsp'>try again</a>");
	    }
	%>
</body>
</html>