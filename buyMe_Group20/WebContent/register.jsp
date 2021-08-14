<%@ page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
<title>BuyMe - Register</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<div class="content center">
		<form action="registerHandler.jsp" method="POST">
			<label for="firstName">First Name <input type="text"
				name="firstName" id="firstName" placeholder="John"></label>
			<br> <label>Last Name <input type="text"
                name="lastName" placeholder="Doe"></label>
            <br> <label>Email <input type="text" name="email" placeholder="x@y.z"></label>
            <br> <label for="address">Address <input type="text"
				name="address" placeholder="123 Tomcat Lane" id="address"></label>
            <br> <label for="username">Username <input type="text" name="username"
				id="username" placeholder=""></label>
            <br> <label>Password <input type="password"
                name="password" placeholder=""></label>
			<br> <label>Confirm Password <input type="password"
				name="confirm_password" placeholder=""></label> <br>

			<input type="submit" value="Register">
		</form>
	</div>

</body>
</html>
