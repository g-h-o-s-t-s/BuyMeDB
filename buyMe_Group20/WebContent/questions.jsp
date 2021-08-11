<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head><meta charset="utf-8">


<title>Frequently Asked Questions</title>
<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<%	if (request.getParameter("submit") != null && (request.getParameter("submit")).toString().equals("success")) { %>
		<h1>Your question has been submitted successfully.</h1>
		<%	} %>

		<h1>Submit a new question:</h1>
		<form action="questionsHandler.jsp" method="post">
			<textarea style="font-size: 18pt" rows="1" cols="90" maxlength="250"
				id="msg" name="Question"></textarea>
			<br> <input type="submit" value="Submit">
		</form>
		<% 
		String url = "jdbc:mysql://localhost:3306/buyMe";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {   		
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(url, "root", "UN5AW!]x9K{[bP");
			String username = (session.getAttribute("user")).toString();
			String questionsQuery = "SELECT * FROM Questions";
			String check = "Awaiting answer from customer representative";
			
			ps = conn.prepareStatement(questionsQuery);
			rs = ps.executeQuery();
			
			if(rs.next()){ %>
		<h1>Question Results:</h1>
		<p style="font-size: 8pt;">**Please note that all questions may
			not be answered until a customer representative gets a chance to
			answer them**</p>
		<table>
			<tr>
				<th>Question</th>
				<th>Answer</th>
			</tr>
			<% do { %>
			<tr>
				<td><%= rs.getString("question") %></td>
				<% if (check.equals(rs.getString("answer"))
									&& !((session.getAttribute("accessLevel")).toString()).equals("END_USER")) { %>
				<form>
					action="answersHandler.jsp?questionId=<%= rs.getInt("questionId") %>"
					method="POST">
					<td><textarea type="textarea" name="Answer"></textarea> <input
						type="submit" value="Answer"></td>
				</form>
				<% } else { %>
				<td><%= rs.getString("answer") %></td>
				<% } %>
			</tr>
			<% 		} while(rs.next()); %>
		</table>
		<% 	} else { %>
		<br>
		<h2>No questions have been asked.</h2>
		<%	}  %>

		<%
		
		} catch (SQLException e){
			out.print("<p>Error connecting to MYSQL server.</p>");
		    e.printStackTrace();    			
		} finally {
			try { rs.close(); } catch (Exception e) {} 
			try { conn.close(); } catch (Exception e) {} 
		}   		
	%>


	</div>
</body>
</html>
