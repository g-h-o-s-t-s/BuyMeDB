<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">


<title>Register Error</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
	<div class="content center">
		<h2>Unable to complete registration.
            Please review the information below.</h2>
		<form action="registerHandler.jsp" method="POST">
			<label for="firstName">First Name</label> <input type="text"
				name="firstName" id="firstName" placeholder="First Name">
			<br> <label>Last Name</label> <input type="text"
				name="lastName" placeholder="Last Name"> <br> <label>Email</label>
			<input type="text" name="email" placeholder="Email"> <br>

			<label for="Address">Address</label> <input type="text"
				name="address" placeholder="Address"> <br> <label
				for="username">Username</label> <input type="text" name="username"
				id="username" placeholder="Username"> <br> <label>Password</label>
			<input type="password" name="password" placeholder="Password">
			<br> <label>Confirm Password</label> <input type="password"
				name="confirm_password" placeholder="Confirm Password"> <br>

			<input type="submit" value="Register">
		</form>
	</div>

</body>
</html>
