<%@ page pageEncoding="ISO-8859-1"%>
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
			<i>Buy and Sell Your Headphones with
                the friendliest online community!</i>
		</h2>
		<form action="loginHandler.jsp"
              method="POST">
            <label>
                <input type="text" name="username" placeholder="Username">
            </label> <br>
            <label>
                <input type="password" name="password" placeholder="Password">
            </label>
            <br> <input type="submit" value="Login">
		</form>
        <br>
		<a href="register.jsp">No account? Just register here.</a>
	</div>
</body>
</html>
