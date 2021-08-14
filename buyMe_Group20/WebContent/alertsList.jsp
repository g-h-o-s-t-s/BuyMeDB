<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">


<title>Add to AlertsList</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<% if(session.getAttribute("userAccount") == null) {
    	 	response.sendRedirect("login.jsp");
        } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<h2>Specify Item for AlertsList</h2>
		<form action="alertsListHandler.jsp" method="POST">
			<%--@declare id="starting_price"--%><label for="category">Category</label> <select name="category"
				id="category" required>
				<option value="" disabled selected hidden="true">Select
					category</option>
				<option value="In-Ear">In-Ear</option>
				<option value="On-Ear">On-Ear</option>
				<option value="Over-Ear">Over-Ear</option>
				<option value="Wireless">Wireless</option>
			</select> <br> <label for="brand">Brand</label> <select name="brand"
				id="brand" required>
				<option value="" disabled selected hidden="true">Select
					brand</option>
				<option value="Audio-Technica">Audio-Technica</option>
				<option value="Beyerdynamic">Beyerdynamic</option>
				<option value="Bose">Bose</option>
				<option value="Bowers and Wilkins">Bowers and Wilkins</option>
				<option value="JBL">JBL</option>
				<option value="Sennheiser">Sennheiser</option>
				<option value="Sony">Sony</option>
				<option value="Other">Other</option>
			</select> 
			<br> <input type="radio" name="damageCondition" value="Poor" required>
			Poor <br> <input type="radio" name="damageCondition" value="Fair">
			Fair <br> <input type="radio" name="damageCondition" value="Like New">
			Like New <br> <input type="radio" name="damageCondition" value="Original Condition">
			Original Condition <br> 
			<br> <label for="color">Color</label> <input type="text"
				name="color" id="color" placeholder="Enter color(s)" required>
			<br> <label for="starting_price">Max Price</label> <input
				type="number" step="0.01" name="maxPrice" placeholder="0.00"
				min="0.00" required> <br> <input type="submit"
				value="Submit">
		</form>
	</div>
	<% } %>
</body>
</html>
