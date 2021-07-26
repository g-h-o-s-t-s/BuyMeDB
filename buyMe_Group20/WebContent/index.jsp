<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/styles.css"/>
<title>Registry Page</title>
</head>
<body>
	<div id="frame">
		<form method="post" action="verifyRegister.jsp">
			<table id="register">
			<tr>    
			<td>Email: </td><td><input type="text" name="email"></td>
			</tr>
			<tr>
			<td>Username: </td><td><input type="text" name="username"></td>
			</tr>
			<tr>
			<td>Password: </td><td><input type="password" name="password"></td>
			</tr>
			<tr>
			<td>Confirm Password: </td><td><input type="password" name="cpassword"></td>
			</tr>
			<tr>
			<td>First Name: </td><td><input type="text" name="fname"></td>
			</tr>
			<tr>
			<td>Last Name: </td><td><input type="text" name="lname"></td>
			</tr>
			</table>
			<br>
			<input type="submit" value="Register" class="button">
		</form>
		<form method="post" action="login.jsp">
			<input type="submit" value="Back to log in" class="button">
		</form>
	</div>
</body>
</html>
