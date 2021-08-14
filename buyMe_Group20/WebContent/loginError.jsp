<%@ page language="java"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
    <title>Login Error</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
	<div class="content center">
		<h2>Error: Login failed. Username or password is incorrect.</h2>
		<form action="loginHandler.jsp" method="POST">
			<label><input type="text" name="username" placeholder="Username"></label>
            <br><label><input type="password" name="password" placeholder="Password"></label>
			<br> <input type="submit" value="Login">
		</form>
		<a href="register.jsp">No account? Just register here.</a>
	</div>
</body>
</html>
