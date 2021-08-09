<%@ page language="java"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>BuyMe - Login Error</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<div class="content center">
		<h2>Error: Login failed. Username or password is incorrect.</h2>
		<form action="loginHandler.jsp" method="POST">
			<input type="text" name="username" placeholder="Username"> <br>
			<input type="password" name="password" placeholder="Password">
			<br> <input type="submit" value="Login">
		</form>
		<a href="register.jsp">Don't have an account? Register here.</a>
	</div>
</body>
</html>
