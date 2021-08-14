<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
<title>Search</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<% if (session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<h2>Select at least one search parameter</h2>
		<form action="searchHandler.jsp" method="GET">
			<label for="category">Select Category</label> <select name="category"
				id="category" required>
				<option value="In-Ear">In-Ear</option>
				<option value="On-Ear">On-Ear</option>
				<option value="Over-Ear">Over-Ear</option>
				<option value="Wireless">Wireless</option>
			</select> <br> <label for="brand">Select Brand</label> <select name="brand"
				id="brand" required>
				<option value="Audio-Technica">Audio-Technica</option>
				<option value="Beyerdynamic">Beyerdynamic</option>
				<option value="Bose">Bose</option>
				<option value="Bowers and Wilkins">Bowers and Wilkins</option>
				<option value="JBL">JBL</option>
				<option value="Sennheiser">Sennheiser</option>
				<option value="Sony">Sony</option>
				<option value="Other">Other</option>
			</select>
            <br> <label>Poor <input type="radio" name="damageCondition"
                value="Poor" required></label>
            <br> <label>Fair <input type="radio" name="damageCondition" value="Fair"></label>
            <br> <label>Like New <input type="radio" name="damageCondition"
                value="Like New"></label>
            <br> <label>Original Condition <input type="radio" name="damageCondition"
                value="Original Condition"></label>
			<br> <label for="color">Color</label> <input type="text"
				name="color" id="color" placeholder="Enter color(s)" required>
				<br> <input type="submit" value="Search">
		</form>
	</div>
	<% } %>
</body>
</html>
