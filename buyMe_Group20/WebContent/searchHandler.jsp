<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>


<title>BuyMe - Search Results</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<% if(session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">

		<%	
			ArrayList<String> paramList = new ArrayList<String>();
			Map<String, String> searchParams = new HashMap<String, String>();
			int index = 0;
			for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
				//paramList.add(params.nextElement());
				String paramName = params.nextElement();
				String paramValue = request.getParameter(paramName);
				if (!paramValue.isEmpty() && paramValue != null) {
					paramList.add(paramName);
					//System.out.println(paramList.get(index));
					//System.out.println(paramValue);
					if ((paramList.get(index)).equals("gender")) {
						String genderFixed = paramValue.replace("'", "\\'");
						searchParams.put(paramList.get(index), genderFixed);
					} else {				
						searchParams.put(paramList.get(index), paramValue);
					}
					index++;
				}
			}
			
			Locale locale = new Locale("en", "US");
			NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
			
			String url = "jdbc:mysql://localhost:3306/buyMe";
			Connection conn = null;
			Statement s = null;
			ResultSet rs = null;
				
			try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(url, "root", "UN5AW!]x9K{[bP");
				
					
				StringBuilder searchQuery = new StringBuilder("SELECT * FROM Product WHERE ");
				String condition = null;
				for (int i = 0; i < searchParams.size(); i++) {
					// Check for numeric parameter so we can format the SQL query correctly
					if ((paramList.get(i)).equals("size")) {
						condition = paramList.get(i) + " LIKE " + searchParams.get(paramList.get(i));
					} else if ((paramList.get(i)).equals("color")) {
						condition = paramList.get(i) + " LIKE \'%" + searchParams.get(paramList.get(i)) + "%\'";
					} else {
						condition = paramList.get(i) + " LIKE \'" + searchParams.get(paramList.get(i)) + "\'";	
					}
					// Only want to include AND when we have more than one parameter
					if (i == 0) {
						searchQuery.append(condition);	
					} else if (i > 0) {
						searchQuery.append(" AND " + condition);
					}	
				}
				//System.out.println(searchQuery);
				s = conn.createStatement();
				rs = s.executeQuery(searchQuery.toString());
				if (rs.next()) { %>
		<h2>Displaying search results:</h2>
		<table>
			<tr>
				<th>Item</th>
				<th>Seller</th>
				<th>Current Bid</th>
				<th>End Date/Time</th>
			</tr>
			<%	do { %>
			<tr>
				<td><a
					href="auction.jsp?productId=<%= rs.getInt("productId") %>"> <%= rs.getString("brand") + " " + rs.getString("model") + " " + rs.getString("gender") +  " " + rs.getFloat("size") %>
				</a></td>
				<td><%= rs.getString("sellerAccount") %></td>
				<td><%= currency.format(rs.getDouble("price")) %></td>
				<td><%= rs.getString("endDate") %></td>
			</tr>
			<%	} while (rs.next()); %>
		</table>
		<%	} else { %>
		<h2>No results matching your search parameters.</h2>
		<%	}		
					
			} catch(Exception e) { %>
		<jsp:include page="search.jsp" flush="true" />
		<div class="content center">
			<h1>Error: You must enter at least one search parameter.</h1>
		</div>
		<%	//User did not enter at least one search parameter
			    e.printStackTrace();
			} finally {
			    try { rs.close(); } catch (Exception e) {}
			    try { s.close(); } catch (Exception e) {}
			    try { conn.close(); } catch (Exception e) {}
			}
		%>
	</div>
	<% } %>
</body>
</html>
