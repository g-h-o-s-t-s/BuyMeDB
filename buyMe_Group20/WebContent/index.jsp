<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
   <head>
      <title>buyMe - Login</title>
    <link rel="stylesheet" href="css/styles.css"/>
   </head>
   
   <body>
     <form action="verifyLogin.jsp" method="POST">
       User<span class="tab"></span><input type="text" name="username"/> <br/>
       Password<span class="tab"></span>
       <input type="password" name="password"/> <br/>
       
       <input type="submit" value="Submit"/>
     </form>
   </body>
</html>