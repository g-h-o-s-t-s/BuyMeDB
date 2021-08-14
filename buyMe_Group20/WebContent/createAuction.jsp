<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">


<title>Create Auction</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<% if (session.getAttribute("user") == null) {
    	 	response.sendRedirect("login.jsp");
        } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<form action="createAuctionHandler.jsp" method="POST">
			<label for="category">Select Category <select name="category"
				id="category" required>
				<option value="In-Ear">In-Ear</option>
				<option value="On-Ear">On-Ear</option>
				<option value="Over-Ear">Over-Ear</option>
				<option value="Wireless">Wireless</option>
			</select></label>
            <br> <label for="brand">Select Brand <select name="brand"
				id="brand" required>
				<option value="Audio-Technica">Audio-Technica</option>
				<option value="Beyerdynamic">Beyerdynamic</option>
				<option value="Bose">Bose</option>
				<option value="Bowers and Wilkins">Bowers and Wilkins</option>
				<option value="JBL">JBL</option>
				<option value="Sennheiser">Sennheiser</option>
				<option value="Sony">Sony</option>
				<option value="Other">Other</option>
			</select></label>
			<br> <label>Poor <input type="radio" name="damageCondition"
                value="Poor" required></label>
            <br> <label>Fair <input type="radio" name="damageCondition" value="Fair"></label>
			<br> <label>Like New <input type="radio" name="damageCondition"
                value="Like New"></label>
            <br> <label>Original Condition <input type="radio" name="damageCondition"
                value="Original Condition"></label>
			<br> <label for="color">Color <input type="text"
				name="color" id="color" placeholder="Enter color(s)" required></label>
			<br> <label for="start_datetime">Start Date and Time <input
				type="datetime-local" name="start_datetime" id="start_datetime"
				placeholder="mm/dd/yyyy --:-- --" required></label> <br>

			<!-- RESTRICT HOURS TO WHOLE HOURS -->
			<label for="end_datetime">End Date and Time</label> <input
				type="datetime-local" name="end_datetime" id="end_datetime"
				placeholder="mm/dd/yyyy --:-- --" required> <br> <label
				for="min_price">Minimum Bid Price (hidden from bidders) <input
				type="number" step="0.01" name="min_price" placeholder="0.00"
				min="0.00" id="min_price" required></label>
            <br> <label for="starting_price">Starting Bid Price <input type="number"
                step="0.01" name="starting_price" id="starting_price"
				placeholder="0.00" min="0.00" required></label>
            <br> <input type="submit" value="Submit">
		</form>
	</div>
	<% } %>
</body>
</html>
