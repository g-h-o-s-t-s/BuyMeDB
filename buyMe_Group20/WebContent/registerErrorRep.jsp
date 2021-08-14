<%@ page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
<title>Register Error - Customer Rep</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<div class="content center">
		<h2>Unable to complete registration for Customer Representative.
            Please review the information below.</h2>
		<form action="customerRepHandler.jsp" method="POST">
			<label for="firstName">First Name</label> <input type="text"
				name="firstName" id="firstName" placeholder="First Name">
			<br> <label>Last Name <input type="text"
				name="lastName" placeholder="Last Name"></label>
            <br> <label>Email <input type="text" name="email" placeholder="Email"></label>
			<br> <label for="address">Address <input type="text"
				name="address" placeholder="Address" id="address"></label>
            <br> <label for="username">Username <input type="text" name="username"
				id="username" placeholder="Username"></label>
            <br> <label>Password <input type="password" name="password"
                placeholder="Password"></label>
			<br> <label>Confirm Password <input type="password"
				name="confirm_password" placeholder="Confirm Password"></label> <br>
			<input type="submit" value="Register">
		</form>
	</div>
</body>
</html>
