<%@ page pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">
	<title>Account Options</title>
	<link rel="stylesheet" href="style.css"/>
</head>
<body>
	<% if (session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<h1>Account Options</h1>
		<ul>
			<li><a href="alertsListView.jsp">View Product Alerts</a></li>
			<li><a href="alertsList.jsp">Add Product Alert</a></li>
			<li><a href="bidHistory.jsp">View Bidding History</a></li>
			<li><a href="sellingHistory.jsp">View Selling History</a></li>
			<li><a href="buyingHistory.jsp">View Buying History</a></li>
			<li><a href="accountSettings.jsp">Settings</a></li>
		</ul>
	</div>
	<% } %>
</body>
</html>
