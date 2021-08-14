package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {

	public ApplicationDB() {

	}

	@SuppressWarnings("deprecation")
	public Connection getConnection(){
		
		//Second line allows for suppression of SSL-related errors in console
		String connectionUrl = "jdbc:mysql://localhost:3306/buyMe" +
                "?verifyServerCertificate=false&useSSL=true";
		Connection connection = null;
		
		try {
			//Load JDBC driver, look through
            // WEB-INF\lib for a mysql connector jar file,
			// otherwise failure.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException
                | ClassNotFoundException
                | IllegalAccessException e) {
			e.printStackTrace();
		}
        try {
			//Create a connection to your DB
			connection = DriverManager.getConnection(connectionUrl,"root", 
					"UN5AW!]x9K{[bP");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return connection;
		
	}

	public void closeConnection(Connection connection) {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		ApplicationDB dao = new ApplicationDB();
		Connection connection = dao.getConnection();

		System.out.println(connection);
		dao.closeConnection(connection);
	}

}
