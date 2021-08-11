<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>


<title>BuyMe - Sales Reports</title>
<link rel="stylesheet" href="style.css" />
</head>
<body>
	<% if(session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else {
    	   String accessLevel = session.getAttribute("accessLevel").toString();
    	   if (!accessLevel.equals("ADMIN")) {
				response.sendRedirect("index.jsp");
				return;
    	   } %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<h2>Select a sales report to generate</h2>
		<ul>
			<li><a href="salesReportHandler.jsp?type=totalEarnings">Total
					Earnings</a></li>
			<li><a href="salesReportHandler.jsp?type=earningsPerItem">Earnings
					per item</a></li>
			<li><a href="salesReportHandler.jsp?type=earningsPerItemType">Earnings
					per item type</a></li>
			<li><a href="salesReportHandler.jsp?type=earningsPerEndUser">Earnings
					per end-user</a></li>
			<li><a href="salesReportHandler.jsp?type=bestSelling">Best-selling
					items</a></li>
			<li><a href="salesReportHandler.jsp?type=bestBuyers">Best
					buyers</a></li>
		</ul>
	</div>
	<% } %>
</body>
</html>
