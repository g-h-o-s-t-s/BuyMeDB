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

		<% 
		
		String url = "jdbc:mysql://localhost:3306/buyMe";
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {   		
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(url, "root", "UN5AW!]x9K{[bP");
			String username = (session.getAttribute("user")).toString();
			String questionsQuery = "SELECT question, answer FROM Questions WHERE user=?";
			
			ps = conn.prepareStatement(questionsQuery);
			ps.setString(1, username);
			rs = ps.executeQuery();
			
			if(rs.next()){ %>
		<h1>Question Results:</h1>
		<p style="font-size: 8pt;">**Please note that all questions may
			not be answered until a customer representative gets a chance to
			answer them.**</p>
		<table>
			<tr>
				<th>Question</th>
				<th>Answer</th>
			</tr>
			<% do { %>
			<tr>
				<td><%= rs.getString("question") %></td>
				<td><%= rs.getString("answer") %></td>
			</tr>
			<% 		} while(rs.next()); %>
		</table>
		<% 	} else { %>
		<br>
		<h3>There are currently no answers.</h3>
		<%	}  %>

		<%
		
		} catch (SQLException e){
			out.print("<p>Error connecting to MYSQL server.</p>");
		    e.printStackTrace();    			
		} finally {
			try { rs.close(); } catch (Exception ignored) {}
			try { conn.close(); } catch (Exception ignored) {}
		}   		
	%>
		<p>
			<a href="questions.jsp">Click here to return to ask another
				questions</a>
		</p>
	</div>
</body>
</html>
