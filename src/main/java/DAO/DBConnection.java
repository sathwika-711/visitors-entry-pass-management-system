package DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/visitor_pass";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root123";
    
    // Method to get the database connection
    public static Connection getConnection() {
        Connection con = null;
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver loaded successfully");

            // Establish the connection
            System.out.println("Attempting to connect to database: " + DB_URL);
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Database connection established successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("Error: MySQL JDBC Driver not found");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Error in DBConnection: " + e.getMessage());
            System.err.println("Please check if:");
            System.err.println("1. MySQL server is running");
            System.err.println("2. Database 'visitor_pass' exists");
            System.err.println("3. Username and password are correct");
            System.err.println("4. MySQL server is accessible on localhost:3306");
            e.printStackTrace();
        }
        return con;
    }
}
