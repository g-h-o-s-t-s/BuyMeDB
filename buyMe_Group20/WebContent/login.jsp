<%@ page language="java"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
<title>BuyMe - Login</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
	<div class="content center">
		<h1 style="font-size: 400%;">BuyMe</h1>
		<h2>
			<i>Buy and Sell Your Products with the friendliest online community!</i>
		</h2>
		<form action="loginHandler.jsp" method="POST">
			<input type="text" name="username" placeholder="Username"> <br>
			<input type="password" name="password" placeholder="Password">
			<br> <input type="submit" value="Login">
		</form>
		<a href="register.jsp">Don't have an account? Register here.</a>
	</div>
</body>
</html>
