<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Success</title>
</head>
<body>
	<%
	    if ((session.getAttribute("user") == null)) {
	%>
	You are not logged in<br/>
	<a href="login.jsp">Please Login</a>
	<%} else {
	%>
	Welcome <%=session.getAttribute("user")%>  
	<a href='logout.jsp'>Log out</a>
	<%
	    }
	%>
</body>
</html>